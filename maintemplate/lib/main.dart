import 'package:flutter/material.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/data/mock_item.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/master_detail_view.dart';
import 'package:maintemplate/features/responsive_scaffold_example/responsive_scaffold_view.dart';
import 'package:provider/provider.dart';

import 'features/responvive_builder_example/responsive_template.dart';

void main() =>
    runApp(Provider<List<MockItem>>(
      create : (context) => mockItemsList,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: App())));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: InkWell(
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
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  ResponsiveScaffoldView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Scaffold"),
            )),
          ),
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MasterDetailView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Master Detail Scaffold"),
            )),
          ),
        ),
      ],
    ));
  }
}
