import 'dart:convert';

import 'package:flutter/material.dart';


class SettingsViewModel extends ChangeNotifier {
  // final SettingsRepository settingsRepository;

  // SettingsViewModel({@required this.settingsRepository});
  EnvVariables _envVariables = EnvVariables.empty();

  EnvVariables get envVariables => _envVariables;

  SettingsViewModel(BuildContext context) {
    fetchEnvVariables(context);
  }

  void fetchEnvVariables(BuildContext context) async {
    String data =
    await DefaultAssetBundle.of(context).loadString("assets/env.json");
    _envVariables = EnvVariables.fromJson(data);
    notifyListeners();
  }

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

  void changeTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void changeLanguage(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class EnvVariables {
  final String channel;
  final String url;
  final String gitHash;
  final String flutterChannel;

  EnvVariables({this.channel, this.url, this.gitHash, this.flutterChannel});

  factory EnvVariables.empty() =>
      EnvVariables(channel: "", url: "", gitHash: "", flutterChannel: "");

  static EnvVariables fromJson(String jsonString) {
    var data = json.decode(jsonString);
    return EnvVariables(
        channel: data["channel"] ?? "-",
        url: data["url"] ?? "-",
        gitHash: data["githash"] ?? "-",
        flutterChannel: data["flutter_channel"]?? "",
        );
  }
}