import 'dart:async';
import 'dart:math';

import 'package:destiny/destiny.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../utils/hive_parse.dart';
import 'chat.dart';
import 'pane.dart';

Future<Box> createBox() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  var hiveSampleData = await Hive.openBox('message');
  for (var key in hiveSampleData.keys) {
    hiveSampleData.delete(key);
  }
  genSampleData(hiveSampleData);
  return hiveSampleData;
}

void genSampleData(Box hive) {
  int chats = 10;
  int msgsPerChat = 10;
  var chatids = List.generate(chats, (index) => destiny.guid());
  for (var i = 0; i < chats; i++) {
    var user = destiny.maleName();
    var uid = destiny.guid();
    var msgs = List.generate(msgsPerChat, (index) {
      Random rand = Random();
      var letters = (rand.nextDouble() * 30).ceil();
      return destiny.letters(10) + ' ' + destiny.letters(letters);
    });
    var isRead = destiny.boolean();
    var isSelf = List<bool>.generate(msgsPerChat, (index) => destiny.boolean());
    var times = List.generate(
        msgsPerChat,
        (index) => destiny.datetime(
            min: DateTime.now().subtract(Duration(days: 45)),
            max: DateTime.now()));
    List<Map<String, dynamic>> allData = <Map<String, dynamic>>[];
    for (var j = 0; j < msgsPerChat; j++) {
      var data = Map<String, dynamic>();
      data['content'] = msgs[j];
      data['isSelf'] = isSelf[j];
      data['isRead'] = isRead;
      if (isSelf[j]) data['isRead'] = true;
      data['timeProcessed'] = times[j].microsecondsSinceEpoch;
      if (isSelf[j]) {
        data['senderId'] = deviceId;
        data['senderName'] = deviceUser;
      } else {
        data['senderId'] = uid;
        data['senderName'] = user;
      }
      allData.add(data);
    }
    hive.put(chatids[i], allData);
  }
}

class MessageLayout extends StatefulWidget {
  @override
  _MessageLayoutState createState() => _MessageLayoutState();
}

class _MessageLayoutState extends State {
  ChatRoom convo;
  List<ChatRoom> all;
  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: createBox(),
        builder: (BuildContext ctxt, AsyncSnapshot shot) {
          if (shot.hasData) {
            print(shot.data.keys);
            hive = shot.data;
            print(hive.keys);
            convos ??= parseAll(hive);
            persist(convos, hive);
            convos = parseAll(hive);
            current ??= ChatWidget(convos[0], convos);
            if (_subscription != null) _subscription.cancel();
            listenAndRebuild();
            return ScreenTypeLayout.builder(
              mobile: (BuildContext ctxt) => rowMobile(),
              tablet: (BuildContext ctxt) => rowTablet(),
              desktop: (BuildContext ctxt) => rowDT(),
            );
          } else if (shot.hasError) {
            return Center(child: Text(shot.error.toString()));
          } else {
            return Center(child: Text('Loading...'));
          }
        });
  }

  Widget rowTablet() {
    return ResponsiveGridRow(children: [
      ResponsiveGridCol(
        lg: 4,
        child: PaneWidget(false),
      ),
      ResponsiveGridCol(
        lg: 8,
        child: Container(),
      ),
    ]);
  }

  Widget rowDT() {
    return ResponsiveGridRow(children: [
      ResponsiveGridCol(
        lg: 3,
        child: PaneWidget(false),
      ),
      ResponsiveGridCol(
        lg: 9,
        child: Container(),
      ),
    ]);
  }

  Widget rowMobile() {
    return ResponsiveGridRow(children: [
      ResponsiveGridCol(
        lg: 12,
        child: PaneWidget(true),
      ),
    ]);
  }

  void listenAndRebuild() {
    if (rebuild != null && _subscription == null) {
      _subscription = rebuild.listen((data) {
        setState(() {});
      });
    }
  }
}

Future<Box> temp;

FutureOr<Box> accessTemp() {
  return temp;
}
