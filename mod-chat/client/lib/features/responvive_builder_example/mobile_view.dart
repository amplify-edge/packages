import 'package:flutter/material.dart';

class MobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading : IconButton(onPressed : (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),)
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return ItemView(item: "Item $index",);
              })
            );
          },
          leading : Text("Item $index")
        );
       },
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final String item;

  const ItemView({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon:Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(item)
          ),

          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(onPressed: (){},
            child: Icon(Icons.share),
            ))
        ],
      ),
    );
  }
}