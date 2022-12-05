import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:degue_locator/auth/auth.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.value.text,
        password: _controllerPassword.value.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.value.text,
        password: _controllerPassword.value.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextFormField(
      //autofocus: true,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: "E-mail",
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
    );
  }


  Widget _passwordField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      //autofocus: true,
      //keyboardType: TextInputType.text,
      obscureText: true, //escode texto da senha
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: "Senha",
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
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed:
      isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin
            ? 'Não tem cadastro? Cadastre-se aqui'
            : 'Possui Login? Acesso por aqui',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white60,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: const Color.fromRGBO(36, 45, 57, 1),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(
              height: 30,
            ),
            _entryField('E-mail', _controllerEmail),
            _passwordField('Password', _controllerPassword),
            _errorMessage(),
            const Padding(padding: EdgeInsets.all(12)),
            _submitButton(),
            const Padding(padding: EdgeInsets.all(8)),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: _loginOrRegisterButton(),
            ),
          ],
        ),
      ),
    );
  }
}
