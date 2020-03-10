import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'generated/lang_messages_all.dart';

class AppLocalizations {
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

  String tabhome() {
    return Intl.message(
      'Home',
      name: 'tabhome',
      desc: 'text for the home tab',
      locale: locale.toString(),
    );
  }

  String tabchat() {
    return Intl.message(
      'Chat',
      name: 'tabchat',
      desc: 'text for the chat tab',
      locale: locale.toString(),
    );
  }

  String tabIon() {
    return Intl.message(
      'Ion',
      name: 'tabIon',
      desc: 'text for the ion tab',
      locale: locale.toString(),
    );
  }

  String tabsettings() {
    return Intl.message(
      'Settings',
      name: 'tabsettings',
      desc: 'text for the settings tab',
      locale: locale.toString(),
    );
  }

  String tabwriter() {
    return Intl.message(
      'Writer',
      name: 'tabwriter',
      desc: 'text for the writer tab',
      locale: locale.toString(),
    );
  }

  String tabmap() {
    return Intl.message(
      'Map',
      name: 'tabmap',
      desc: 'text for the writer tab',
      locale: locale.toString(),
    );
  }

  String tabSettings() {
    return Intl.message(
      'Settings',
      name: 'tabSettings',
      desc: 'text for the settings tab',
      locale: locale.toString(),
    );
  }

  String changeLanguageSet() {
    return Intl.message(
      'Change Language',
      name: 'changeLanguageSet',
      desc: 'text for the change language text in settings screen',
      locale: locale.toString(),
    );
  }

  String changeThemeSet() {
    return Intl.message(
      'Change Theme',
      name: 'changeThemeSet',
      desc: 'text for the change theme text in settings screen',
      locale: locale.toString(),
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  AppLocalizationsDelegate(this.overriddenLocale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'ur'].contains(locale.languageCode);
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
      ['en', 'es', 'fr', 'ur'].contains(locale.languageCode);

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
