import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class ResponsiveScaffoldView extends StatefulWidget {
  @override
  _ResponsiveScaffoldViewState createState() => _ResponsiveScaffoldViewState();
}

class _ResponsiveScaffoldViewState extends State<ResponsiveScaffoldView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return ResponsiveListScaffold.builder(
      scaffoldKey: _scaffoldKey,
      tabletBreakpoint: 400,
      itemCount: 10,
      appBar: AppBar(
        title:Text("AppBar")
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text("Item $index"),
        );
      },
      detailBuilder: (BuildContext context, int index, bool tablet) {
        return DetailsScreen(
          appBar: AppBar(
            title:Text("Details"),
            automaticallyImplyLeading: !tablet,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.share), onPressed: (){}),
              IconButton(icon: Icon(Icons.delete), onPressed: (){})
            ],
          ),
            body: Center(
          child: Text("item $index"),
        ));
      },
     
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ),
        ),
         floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Item added "),
            ));
          },
        ),
    );
  }
}
