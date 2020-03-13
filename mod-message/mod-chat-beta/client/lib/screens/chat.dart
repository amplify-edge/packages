import 'package:bubble/bubble.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../utils/hive_parse.dart';
import 'pane.dart';

class ChatWidget extends StatefulWidget {
  final ChatRoom convo;
  final List<ChatRoom> all;

  ChatWidget(this.convo, this.all);

  @override
  _ChatWidgetState createState() => _ChatWidgetState(convo, all);
}

class _ChatWidgetState extends State {
  ChatRoom convo;
  final List<ChatRoom> all;
  TextEditingController control = TextEditingController();
  var _formKey = new GlobalKey<FormState>();

  _ChatWidgetState(this.convo, this.all);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      MaterialBanner(
          content: Text(convo.chatid,
              overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 30)),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]),
      Expanded(
          //ListView of messages go here.
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: convo.messages.length,
              itemBuilder: (BuildContext ctxt, int i) {
                var message = convo.messages[i];
                if (!message.isSelf) message.isRead = true;
                return Container(
                    padding: EdgeInsets.all(5),
                    child: forgeBubble(
                        message.inner, true, [message.isSelf, message.isRead]));
              })),
      Form(
        key: _formKey,
        child: Row(children: <Widget>[
          // TextFormField; will be submitted by button to right
          Expanded(
              child: TextFormField(
            key: _formKey,
            controller: control,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a message...';
              }
              return null;
            },
            decoration: const InputDecoration(
                hintText: 'Send a message...',
                // Rounded rectangle border.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(5.0), right: Radius.circular(5.0)),
                )),
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: onPressSubmit,
          )
        ]),
      )
    ]);
  }

  // Submit message to local List, and then to Hive, if it's valid.
  void onPressSubmit() {
    if (_formKey.currentState.validate()) {
      isChanged = true;
      all.remove(convo);
      convo.messages.add(Message(control.text, true, false,
          DateTime.now().microsecondsSinceEpoch, deviceId, deviceUser));
      setState(() {
        all.insert(0, convo);
        persist(all, hive);
      });
    }
  }

  // Create a bubble. Ignore, UI only.
  Widget forgeBubble(String message, bool isNip, List<bool> isSelfAndRead) {
    BubbleNip nip;
    Row content;
    Alignment align;
    if (isSelfAndRead[0]) {
      nip = BubbleNip.rightTop;
      align = Alignment.topRight;
      if (isSelfAndRead[1]) {
        content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
              child: Text(
            message,
            textWidthBasis: TextWidthBasis.parent,
            textAlign: TextAlign.right,
          )),
          Container(width: 10),
          Icon(
            CommunityMaterialIcons.check_all,
            color: Theme.of(context).accentColor,
            size: 24,
          )
        ]);
      } else {
        content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
              child: Text(
            message,
            textWidthBasis: TextWidthBasis.parent,
            textAlign: TextAlign.right,
          )),
          Container(width: 10),
          Icon(
            CommunityMaterialIcons.check,
            color: Theme.of(context).accentColor,
            size: 24,
          )
        ]);
      }
    } else {
      nip = BubbleNip.leftTop;
      align = Alignment.topLeft;
      content = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Flexible(
            child: Text(
          message,
          textWidthBasis: TextWidthBasis.parent,
          textAlign: TextAlign.left,
        )),
      ]);
    }
    if (!isNip) nip = BubbleNip.no;
    return Bubble(
      color: Colors.blue[100],
      alignment: align,
      nip: nip,
      child: content,
      padding: BubbleEdges.all(15),
      radius: Radius.circular(5),
      margin: calcMargin(isSelfAndRead[0]),
      nipWidth: 4,
      nipHeight: 12,
    );
  }

  BubbleEdges calcMargin(bool self) {
    var w = MediaQuery.of(context).size.width * 1 / 4;
    if (!self) {
      return BubbleEdges.only(right: w);
    } else {
      return BubbleEdges.only(left: w);
    }
  }
}
