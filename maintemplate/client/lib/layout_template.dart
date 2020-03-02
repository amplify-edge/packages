import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/nav_rail.dart';

import 'core/core.dart';
import 'core/themes/app_theme.dart';
import 'locator.dart';

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
      drawerHeader:  Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  child: Text("Header"),
                ),
              ),
      drawerFooterBuilder: (context){
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context).tabsettings()),
              onTap: (){
             //  Navigator.of(context).pushNamed(Router.settings);
              // locator<NavigationService>().navigateTo( Router.settings);
              Modular.to.pushNamed(Paths.settings);
              },
            ),
          ],
        );
      },
      body: widget.body,
      bottomNavigationBarSelectedColor: Theme.of(context).primaryColor,
      bottomNavigationBarUnselectedColor: Colors.grey,
      tabs: [
        TabItem(
          title: Text(AppLocalizations.of(context).tabhome()),
          icon: Icon(Icons.home),
          onTap: () {
          //  locator<NavigationService>().navigateTo(Router.home);
           // Navigator.of(context).pushNamed(Router.home);
            Modular.to.pushNamed(Paths.home);
            print("Home tapped");},
        ),
         TabItem(
          title: Text(AppLocalizations.of(context).tabchat()),
          icon: Icon(Icons.chat),
          onTap: () {
            // Navigator.of(context).pushNamed(Router.chat);
            // locator<NavigationService>().navigateTo(Router.chat);
              Modular.to.pushNamed(Paths.chat);
            print("Chat tapped");},
        ),
        TabItem(
          title: Text(AppLocalizations.of(context).tabIon()),
          icon: Icon(Icons.video_call),
          onTap: () {
            // Navigator.of(context).pushNamed(Router.ion);
            // locator<NavigationService>().navigateTo(Router.ion);
              Modular.to.pushNamed(Paths.ion);
            print("ION tapped");},
        ),
         TabItem(
          title: Text(AppLocalizations.of(context).tabwriter()),
          icon: Icon(Icons.edit),
          onTap: () {
           //  Navigator.of(context).pushNamed(Router.writer);
           // locator<NavigationService>().navigateTo(Router.writer);
           Modular.to.pushNamed(Paths.writer);
            print("Writer tapped");},
        ),
        TabItem(
          title: Text("ModWriter"),
          icon: Icon(Icons.font_download),
          onTap: () {
            //  Navigator.of(context).pushNamed(Router.writer);
            // locator<NavigationService>().navigateTo(Router.writer);
            Modular.to.pushNamed(Paths.modWriter);
            print("ModWriter tapped");},
        ),
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
