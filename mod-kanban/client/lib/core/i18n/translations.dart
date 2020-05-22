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

  String addCardTask() {
    return Intl.message(
      'Add Card Task',
      name: 'addCardTask',
      desc: 'Add Card Task',
      locale: locale.toString(),
    );
  }

  String taskTitle() {
    return Intl.message(
      'Task Title',
      name: 'taskTitle',
      desc: 'Task Title',
      locale: locale.toString(),
    );
  }

  String addTask() {
    return Intl.message(
      'Add Task',
      name: 'addTask',
      desc: 'Add Task',
      locale: locale.toString(),
    );
  }

  String addCard() {
    return Intl.message(
      'Add Card',
      name: 'addCard',
      desc: 'Add Card',
      locale: locale.toString(),
    );
  }

  String cardTitle() {
    return Intl.message(
      'Card Title',
      name: 'cardTitle',
      desc: 'Card Title',
      locale: locale.toString(),
    );
  }
}
