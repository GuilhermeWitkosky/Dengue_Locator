// ignore_for_file: prefer_final_fields
import 'dart:io';

import 'package:degue_locator/map/mapSelectPosition.dart';
import 'package:degue_locator/registration/teste.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController descriptionController = TextEditingController();
  int criticality = 0;
  DateTime date = DateTime.now();
  double longitude = 0.0;
  double latitude = 0.0;
  String image = '';

  bool _firstButton = true;
  bool _secondButton = false;
  bool _thirdButton = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'img/$fileName';
    print('PATH => $destination');
    setState(() {
      image = destination + '/file';
    });

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('/file');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

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
            const Padding(padding: EdgeInsets.all(6)),
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffFDCF09),
                child: _photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _photo!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
            /*ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
                padding: const EdgeInsets.all(13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Upload'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageUploads()),
                );
              },
            ),*/
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
                          criticality: criticality,
                          status: 'open')),
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
