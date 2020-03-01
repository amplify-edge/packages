import 'package:flutter/material.dart';
import 'package:modkanban/features/responvive_builder_example/desktop_view.dart';
import 'package:modkanban/features/responvive_builder_example/mobile_view.dart';


import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder( 
      breakpoints: ScreenBreakpoints(desktop: 400, tablet: 400, watch: 300),
      mobile: (context) => MobileView(),
      desktop: (context) => DesktopView(),
    );
  }
}