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

  String noItemsSelected() {
    return Intl.message(
      'No items selected.',
      name: 'noItemsSelected',
      desc: 'No items selected.',
      locale: locale.toString(),
    );
  }

  String noCampaigns() {
    return Intl.message(
      'No Campaigns',
      name: 'noCampaigns',
      desc: 'No Campaigns',
      locale: locale.toString(),
    );
  }

  String selectCampaign() {
    return Intl.message(
      'Select Campaign',
      name: 'selectCampaign',
      desc: 'Select Campaign',
      locale: locale.toString(),
    );
  }
}
