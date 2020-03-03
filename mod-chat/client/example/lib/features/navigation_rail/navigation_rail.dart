import 'package:flutter/material.dart';
import 'package:navigation_rail/navigation_rail.dart';

class NavigationRailView extends StatefulWidget {
  @override
  _NavigationRailViewState createState() => _NavigationRailViewState();
}

class _NavigationRailViewState extends State<NavigationRailView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationRail(
        title: Text("Navigation Rail"),
        isDense: false,
        currentIndex: 0,
        onTap: (val){
          setState(() {
            _currentIndex = val;
          });
        },
        body: Center(
          child: Text(_currentIndex.toString()),
        ),
        drawerHeaderBuilder: (context) {
          return Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: (){}),
                IconButton(icon: Icon(Icons.people), onPressed: (){}),

            ],
          );
        },
        drawerFooterBuilder: (context){
          return Column(
            children : [
               IconButton(icon: Icon(Icons.settings), onPressed: (){}),
                IconButton(icon: Icon(Icons.info), onPressed: (){}),

            ]
          );
        },
        tabs: [
           BottomNavigationBarItem(
          title: Text("Folders"),
          icon: Icon(Icons.folder),
        ),
        BottomNavigationBarItem(
          title: Text("History"),
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          title: Text("Gallery"),
          icon: Icon(Icons.photo_library),
        ),
        BottomNavigationBarItem(
          title: Text("Camera"),
          icon: Icon(Icons.camera),
        ),
        ],
      ),
    );
  }
}