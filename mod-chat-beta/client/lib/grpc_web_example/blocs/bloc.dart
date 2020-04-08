import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:mod_chat/grpc_web_example/api/chat_service.dart'
    if (dart.library.html) 'package:mod_chat/grpc_web_example/api/chat_service_web.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mod_chat/grpc_web_example/models/message.dart';
import 'package:mod_chat/grpc_web_example/models/message_incoming.dart';
import 'package:mod_chat/grpc_web_example/models/message_outgoing.dart';

import 'bloc_provider.dart';
import 'message_events.dart';

/// BLoC class
class GRPCWebBloc implements BlocBase {
  // Application state (chat messages)
  final _messages = Set<Message>();

  ChatService _service;

  ChatService get service => _service;

  /// Controller is used to notify when message created
  final _messageCreatedController =
      new BehaviorSubject<MessageNewCreatedEvent>();

  Sink<MessageNewCreatedEvent> get inNewMessageCreated =>
      _messageCreatedController.sink;

  /// Controller is used to send message to the server
  final _messageSendController = new BehaviorSubject<MessageNewCreatedEvent>();

  Sink<MessageNewCreatedEvent> get inMessageSend => _messageSendController.sink;

  Stream<MessageNewCreatedEvent> get outMessageSend =>
      _messageSendController.stream;

  /// Controller is used to notify when message sent to the server
  final _messageSentController = new BehaviorSubject<MessageSentEvent>();

  Sink<MessageSentEvent> get inMessageSent => _messageSentController.sink;

  /// Controller is used to notify when message failed to send to the server
  final _messageSendFailedController =
      new BehaviorSubject<MessageSendFailedEvent>();

  Sink<MessageSendFailedEvent> get inMessageSendFailed =>
      _messageSendFailedController.sink;

  /// Controller is used to notify when message received from the server
  final _messageReceivedController =
      new BehaviorSubject<MessageReceivedEvent>();

  Sink<MessageReceivedEvent> get inMessageReceived =>
      _messageReceivedController.sink;

  /// Controller is used to provide state (chat messages) to the widgets
  final _messagesController = new BehaviorSubject<List<Message>>(seedValue: []);

  Sink<List<Message>> get _inMessages => _messagesController.sink;

  Stream<List<Message>> get outMessages => _messagesController.stream;

  /// Constructor
  GRPCWebBloc() {
    _service = ChatService(
        onMessageSent: _onMessageSent,
        onMessageSendFailed: _onMessageSendFailed,
        onMessageReceived: _onMessageReceived,
        onMessageReceiveFailed: _onMessageReceiveFailed);
    _service.start();
    _listenMessagesToSend();

    _messageCreatedController.listen(_onNewMessageCreated);
    _messageSentController.listen(_onMessageSent);
    _messageSendFailedController.listen(_onMessageSendFailed);
    _messageReceivedController.listen(_onMessageReceived);
  }

  void _listenMessagesToSend() async {
    await for (var event in outMessageSend) {
      _service.send(event.message);
    }
  }

  /// Dispose resources
  void dispose() {
    _messageCreatedController.close();
    _messageSendController.close();
    _messageSentController.close();
    _messageSendFailedController.close();
    _messageReceivedController.close();
    _messagesController.close();
  }

  /// Handle event: new message created
  void _onNewMessageCreated(MessageNewCreatedEvent event) {
    _messages.add(event.message);
    _notify();
    _messageSendController.add(event);
  }

  /// Handle event: message sent to the server
  void _onMessageSent(MessageSentEvent event) {
    debugPrint('Message "${event.id}" sent to the server');
    _findOutgoingMessage(event.id).status = MessageOutgoingStatus.SENT;
    _notify();
  }

  /// Handle event: message failed to send to the server
  void _onMessageSendFailed(MessageSendFailedEvent event) {
    debugPrint(
        'Failed to send message "${event.id}" to the server: ${event.error}');
    _findOutgoingMessage(event.id).status = MessageOutgoingStatus.FAILED;
    _notify();
  }

  /// Handle event: message received from the server
  void _onMessageReceived(MessageReceivedEvent event) {
    debugPrint('Message received from the server: ${event.text}');
    _messages.add(MessageIncoming(text: event.text));
    _notify();
  }

  /// 'failed to receive messages' event
  void _onMessageReceiveFailed(MessageReceiveFailedEvent event) {
    debugPrint('Failed to receive messages from the server: ${event.error}');
  }

  /// Publish state (chat messages) to the widgets
  void _notify() {
    _inMessages.add(UnmodifiableListView(_messages));
  }

  /// Find outgoing message by 'id' in the state (chat messages)
  MessageOutgoing _findOutgoingMessage(String id) {
    var message =
        _messages.firstWhere((message) => message.id == id, orElse: () => null);
    assert(message != null, 'Sent message with id="$id" is not found in state');
    assert(message is MessageOutgoing,
        'Invalid message (id="$id") type ${message.runtimeType}; must be MessageOutgoing');
    return message;
  }
}
