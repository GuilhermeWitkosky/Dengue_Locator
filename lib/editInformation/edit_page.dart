import 'package:degue_locator/dbo/firebase_connection.dart';
import 'package:degue_locator/map/mapScreen.dart';
import 'package:degue_locator/model/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditPage extends StatefulWidget {
  final LocationModel locationModel;

  const EditPage({Key? key, required this.locationModel}) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var descriptionController = TextEditingController();
  var criticality = 0;
  var image = '';
  var date = DateTime.now();
  var longitude = 0.0;
  var latitude = 0.0;
  var id = null;

  bool _firstButton = true;
  bool _secondButton = false;
  bool _thirdButton = false;

  bool _done = false;

  String _statusText = 'Pendente';
  String url =
      'https://rafaturis.com.br/wp-content/uploads/2014/01/default-placeholder.png';

  @override
  void initState() {
    final ref =
        FirebaseStorage.instance.ref().child(widget.locationModel.image);
    // TODO: implement initState
    descriptionController =
        TextEditingController(text: widget.locationModel.description);

    criticality = widget.locationModel.criticality;
    longitude = widget.locationModel.longitude;
    latitude = widget.locationModel.latitude;
    id = widget.locationModel.uid;
    if (criticality == 0) {
      _alternaFirstButton();
    } else if (criticality == 1) {
      _alternaSecondButton();
    } else {
      _alternaThirdButton();
    }
    loadUrl();
    super.initState();
  }

  void loadUrl() async {
    final ref =
        FirebaseStorage.instance.ref().child(widget.locationModel.image);
    await ref.getDownloadURL().then((value) => setState(() {
          url = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.locationModel.description),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(36, 45, 57, 1),
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(36, 45, 57, 1),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "Criado em ${DateFormat.yMMMd().format(widget.locationModel.date.toDate())} por ${widget.locationModel.user}",
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Center(
              child: ListTile(
                title: Text(
                  _statusText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                leading: Switch(
                  value: _done,
                  onChanged: (value) {
                    setState(() {
                      _done = value;
                      _statusText = _done ? 'Resolvido' : 'Pendente';
                    });
                  },
                  activeTrackColor: const Color.fromRGBO(255, 63, 84, 0.5),
                  activeColor: const Color.fromRGBO(255, 63, 84, 1),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Criticidade:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _firstButton
                          ? Colors.white
                          : const Color.fromRGBO(255, 63, 84, 1),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Baixo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _firstButton
                            ? const Color.fromRGBO(255, 63, 84, 1)
                            : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      criticality = 0;
                      _alternaFirstButton();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _secondButton
                          ? Colors.white
                          : Color.fromRGBO(255, 63, 84, 1),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Médio',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _secondButton
                            ? Color.fromRGBO(255, 63, 84, 1)
                            : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      criticality = 1;
                      _alternaSecondButton();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _thirdButton
                          ? Colors.white
                          : Color.fromRGBO(255, 63, 84, 1),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Alto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _thirdButton
                            ? Color.fromRGBO(255, 63, 84, 1)
                            : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      criticality = 2;
                      _alternaThirdButton();
                    },
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Imagem:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Container(
                width: 250,
                height: 250,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text('Confirmar'),
          onPressed: () {
            if (_done) {
              deleteDengueLocalization(widget.locationModel.uid);
            } else {
              updateDengueLocalization(widget.locationModel.uid);
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(36, 45, 57, 1),
    );
  }

  deleteDengueLocalization(String? uid) async {
    try {
      var response = await FirebaseCrud.deleteLocalization(uid: uid);

      if (response.cod != 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      }
    } catch (e) {}
  }

  updateDengueLocalization(String? id) async {
    try {
      var response = await FirebaseCrud.updateLocalization(
          uid: id,
          description: descriptionController.text,
          criticality: criticality,
          date: date,
          longitude: longitude,
          latitude: latitude,
          status: 'closed');

      if (response.cod != 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      }
    } catch (e) {}
  }

  Widget button(IconData icon, Alignment alignment) {
    //Color color = state ? Colors.grey : Color.fromRGBO(255, 63, 84, 1);
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 63, 84, 1),
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _alternaFirstButton() {
    setState(() => _firstButton = true);
    setState(() => _secondButton = false);
    setState(() => _thirdButton = false);
  }

  _alternaSecondButton() {
    setState(() => _firstButton = false);
    setState(() => _secondButton = true);
    setState(() => _thirdButton = false);
  }

  _alternaThirdButton() {
    setState(() => _firstButton = false);
    setState(() => _secondButton = false);
    setState(() => _thirdButton = true);
  }
}
