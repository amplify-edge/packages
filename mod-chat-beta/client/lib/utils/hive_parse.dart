import 'package:hive/hive.dart';

// Hive Data should be structured like this:
//
// box.get(String chatid) returns a List<Map<String, dynamic>>, representing one chatroom.
//
// Each Map<String, dynamic> in the List represents one message in the chatroom, where:
//
// {'content': String message}    // Actual message content
// {'isSelf': bool isSelf}          // Whether this message is sent by user
// {'isRead': bool isRead}        // Whether this message is "new" (Not been opened locally)
// {'timeProcessed': int time}    // Time when message was processed (In microseconds since epoch)
// {'senderId': String deviceId}  // Unique ID for server routing
// {'senderName': String name}    // Username of sender

List<ChatRoom> parseAll(Box box) {
  var conversations = <ChatRoom>[];
  for (var chatid in box.keys) {
    var map = box.get(chatid);
    var messages = <Message>[];
    for (var val in map) {
      messages.add(Message(val['content'], val['isSelf'], val['isRead'],
          val['timeProcessed'], val['senderId'], val['senderName']));
    }
    conversations.add(ChatRoom(messages, chatid));
  }
  conversations.sort((ChatRoom a, ChatRoom b) {
    var messageA = a.messages.last;
    var messageB = b.messages.last;
    if (messageA.timeProcessed < messageB.timeProcessed)
      return 1;
    else if (messageA.timeProcessed == messageB.timeProcessed)
      return 0;
    else
      return -1;
  });
  return conversations;
}

/// Run this to persist your local list of conversation (with its edits) while
/// also keeping new messages that are in Hive.
void persist(List<ChatRoom> data, Box box) {
  for (var convo in data) {
    var hiveConvo = box.get(convo.chatid);
    hiveConvo ??= <Map<String, dynamic>>[];
    box.clear();
    List<Map<String, dynamic>> hiveVal = <Map<String, dynamic>>[];
    var time = 0;
    for (var message in convo.messages) {
      hiveVal.add({
        'content': message.inner,
        'isSelf': message.isSelf,
        'isRead': message.isRead,
        'timeProcessed': message.timeProcessed,
        'senderId': message.senderId,
        'senderName': message.senderName,
      });
      time = message.timeProcessed;
    }
    for (var message in hiveConvo.reversed) {
      if (message['timeProcessed'] < time) break;
      hiveVal.add({
        'content': message['content'],
        'isSelf': message['isSelf'],
        'isRead': message['isRead'],
        'timeProcessed': message['timeProcessed'],
        'senderId': message['senderId'],
        'senderName': message['senderName'],
      });
    }
    box.put(convo.chatid, hiveVal);
  }
}

class Message {
  String inner;
  bool isSelf;
  bool isRead;
  int timeProcessed;
  String senderId;
  String senderName;

  Message(this.inner, this.isSelf, this.isRead, this.timeProcessed,
      this.senderId, this.senderName);
}

class ChatRoom {
  List<Message> messages;
  String chatid;

  ChatRoom(List<Message> messages, this.chatid) {
    this.messages = messages;
    this.messages.sort((Message a, Message b) {
      if (a.timeProcessed < b.timeProcessed)
        return -1;
      else if (a.timeProcessed == b.timeProcessed)
        return 0;
      else
        return 1;
    });
  }
}

//TODO: Implement deviceId to get a real ID.
String get deviceId => '000000';

//TODO: Implement deviceId to get a real username.
String get deviceUser => 'TestUser';
