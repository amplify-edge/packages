import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Translations {
  Locale locale;

  String send() {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'Send',
      locale: locale.toString(),
    );
  }

  String sendMessage() {
    return Intl.message(
      'Send a message',
      name: 'sendMessage',
      desc: 'Send a message',
      locale: locale.toString(),
    );
  }
}
