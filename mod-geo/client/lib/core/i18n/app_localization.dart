import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'generated/lang_messages_all.dart';



// Bottom Up approach .....

class ModGeoLocalizations {
  final Locale locale;

  ModGeoLocalizations(this.locale);

  static Future<ModGeoLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((Object _) {
      return new ModGeoLocalizations(locale);
    });
  }

  static ModGeoLocalizations of(BuildContext context) {
    return Localizations.of<ModGeoLocalizations>(context, ModGeoLocalizations);
  }

  String test() {
    return Intl.message(
      'This string should be translated',
      name: 'test',
      desc: 'text for the home tab',
      locale: locale.toString(),
    );
  }

 
}

class ModGeoAppLocalizationsDelegate extends LocalizationsDelegate<ModGeoLocalizations> {
  final Locale overriddenLocale;

  ModGeoAppLocalizationsDelegate(this.overriddenLocale);

  @override
  bool shouldReload(ModGeoAppLocalizationsDelegate old) => true;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<ModGeoLocalizations> load(Locale locale) {
    if (this.overriddenLocale == Locale('system')) {
      print("return system");
      return ModGeoLocalizations.load(locale);
    }
    print("return overriden");
    return ModGeoLocalizations.load(this.overriddenLocale);
  }
}
