import 'package:flutter/material.dart';

import 'package:modkanban/features/grpc_web_example/api/chat_service.dart' if (dart.library.html) 'package:modkanban/features/grpc_web_example/api/chat_service_web.dart';


import 'package:modkanban/features/grpc_web_example/blocs/bloc.dart';
import 'package:modkanban/features/grpc_web_example/blocs/bloc_provider.dart';
import 'package:modkanban/features/grpc_web_example/blocs/message_events.dart';

import 'package:modkanban/features/grpc_web_example/pages/home.dart';
import 'package:modkanban/features/grpc_web_example/theme.dart';

// Stateful application widget
class GRPCWebApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GRPCWebAppState();
}

// State for application widget
class _GRPCWebAppState extends State<GRPCWebApp> {
  // BLoc for application
  GRPCWebBloc _appBloc;

  /// Chat client service
  ChatService _service;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // As the context of not yet available at initState() level,
    // if not yet initialized, we get application BLoc to start
    // gRPC isolates
    if (_isInit == false) {
      _appBloc = BlocProvider.of<GRPCWebBloc>(context);

      // initialize Chat client service
      _service = ChatService(
          onMessageSent: _onMessageSent,
          onMessageSendFailed: _onMessageSendFailed,
          onMessageReceived: _onMessageReceived,
          onMessageReceiveFailed: _onMessageReceiveFailed);
      _service.start();

      _listenMessagesToSend();

      if (mounted) {
        setState(() {
          _isInit = true;
        });
      }
    }
  }

  void _listenMessagesToSend() async {
    await for (var event in _appBloc.outMessageSend) {
      _service.send(event.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter gRPC Web',
      theme: isIOS(context) ? kIOSTheme : kDefaultTheme,
      home: HomePage(),
    );
  }

  @override
  void dispose() {
    // close Chat client service
    _service.shutdown();
    _service = null;

    super.dispose();
  }

  /// 'outgoing message sent to the server' event
  void _onMessageSent(MessageSentEvent event) {
    debugPrint('Message "${event.id}" sent to the server');
    _appBloc.inMessageSent.add(event);
  }

  /// 'failed to send message' event
  void _onMessageSendFailed(MessageSendFailedEvent event) {
    debugPrint(
        'Failed to send message "${event.id}" to the server: ${event.error}');
    _appBloc.inMessageSendFailed.add(event);
  }

  /// 'new incoming message received from the server' event
  void _onMessageReceived(MessageReceivedEvent event) {
    debugPrint('Message received from the server: ${event.text}');
    _appBloc.inMessageReceived.add(event);
  }

  /// 'failed to receive messages' event
  void _onMessageReceiveFailed(MessageReceiveFailedEvent event) {
    debugPrint('Failed to receive messages from the server: ${event.error}');
  }
}
