import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

class SettingsViewModel extends ChangeNotifier {
  // final SettingsRepository settingsRepository;

  // SettingsViewModel({@required this.settingsRepository});
  EnvVariables _envVariables = EnvVariables.empty();

  EnvVariables get envVariables => _envVariables;

  Future<void> fetchEnvVariables() async {
    //String data =
    //await DefaultAssetBundle.of(context).loadString("assets/env.json");
    String data = await rootBundle.loadString("assets/env.json");
    _envVariables = EnvVariables.fromJson(data);
    print("alec data : ${_envVariables.channel}");
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
      flutterChannel: data["flutter_channel"] ?? "",
    );
  }
}
