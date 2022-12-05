import 'package:degue_locator/auth/auth.dart';
import 'package:degue_locator/registration/cadastro_page.dart';
import 'package:degue_locator/login/login_page.dart';
import 'package:degue_locator/map/mapScreen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MapScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }

}
