// ignore_for_file: prefer_final_fields
import 'package:degue_locator/map/mapSelectPosition.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  var descriptionController = TextEditingController();
  var criticality = 0;
  var image = '';
  var date = DateTime.now();
  var longitude = 0.0;
  var latitude = 0.0;

  bool _firstButton = true;
  bool _secondButton = false;
  bool _thirdButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar foco'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(36, 45, 57, 1),
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(36, 45, 57, 1),
        padding: const EdgeInsets.only(
          top: 30,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              controller: descriptionController,
              //autofocus: true,
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
            const Padding(padding: EdgeInsets.all(12)),
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
                      padding: const EdgeInsets.all(12),
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
                  const Padding(padding: EdgeInsets.all(18)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _secondButton
                          ? Colors.white
                          : Color.fromRGBO(255, 63, 84, 1),
                      padding: const EdgeInsets.all(12),
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
                  const Padding(padding: EdgeInsets.all(18)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _thirdButton
                          ? Colors.white
                          : Color.fromRGBO(255, 63, 84, 1),
                      padding: const EdgeInsets.all(12),
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
            const Padding(padding: EdgeInsets.all(12)),
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
            const Padding(padding: EdgeInsets.all(12)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
                padding: const EdgeInsets.all(13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Confirmar localização'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapScreen2(
                          description: descriptionController.text,
                          image: image,
                          date: date,
                          criticality: criticality)),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(8)),
          ],
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
}
