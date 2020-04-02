import 'package:flutter/material.dart';

class FolderView extends StatefulWidget {
  @override
  _FolderViewState createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(child: Text("Folder")),
            RaisedButton(child: Text("Go to page 2"), onPressed: (){
              Navigator.of(context).pushNamed("/page2");
            },)
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Page 1")));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: <Widget>[
        Center(child: Text("Page 2")),
         RaisedButton(child: Text("Go to page 1"), onPressed: (){
              Navigator.of(context).pop();
            },)

      ],
    ));
  }
}
