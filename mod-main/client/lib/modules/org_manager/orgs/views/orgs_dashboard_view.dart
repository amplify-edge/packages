import 'package:flutter/material.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'orgs_dashboard_view_desktop.dart';

class OrgsDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          if (sizingInfo.screenSize.width >= 1100.0) {
            return OrgDashboardDesktopView();
          }

          return OrgDashboardMobileView();
        },
      ),
    );
  }
}
