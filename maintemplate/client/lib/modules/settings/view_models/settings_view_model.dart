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

    this.loadLocalesFromEnvVariables(_envVariables);

    print("alec data : ${_envVariables.channel}");
    notifyListeners();
  }

  void loadLocalesFromEnvVariables(EnvVariables _envVariables) {
    this.supportedLocales = _envVariables.locales;
    this._locale = _envVariables.locales.first;
  }

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = Locale('system');
  List<Locale> supportedLocales = EnvVariableDefaults.locales;

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

  String languageNameLookup(Locale locale) {
    Map<String, String> _localeNames = {
      'en': 'English',
      'fr': 'French',
      'system': 'System',
      'ur': 'Urdu',
      'de': 'German',
      'es': 'Spanish',
    };

    String code = locale.languageCode.toString();

    if (_localeNames.containsKey(code)) {
      return _localeNames[code];
    }

    return 'Unknown';
  }
}

class EnvVariables {
  final String channel;
  final String url;
  final String urlNative;
  final String gitHash;
  final String flutterChannel;
  final List<Locale> locales;

  EnvVariables(
      {this.channel,
      this.url,
      this.urlNative,
      this.gitHash,
      this.flutterChannel,
      this.locales});

  factory EnvVariables.empty() => EnvVariables(
      channel: "",
      url: "",
      urlNative: "",
      gitHash: "",
      flutterChannel: "",
      locales: []);

  static EnvVariables fromJson(String jsonString) {
    var data = json.decode(jsonString);

    return EnvVariables(
      channel: data["channel"] ?? "-",
      url: data["url"] ?? "-",
      urlNative: data["url_native"] ?? "-",
      gitHash: data["githash"] ?? "-",
      flutterChannel: data["flutter_channel"] ?? "",
      locales: _buildLocalesFromList(data["locales"] ?? []),
    );
  }

  /// Accepts a Map from the jsonDecode() and puts its values in a list.
  /// Note: If the list is empty, we will return the default list
  static List<Locale> _buildLocalesFromList(List<dynamic> _locales) {
    List<Locale> locales = _locales.map((value) => Locale(value)).toList();

    return locales.isEmpty ? EnvVariableDefaults.locales : locales;
  }
}

// System Defaults
class EnvVariableDefaults {
  static final List<Locale> locales = [
    Locale('system'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('ur'),
  ];
}
