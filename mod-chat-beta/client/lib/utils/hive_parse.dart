import 'package:hive/hive.dart';

// Hive Data should be structured like this:
//
// box.get(String contactName) returns a List<Map<String, dynamic>>, representing one conversation.
//
// Each Map<String, dynamic> in the List represents one message in the conversation, where:
//
// {'content': String message}    // Actual message content
// {'isSelf': bool isSelf}          // Whether this message is sent by user
// {'isRead': bool isRead}        // Whether this message is "new" (Not been opened locally)
// {'timeProcessed': int time}    // Time when message was processed (In microseconds since epoch)

List<Chat> parseAll(Box<List<Map<String, dynamic>>> box) {
  var conversations = <Chat>[];
  for (var contact in box.keys) {
    var map = box.get(contact);
    var messages = <Message>[];
    for (var val in map) {
      messages.add(Message(
          val['content'], val['isSelf'], val['isRead'], val['timeProcessed']));
    }
    conversations.add(Chat(messages, contact));
  }
  conversations.sort((Chat a, Chat b) {
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
void persist(List<Chat> data, Box<List<Map<String, dynamic>>> box) {
  for (var convo in data) {
    var hiveConvo = box.get(convo.contact);
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
      });
    }
    box.put(convo.contact, hiveVal);
  }
}

class Message {
  String inner;
  bool isSelf;
  bool isRead;
  int timeProcessed;
  String senderID;
  String senderName;

  Message(this.inner, this.isSelf, this.isRead, this.timeProcessed);
}

class Chat {
  List<Message> messages;
  String chatID;
  String chatName;

  Chat(List<Message> messages, this.chatName, this.chatID) {
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
