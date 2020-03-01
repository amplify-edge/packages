import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  bool _tapped = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading : IconButton(onPressed : (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),)
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          onTap: () {
                            setState(() {
                              _tapped = true;
                              _index = index;
                            });
                          },
                          leading: Text("Item $index"));
                    },
                  ),
                  Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.share),
                      )),
                ],
              ),
            ),
            (_tapped == false)
                ? Text("Nothing selected")
                : ItemView(item: "Item $_index")
          ],
        ),
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final String item;

  const ItemView({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(item));
  }
}
