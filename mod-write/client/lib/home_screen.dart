import 'package:flutter/material.dart';
import 'package:mod_write/mod_write.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final nav = Navigator.of(context, rootNavigator: false);
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        /*RaisedButton(
          onPressed: () => nav.pushNamed(ModWriterModule.fullPageRoute),
          /*onPressed: () => nav.push(MaterialPageRoute(
            settings: RouteSettings(name: "Full page edit"),
            builder: (context) => FullPageEditorScreen(),
          )),*/
          child: Text('Full page editor'),
        ),
        RaisedButton(
          /* onPressed: () => nav.push(MaterialPageRoute(
            settings: RouteSettings(name: "form"),
            builder: (context) => FormEmbeddedScreen(),
          )),*/
          onPressed: () => nav.pushNamed(ModWriterModule.formRoute),
          child: Text('Embedded in a form'),
        ),
        RaisedButton(
          /*onPressed: () => nav.push(MaterialPageRoute(
            settings: RouteSettings(name: "view"),
            builder: (context) => ViewScreen(),
          )),*/
          onPressed: () => nav.pushNamed(ModWriterModule.viewRoute),
          child: Text('Read-only embeddable view'),
        ),*/
        Expanded(child: Container()),
      ],
    );
  }
}