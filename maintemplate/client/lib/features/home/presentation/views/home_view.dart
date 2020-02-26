import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';
import 'package:navigation_rail/navigation_rail.dart';

import '../../../../locator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      currentIndex: _currentIndex,
      drawerFooterBuilder: (context){
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){
                Navigator.of(context).pushNamed(Router.settings);
              },
            ),
          ],
        );
      },
      tabs: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          title: Text("Home"),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text("Chat"),
          icon: Icon(Icons.chat),
        ),
        BottomNavigationBarItem(
          title: Text("ION"),
          icon: Icon(Icons.video_call),
        ),
        BottomNavigationBarItem(
          title: Text("Writer"),
          icon: Icon(Icons.edit),
        ),
      ],
      body: IndexedStack(
        index: _currentIndex,

        children:[
          Text("Home"),
           Text("Chat"),
           Text("ION"),
           Text("Witer"),
        ]
      ),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
