import 'package:bubble/bubble.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/hive_parse.dart';

class ChatWidget extends StatefulWidget {
  final Conversation convo;
  final List<Conversation> all;
  final Box hive;

  ChatWidget(this.convo, this.all, this.hive);

  @override
  _ChatWidgetState createState() => _ChatWidgetState(convo, all, hive);
}

class _ChatWidgetState extends State {
  Conversation convo;
  final List<Conversation> all;
  final Box hive;
  TextEditingController control;
  final _formKey = GlobalKey<FormState>();

  _ChatWidgetState(this.convo, this.all, this.hive);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              itemCount: convo.messages.length,
              itemBuilder: (BuildContext ctxt, int i) {
                var message = convo.messages[i];
                if (!message.isSelf) message.isRead = true;
                return forgeBubble(
                    message.inner, true, [message.isSelf, message.isRead]);
              })),
      Form(
        child: Row(children: <Widget>[
          TextFormField(
            key: _formKey,
            controller: control,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                all.remove(convo);
                convo.messages.add(Message(control.text, true, false,
                    DateTime.now().microsecondsSinceEpoch));
                all.insert(0, convo);
                persist(all, hive);
              }
            },
          )
        ]),
      )
    ]);
  }

  Widget forgeBubble(String message, bool isNip, List<bool> isSelfAndRead) {
    BubbleNip nip;
    Row content;
    Alignment align;
    if (isSelfAndRead[0]) {
      nip = BubbleNip.rightTop;
      align = Alignment.topRight;
      if (isSelfAndRead[1]) {
        content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(child: Text(message)),
          Icon(CommunityMaterialIcons.check_all)
        ]);
      } else {
        content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(child: Text(message)),
          Icon(CommunityMaterialIcons.check)
        ]);
      }
    } else {
      nip = BubbleNip.leftTop;
      align = Alignment.topLeft;
      content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Flexible(child: Text(message)),
      ]);
    }
    if (!isNip) nip = BubbleNip.no;
    return Bubble(
      alignment: align,
      nip: nip,
      child: content,
      radius: Radius.circular(5),
      nipWidth: 4,
      nipHeight: 12,
    );
  }
}
