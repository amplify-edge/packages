import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/hive_parse.dart';

class PaneWidget extends StatefulWidget {
  final Box<List<Map<String, dynamic>>> hive;

  PaneWidget(this.hive);

  @override
  _PaneWidgetState createState() => _PaneWidgetState(hive);
}

class _PaneWidgetState extends State {
  Box<List<Map<String, dynamic>>> hive;
  List<Conversation> convos;

  _PaneWidgetState(this.hive);

  void markRead(int convoPos) {
    setState(() {
      for (var i = convos[convoPos].messages.length - 1; i >= 0; i -= 1) {
        if (!convos[convoPos].messages[i].isNew) break;
        convos[convoPos].messages[i].isNew = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    convos ??= parseAll(hive);
    persist(convos, hive);
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("Modular Messages (Long-press to read)"),
      ),
      body: Center(
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: convos.length,
            itemBuilder: (BuildContext ctxt, int i) {
              return Card(
                child: ListTile(
                  onLongPress: () {
                    markRead(i);
                  },
                  trailing: Column(children: <Widget>[
                    Text(parse(DateTime.fromMicrosecondsSinceEpoch(
                        convos[i].messages.last.timeProcessed))),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Icon(readSymbol(convos[i].messages.last))
                  ]),
                  title: Text(
                    convos[i].contact,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  subtitle: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        withAuthor(convos[i].messages.last, convos[i].contact),
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                color: isBold(convos[i].messages.last),
              );
            }),
      ),
    );
  }
}

Color isBold(Message latest) {
  if (latest.isNew) {
    return Colors.white;
  } else {
    return Colors.grey[350];
  }
}

String parse(DateTime original) {
  var now = DateTime.now();
  if ((now.day == original.day) &&
      (now.month == original.month) &&
      (now.year == original.year)) {
    var minute = '${original.minute}';
    if (original.minute < 10) {
      minute = '0' + minute;
    }
    return '${original.hour}:$minute';
  } else if ((now.difference(original) <
      Duration(
          days:
              (now.weekday - 1 + now.hour / 24 + now.minute / 1440).round()))) {
    return '${original.weekday}'.substring(0, 3) + '.';
  } else if (now.year == original.year) {
    return '${original.month}/${original.day}';
  } else {
    return '${original.month}/${original.day}/${original.year}';
  }
}

IconData readSymbol(Message latest) {
  if (latest.isNew) {
    return Icons.markunread;
  } else if (latest.self) {
    return Icons.hourglass_empty;
  } else {
    return Icons.mail_outline;
  }
}

String withAuthor(Message latest, String sender) {
  if (latest.self) {
    return 'You: ' + latest.inner;
  } else {
    return sender + ': ' + latest.inner;
  }
}
