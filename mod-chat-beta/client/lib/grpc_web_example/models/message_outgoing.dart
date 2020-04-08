import 'package:meta/meta.dart';

import 'message.dart';

/// Outgoing message statuses
/// NEW - message just created and is not sent yet
/// SENT - message is sent to the server successfully
/// FAILED - error has happened while sending message
enum MessageOutgoingStatus { NEW, SENT, FAILED }

/// MessageOutgoing is class defining outgoing message data (id and text) and status
class MessageOutgoing extends Message {
  /// Outgoing message status
  MessageOutgoingStatus status;

  /// Constructor
  MessageOutgoing(
      {String id,
      @required String senderId,
      @required String groupId,
      @required String text,
      MessageOutgoingStatus status = MessageOutgoingStatus.NEW})
      : this.status = status,
        super(id: id, senderId: senderId, groupId: groupId, text: text);

  MessageOutgoing.copy(MessageOutgoing original)
      : this.status = original.status,
        super(
            id: original.id,
            senderId: original.senderId,
            groupId: original.groupId,
            text: original.text);
}
