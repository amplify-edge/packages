import 'package:flutter/material.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'orgs_dashboard_view_desktop.dart';

class OrgsDashboardView extends StatelessWidget {
  final OrgsViewModel model;

  const OrgsDashboardView({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  ResponsiveBuilder(
        builder: (context, sizingInfo) {
          if (sizingInfo.screenSize.width >= 1100.0) {
            return OrgDashboardDesktopView(model : model);
          }

          return OrgDashboardMobileView(model : model);
        },
      
    );
  }
}
