import 'dart:async';
import 'dart:html';

import 'package:grpc/grpc_web.dart';
import 'package:mod_chat/grpc_web_example/api/v1/service.pbgrpc.dart' as grpc;
import 'package:mod_chat/grpc_web_example/blocs/message_events.dart';
import 'package:mod_chat/grpc_web_example/models/message_outgoing.dart';
import 'package:mod_chat/grpc_web_example/models/readreceipts.dart';

// TODO: Accommodate RTT and Read Receipts

/// ChatService client implementation
class ChatService {
  // _isolateSending is isolate to send chat messages
  // Isolate _isolateSending;

  // // Port to send message
  // SendPort _portSending;

  // // Port to get status of message sending
  // ReceivePort _portSendStatus;

  // // _isolateReceiving is isolate to receive chat messages
  // Isolate _isolateReceiving;

  // // Port to receive messages
  // ReceivePort _portReceiving;

  /// Event is raised when message has been sent to the server successfully
  final void Function(MessageSentEvent event) onMessageSent;

  /// Event is raised when message sending is failed
  final void Function(MessageSendFailedEvent event) onMessageSendFailed;

  /// Event is raised when message has been received from the server
  final void Function(MessageReceivedEvent event) onMessageReceived;

  /// Event is raised when message receiving is failed
  final void Function(MessageReceiveFailedEvent event) onMessageReceiveFailed;

  final channel = GrpcWebClientChannel.xhr(Uri.parse(window.location.origin));

  /// Constructor
  ChatService(
      {this.onMessageSent,
      this.onMessageSendFailed,
      this.onMessageReceived,
      this.onMessageReceiveFailed});

  // : _portSendStatus = ReceivePort(),
  //   _portReceiving = ReceivePort();

  // Start threads to send and receive messages

  void start() {
    recv();
  }

  void recv() async {
    do {
      var stream = grpc.BroadcastClient(channel).createStream(grpc.Connect());
      try {
        // create new client
        await for (var message in stream) {
          onMessageReceived(MessageReceivedEvent(
              text: message.content,
              id: message.id,
              groupId: message.groupId,
              senderId: message.senderName));
        }
      } catch (e) {
        onMessageReceiveFailed(MessageReceiveFailedEvent(error: e.toString()));
        await Future.delayed(const Duration(seconds: 5));
      }
      // try to connect again
    } while (true);
  }

  void shutdown() {}

  /// Send message to the server
  void send(MessageOutgoing message) {
    //var request = StringValue.create();
    //request.value = message.text;

    var msg = grpc.Message.create();
    msg.id = message.id;
    msg.content = message.text;
    msg.timestamp = DateTime.now().toString();
    msg.groupId = message.groupId;
    msg.senderName = message.senderName;

    grpc.BroadcastClient(channel).broadcastMessage(msg);
    onMessageSent(MessageSentEvent(
        id: message.id,
        groupId: message.groupId,
        senderId: message.senderName));
  }

  /// Send message to the server
  void sendRTT(ReadReceipt message) {
    //var request = StringValue.create();
    //request.value = message.text;

    // TODO: Implement Web send of RTT
  }

  /// Send message to the server
  void sendRR(ReadReceipt message) {
    //var request = StringValue.create();
    //request.value = message.text;

    // TODO: Implement Web send of RR
  }
}
