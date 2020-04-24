import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:maintemplate/core/i18n/translations.dart';

import 'generated/messages_all.dart';

class AppLocalizations extends Translations{
  final Locale locale;

  AppLocalizations(this.locale);

  static Future<AppLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((Object _) {
      return new AppLocalizations(locale);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  AppLocalizationsDelegate(this.overriddenLocale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'de', 'ur'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    if (this.overriddenLocale == Locale('system')) {
      print("return system");
      return AppLocalizations.load(locale);
    }
    print("return overriden");
    return AppLocalizations.load(this.overriddenLocale);
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'fr', 'de', 'ur'].contains(locale.languageCode);

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
