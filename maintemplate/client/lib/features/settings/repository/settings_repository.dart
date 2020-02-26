

import 'package:flutter/material.dart';
import 'package:maintemplate/features/settings/services/settings_service.dart';
import 'package:meta/meta.dart';

class SettingsRepository{

  final SettingsService settingsService;

  SettingsRepository({@required this.settingsService});

  // Here we can save the theme to shared prefs etc...
  ThemeMode changeTheme(theme) {
    return settingsService.changeTheme(theme);
  }


}