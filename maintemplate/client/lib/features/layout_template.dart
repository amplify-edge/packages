import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';
import 'package:navigation_rail/navigation_rail.dart';


import '../locator.dart';

class LayoutTemplate extends StatefulWidget {
  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
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
              //  Navigator.of(context).pushNamed(Router.settings);
              locator<NavigationService>().navigateTo(Router.settings);
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
          Center(child: Text("Home")),
           Center(child: Text("Chat")),
           Center(child: Text("ION")),
           Center(child: Text("Witer")),
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
