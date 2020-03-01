

import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier{

  // final SettingsRepository settingsRepository;

  // SettingsViewModel({@required this.settingsRepository});

  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode; 

  void changeTheme(ThemeMode theme){
    _themeMode = theme;
    notifyListeners();
  }

}