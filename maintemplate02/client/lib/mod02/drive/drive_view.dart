

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'drive_view_desktop.dart';
import 'drive_view_mobile.dart';
class DriveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo)
      {
        if(sizingInfo.screenSize.width > 600){
          return DriveViewDesktop();
        }

        return DriveViewMobile();
      },
    );
  }
}