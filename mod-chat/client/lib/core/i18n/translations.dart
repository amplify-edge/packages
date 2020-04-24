import 'package:intl/intl.dart';

class Translations {
  String send() {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'Send',
    );
  }

  String sendMessage() {
    return Intl.message(
      'Send a message',
      name: 'sendMessage',
      desc: 'Send a message',
    );
  }

  // import 'package:core/core.dart';
  // ModChatLocalizations.of(context).translate('')
}