import 'package:flutter/material.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/data_pane.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/filter_pane.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrgDashboardMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,  

            ),
            drawer: Drawer(
              child: FilterPane(sizingInfo: sizingInfo)),
            body: Center(child: DataPane(sizingInfo: sizingInfo)));
      },
    );
  }
}
