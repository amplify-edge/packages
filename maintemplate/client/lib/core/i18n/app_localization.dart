
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'generated/lang_messages_all.dart';


class AppLocalizations{
  final Locale locale;


  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString())
      .then((Object _) {
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



}


class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  const _AppLocalizationsDelegate();

  

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es',  'fr', 'ur'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

}