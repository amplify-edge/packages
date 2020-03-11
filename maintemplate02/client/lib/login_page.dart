import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_module.dart';

class LoginPage extends StatelessWidget {
  final String user;

  const LoginPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        height: 300,
        width: 300,
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("LoginPage"),
            Text("User: $user"),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: () => Modular.to
                  .pushNamed("${Routes.login}/${Random().nextInt(10000)}"),
            ),
          ],
        ),
      )),
    );
  }
}
