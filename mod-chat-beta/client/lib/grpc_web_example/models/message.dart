import 'package:flutter/material.dart';

/// Message is class defining message data (id and text)
class Message {
  /// id is unique ID of message
  final String id;

  /// unique ID of message's sender
  final String senderId;

  /// unique ID of message's group
  final String groupId;

  /// text is content of message
  final String text;

  /// Class constructor
  Message(
      {String id,
      @required this.senderId,
      @required this.groupId,
      @required String text})
      : this.id = id ?? UniqueKey().toString(),
        this.text = text;
}
