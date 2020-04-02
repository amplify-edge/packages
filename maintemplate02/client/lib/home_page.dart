import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_module.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  ModuleWidget test;
    return Scaffold(
      body: Center(
          child: Container(
       
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("HomePage"),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: () => Modular.to.pushNamed("${Routes.login}/test"),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text("ResponsiveScaffold"),
              onPressed: () => Modular.to
                  .pushNamed("${Routes.responsiveScaffold}/${Random().nextInt(20)}"),
            ),
            RaisedButton(
              child: Text("MasterDetailPage"),
              onPressed: () => Modular.to
                  .pushNamed("${Routes.masterDetail}/details/${Random().nextInt(20)}"),
            ),
            RaisedButton(
              child: Text("CustomMasterDetailPage"),
              onPressed: () => Modular.to
                  .pushNamed("${Routes.customMasterDetail}"),
            ),
            RaisedButton(
              child: Text("CustomMasterDetailPage specific item"),
              onPressed: () => Modular.to
                  .pushNamed("${Routes.customMasterDetail}/details/${Random().nextInt(19)}"),
            ),
             RaisedButton(
              child: Text("Router Outlet"),
              onPressed: () => Modular.to
                  .pushNamed(Routes.routerOutlet),
            ),
          ],
        ),
      )),
    );
  }
}
