import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sys_core/sys_core.dart';
import './translations.dart';

class ModWriteLocalizations extends Translations {
  final Locale locale;
  static Map<String, String> _localizedStrings;

  ModWriteLocalizations(this.locale);

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('packages/mod_write/i18n/lang_${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = Map.from(json.decode(jsonString))
      ..removeWhere((key, value) => key[0] == '@');

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }

  static ModWriteLocalizations of(BuildContext context) {
    return Localizations.of<ModWriteLocalizations>(
        context, ModWriteLocalizations);
  }
}

class ModWriteLocalizationsDelegate
    extends LocalizationsDelegate<ModWriteLocalizations> {
  final Locale overriddenLocale;

  ModWriteLocalizationsDelegate(this.overriddenLocale);

  @override
  bool shouldReload(ModWriteLocalizationsDelegate old) => true;

  @override
  bool isSupported(Locale locale) {
    return Languages.supportedLanguages.keys.contains(locale.languageCode.toString());
  }

  @override
  Future<ModWriteLocalizations> load(Locale locale) async {
    ModWriteLocalizations localizations = new ModWriteLocalizations(locale);
    await localizations.load();
    return localizations;
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      Languages.supportedLanguages.keys.contains(locale.languageCode.toString());

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<_DefaultCupertinoLocalizations>(
          _DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;

  _DefaultCupertinoLocalizations(this.locale);
}
