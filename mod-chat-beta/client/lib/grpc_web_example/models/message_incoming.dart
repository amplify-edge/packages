import 'package:meta/meta.dart';

import 'message.dart';

/// MessageIncoming is class defining incoming message data (id and text)
class MessageIncoming extends Message {
  /// Constructor
  MessageIncoming(
      {String id,
      @required String senderId,
      @required String groupId,
      @required String text})
      : super(id: id, senderId: senderId, groupId: groupId, text: text);

  MessageIncoming.copy(MessageIncoming original)
      : super(
            id: original.id,
            senderId: original.senderId,
            groupId: original.groupId,
            text: original.text);
}
