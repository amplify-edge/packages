

import 'package:flutter/material.dart';
import 'package:maintemplate/features/settings/repository/settings_repository.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../locator.dart';
import 'settings_view_web.dart';

import '../view_models/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
        return ScreenTypeLayout.builder(
        desktop: (context) => SettingsViewWeb( ),
        mobile: (context) => SettingsViewWeb(),
      );
    
  }
}