import 'package:flutter/material.dart';

import 'message_outgoing.dart';

/// RealTime is a class representing a RTT notification
class RealTime {
  /// id is unique ID of correspondent user
  final String id;

  /// whether the correspondent has started typing (true) or stopped typing (false)
  final bool isTyping;

  /// Class constructor
  RealTime({@required this.id, @required this.isTyping});
}

/// class representing incoming RTT notifier
class RealTimeIncoming extends RealTime {
  /// Constructor
  RealTimeIncoming({@required String id, @required bool isTyping})
      : super(id: id, isTyping: isTyping);

  RealTimeIncoming.copy(RealTimeIncoming original)
      : super(id: original.id, isTyping: original.isTyping);
}

/// class defining outgoing RTT notifier and its status
class RealTimeOutgoing extends RealTime {
  /// Outgoing message status
  MessageOutgoingStatus status;

  /// Constructor
  RealTimeOutgoing(
      {@required String id,
      @required bool isTyping,
      MessageOutgoingStatus status = MessageOutgoingStatus.NEW})
      : this.status = status,
        super(id: id, isTyping: isTyping);

  RealTimeOutgoing.copy(RealTimeOutgoing original)
      : this.status = original.status,
        super(id: original.id, isTyping: original.isTyping);
}
