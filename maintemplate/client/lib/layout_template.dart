import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/nav_rail.dart';

import 'core/core.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget body;

  const LayoutTemplate({Key key, this.body}) : super(key: key);
  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialNavigationRail(
      currentIndex: _currentIndex,
      drawerHeader: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: DrawerHeader(
          child: Text("Header"),
        ),
      ),
      body: widget.body,
      bottomNavigationBarSelectedColor:
          (Theme.of(context).brightness == Brightness.dark)
              ? Colors.tealAccent[200]
              : Theme.of(context).primaryColor,
      bottomNavigationBarUnselectedColor: Colors.grey,
      tabs: [
        TabItem(
          title: Text(
            AppLocalizations.of(context).tabhome() 
             ,
          ),
          icon: Icon(Icons.home),
          onTap: () {
            Modular.to.pushNamed(Paths.modMain);
            print("Home tapped");
          },
        ),
        TabItem(
          title: Text(
            AppLocalizations.of(context).tabchat() 
          
          ),
          icon: Icon(Icons.chat),
          onTap: () {
            Modular.to.pushNamed(Paths.chat);
            print("Chat tapped");
          },
        ),
        /*
        TabItem(
          title: Text(AppLocalizations.of(context).tabchat() + ' Beta'),
          icon: Icon(Icons.chat),
          onTap: () {
            Modular.to.pushNamed(Paths.chat_beta);
            print("ChatBeta tapped");
          },
        ), */
        TabItem(
          title: Text(
            AppLocalizations.of(context).tabIon()
            ),
          icon: Icon(Icons.video_call),
          onTap: () {
            Modular.to.pushNamed(Paths.ion);
            print("ION tapped");
          },
        ),
        TabItem(
          title: Text(AppLocalizations.of(context).tabwriter()
          ),
          icon: Icon(Icons.font_download),
          onTap: () {
            Modular.to.pushNamed(Paths.modWriter);
            print("Writer tapped");
          },
        ),
        TabItem(
          title: Text(AppLocalizations.of(context).tabmap()
          ),
          icon: Icon(Icons.map),
          onTap: () {
            Modular.to.pushNamed(Paths.modGeo);
            print("Writer tapped");
          },
        ),
        TabItem(
          title: Text(AppLocalizations.of(context).tabsettings()),

          icon: Icon(Icons.settings),
          onTap: () {
            Modular.to.pushNamed(Paths.settings);
            print("Settings tapped");
          },
        ),
        // TabItem(
        //   title: Text("ModWriter"),
        //   icon: Icon(Icons.font_download),
        //   onTap: () {
        //     //  Navigator.of(context).pushNamed(Router.writer);
        //     // locator<NavigationService>().navigateTo(Router.writer);
        //     Modular.to.pushNamed(Paths.modWriter);
        //     print("ModWriter tapped");},
        // ),
      ],
      onPressed: (index) {
        print(index);
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
