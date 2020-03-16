import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../utils/hive_parse.dart';
import 'chat.dart';

class PaneWidget extends StatefulWidget {
  final bool independent;

  PaneWidget(this.independent);

  @override
  _PaneWidgetState createState() => _PaneWidgetState(independent);
}

class _PaneWidgetState extends State {
  bool independent;

  _PaneWidgetState(this.independent);

  void markRead(int convoPos) {
    setState(() {
      for (var i = convos[convoPos].messages.length - 1; i >= 0; i -= 1) {
        if (convos[convoPos].messages[i].isRead) break;
        convos[convoPos].messages[i].isRead = true;
      }
      isChanged = true;
    });
  }

  void markUnread(int convoPos) {
    if (!convos[convoPos].messages.last.isSelf) {
      setState(() {
        convos[convoPos].messages.last.isRead = false;
        isChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    rebuild = buildMessageStream().asBroadcastStream();
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        itemCount: convos.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return Card(
            child: ListTile(
              onLongPress: () {
                if (!convos[i].messages.last.isRead)
                  markRead(i);
                else
                  markUnread(i);
              },
              onTap: () {
                current = ChatWidget(convos[i], convos);
                if (independent) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => current),
                  );
                }
              },
              trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(parse(DateTime.fromMicrosecondsSinceEpoch(
                        convos[i].messages.last.timeProcessed))),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Icon(readSymbol(convos[i].messages.last))
                  ]),
              title: Text(
                'ChatID:' + convos[i].chatid,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: EdgeInsets.all(10),
              subtitle: Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    withAuthor(convos[i].messages.last,
                        convos[i].messages.last.senderName),
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            color: isBold(convos[i].messages.last),
          );
        });
  }
}

Color isBold(Message latest) {
  if (!latest.isRead && !latest.isSelf) {
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
    return weekdays[original.weekday];
  } else if (now.year == original.year) {
    return '${original.month}/${original.day}';
  } else {
    return '${original.month}/${original.day}/${original.year}';
  }
}

final Map<int, String> weekdays = {
  1: 'Mon.',
  2: 'Tue.',
  3: 'Wed.',
  4: 'Thu.',
  5: 'Fri.',
  6: 'Sat.',
  7: 'Sun.'
};

IconData readSymbol(Message latest) {
  if (latest.isRead && !latest.isSelf) {
    return Icons.mail_outline;
  } else if (!latest.isSelf) {
    return Icons.markunread;
  } else if (latest.isSelf && !latest.isRead) {
    return CommunityMaterialIcons.check;
  } else {
    return CommunityMaterialIcons.check_all;
  }
}

String withAuthor(Message latest, String sender) {
  if (latest.isSelf) {
    return 'You: ' + latest.inner;
  } else {
    return sender + ': ' + latest.inner;
  }
}

Stream<String> buildMessageStream() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    if (isChanged) yield '';
  }
}

ChatWidget current;
List<ChatRoom> convos;
bool isChanged = false;
Stream rebuild;
Box hive;
