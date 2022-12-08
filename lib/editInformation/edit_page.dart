import 'package:degue_locator/dbo/firebase_connection.dart';
import 'package:degue_locator/map/mapScreen.dart';
import 'package:degue_locator/model/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
        title: Text('Editar ' + widget.locationModel.description),
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
            const Padding(padding: EdgeInsets.all(8)),
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: "Descrição",
                labelStyle: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white60,
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Descreva um foco em poucas palavras",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
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
                "Anexos:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                ),
              ),
            ),
            Container(
                width: 100.00,
                height: 100.00,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.fitHeight,
                  ),
                )),
            const Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Confirmar'),
              onPressed: () {
                updateDengueLocalization(widget.locationModel.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(8)),
          ],
        ),
      ),
    );
  }

  updateDengueLocalization(String? id) async {
    try {
      var response = await FirebaseCrud.updateLocalization(
          uid: id,
          description: descriptionController.text,
          criticality: criticality,
          image: image,
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
