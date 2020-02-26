

import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';
import 'package:maintemplate/features/settings/repository/settings_repository.dart';
import 'package:meta/meta.dart';

class SettingsViewModel extends ChangeNotifier{

  // final SettingsRepository settingsRepository;

  // SettingsViewModel({@required this.settingsRepository});

  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode; 

  void changeTheme(theme){
    _themeMode = theme ?? _themeMode;
    print(_themeMode);
    notifyListeners();
  }

}