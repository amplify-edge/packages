import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Translations {
  Locale locale;

  String startupTestLog() {
    return Intl.message(
      'This is i18n test string from mod-write. Hi everybody in the logs.',
      name: 'startupTestLog',
      desc: 'This is i18n test string from mod-write. Hi everybody in the logs.',
      locale: locale.toString(),
    );
  }
}
