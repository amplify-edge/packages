

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:navigation_rail/navigation_rail.dart';

import 'tab-modules/mod-camera/camera_module.dart';
import 'tab-modules/mod-folder/folder_module.dart';
import 'tab-modules/mod-gallery/gallery_module.dart';

class NavRailView extends StatefulWidget {


  NavRailView({Key key}) : super(key: key);

  @override
  _NavRailViewState createState() => _NavRailViewState();
}

class _NavRailViewState extends State<NavRailView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavRail(
      isDense: false,
      drawerHeaderBuilder: (context) {
        return Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Steve Jobs"),
              accountEmail: Text("jobs@apple.com"),
            ),
          ],
        );
      },
      drawerFooterBuilder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
            ),
          ],
        );
      },
      currentIndex: _currentIndex,
      onTap: (val) {
        if (mounted)
          setState(() {
            _currentIndex = val;
          });
      },
      title: Text("Navigation rail"),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          RouterOutlet(
            module: FolderModule()),
          RouterOutlet(
           
            module: GalleryModule()),
          RouterOutlet(
           
            module: CameraModule()),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      tabs: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Folders"),
          icon: Icon(Icons.folder),
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
    );
  }
}