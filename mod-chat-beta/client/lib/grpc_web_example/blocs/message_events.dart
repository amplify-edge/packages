import 'package:meta/meta.dart';
import 'package:mod_chat/grpc_web_example/models/message_outgoing.dart';

/// New message created event
class MessageNewCreatedEvent {
  final MessageOutgoing message;

  MessageNewCreatedEvent({@required this.message});
}

/// Message sent to the server event
class MessageSentEvent {
  final String id;
  final String groupId;
  final String senderId;

  MessageSentEvent(
      {@required this.id, @required this.groupId, @required this.senderId});
}

/// Message failed to send to the server event
class MessageSendFailedEvent {
  final String id;
  final String error;

  MessageSendFailedEvent({@required this.id, @required this.error});
}

/// Message received from the server event
class MessageReceivedEvent {
  final String id;
  final String text;
  final String groupId;
  final String senderId;

  MessageReceivedEvent(
      {@required this.id,
      @required this.text,
      @required this.groupId,
      @required this.senderId});
}

/// Message failed to receive from the server event
class MessageReceiveFailedEvent {
  final String error;

  MessageReceiveFailedEvent({@required this.error});
}
