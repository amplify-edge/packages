import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Translations {
  Locale locale;

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
