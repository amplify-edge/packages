import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maintemplate/core/i18n/app_localization.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/data/mock_item.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/master_detail_view.dart';
import 'package:maintemplate/features/responsive_scaffold_example/responsive_scaffold_view.dart';
import 'package:provider/provider.dart';

import 'features/i18n_json_example/i18n_view.dart';
import 'features/navigation_rail/navigation_rail.dart';
import 'features/responvive_builder_example/responsive_template.dart';

void main() => runApp(Provider<List<MockItem>>(
    create: (context) => mockItemsList,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
        Locale('es', ''),
        Locale('fr', 'FR'),
        Locale('he', ''),
        Locale('zh-cn', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    )));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          children : [
            InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResponsiveTemplate();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Builder"),
            )),
          ),

           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResponsiveScaffoldView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Scaffold"),
            )),
          ),

           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResponsiveScaffoldView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Scaffold"),
            )),
          ),

           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return I18NWithJsonView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Flutter Internationalization"),
            )),
          ),

           InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NavigationRailView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Navigation Rail"),
            )),
          ),

          ]
        )
        
        
        
    //     Flex(
    //   direction: Axis.vertical,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) {
    //             return ResponsiveTemplate();
    //           }));
    //         },
    //         child: Container(
    //             child: Center(
    //           child: Text("Responsive Builder"),
    //         )),
    //       ),
    //     ),
    //     Divider(),
    //     Flexible(
    //       flex: 1,
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) {
    //             return ResponsiveScaffoldView();
    //           }));
    //         },
    //         child: Container(
    //             child: Center(
    //           child: Text("Responsive Scaffold"),
    //         )),
    //       ),
    //     ),
    //     Divider(),
    //     Flexible(
    //       flex: 1,
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) {
    //             return MasterDetailView();
    //           }));
    //         },
    //         child: Container(
    //             child: Center(
    //           child: Text("Master Detail Scaffold"),
    //         )),
    //       ),
    //     ),
    //     Divider(),
    //     Flexible(
    //       flex: 1,
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) {
    //             return I18NView();
    //           }));
    //         },
    //         child: Container(
    //             child: Center(
    //           child: Text("Flutter Internationalization"),
    //         )),
    //       ),
    //     ),
    //   ],
    // )
    
    );
  }
}
