

import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';

class SettingsViewModel extends ChangeNotifier{

  // final SettingsRepository settingsRepository;

  // SettingsViewModel({@required this.settingsRepository});

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = Locale('system');
  List<Locale> supportedLocales = [
    Locale('system'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ur'),
  ];

  Locale get locale => _locale; 
  ThemeMode get themeMode => _themeMode; 

  void changeTheme(ThemeMode theme){
    _themeMode = theme;
    notifyListeners();
  }

  void changeLanguage(Locale locale){
    _locale = locale;
    notifyListeners();
  }


}