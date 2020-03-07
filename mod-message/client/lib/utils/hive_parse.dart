import 'package:hive/hive.dart';

import 'wrappers.dart';

export 'wrappers.dart';

// Hive Data should be structured like this:
//
// box.get(String contactName) returns a List<Map<String, dynamic>>, representing one conversation.
//
// Each Map<String, dynamic> in the List represents one message in the conversation, where:
//
// {'content': String message} // Actual message content
// {'self': bool isSelf}       // Whether this message is sent by user or contact
// {'isNew': bool isNew}       // Whether this message is "new" (Not been opened locally)
// {'timeProcessed': int time} // Time when message was processed (In microseconds since epoch)

List<Conversation> parseAll(Box<List<Map<String, dynamic>>> box) {
  var conversations = <Conversation>[];
  for (var contact in box.keys) {
    var map = box.get(contact);
    var messages = <Message>[];
    for (var val in map) {
      messages.add(Message(
          val['content'], val['self'], val['isNew'], val['timeProcessed']));
    }
    conversations.add(Conversation(messages, contact));
  }
  conversations.sort((Conversation a, Conversation b) {
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
void persist(List<Conversation> data, Box<List<Map<String, dynamic>>> box) {
  for (var convo in data) {
    var hiveConvo = box.get(convo.contact);
    hiveConvo ??= <Map<String, dynamic>>[];
    box.clear();
    List<Map<String, dynamic>> hiveVal = <Map<String, dynamic>>[];
    var time = 0;
    for (var message in convo.messages) {
      hiveVal.add({
        'content': message.inner,
        'self': message.self,
        'isNew': message.isNew,
        'timeProcessed': message.timeProcessed,
      });
      time = message.timeProcessed;
    }
    for (var message in hiveConvo.reversed) {
      if (message['timeProcessed'] < time) break;
      hiveVal.add({
        'content': message['content'],
        'self': message['self'],
        'isNew': message['isNew'],
        'timeProcessed': message['timeProcessed'],
      });
    }
    box.put(convo.contact, hiveVal);
  }
}
