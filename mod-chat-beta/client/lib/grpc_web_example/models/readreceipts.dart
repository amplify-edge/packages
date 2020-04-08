import 'package:flutter/material.dart';

import 'message_outgoing.dart';

/// class representing a read receipt notification
class ReadReceipt {
  /// id is unique ID of correspondent message
  final String id;

  /// Class constructor
  ReadReceipt({@required this.id});
}

/// class representing incoming read receipt notifier
class ReadReceiptIncoming extends ReadReceipt {
  /// Constructor
  ReadReceiptIncoming({@required String id}) : super(id: id);

  ReadReceiptIncoming.copy(ReadReceiptIncoming original)
      : super(id: original.id);
}

/// class defining outgoing read receipt notifier and its status
class ReadReceiptOutgoing extends ReadReceipt {
  /// Outgoing message status
  MessageOutgoingStatus status;

  /// Constructor
  ReadReceiptOutgoing(
      {@required String id,
      MessageOutgoingStatus status = MessageOutgoingStatus.NEW})
      : this.status = status,
        super(id: id);

  ReadReceiptOutgoing.copy(ReadReceiptOutgoing original)
      : this.status = original.status,
        super(id: original.id);
}
