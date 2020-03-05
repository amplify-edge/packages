///
//  Generated code. Do not modify.
//  source: v3.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReqMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReqMessage', package: const $pb.PackageName('v3'), createEmptyInstance: create)
    ..aOS(1, 'deviceID', protoName: 'deviceID')
    ..aOS(2, 'roomID', protoName: 'roomID')
    ..aOS(3, 'message')
    ..hasRequiredFields = false
  ;

  ReqMessage._() : super();
  factory ReqMessage() => create();
  factory ReqMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReqMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ReqMessage clone() => ReqMessage()..mergeFromMessage(this);
  ReqMessage copyWith(void Function(ReqMessage) updates) => super.copyWith((message) => updates(message as ReqMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReqMessage create() => ReqMessage._();
  ReqMessage createEmptyInstance() => create();
  static $pb.PbList<ReqMessage> createRepeated() => $pb.PbList<ReqMessage>();
  @$core.pragma('dart2js:noInline')
  static ReqMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReqMessage>(create);
  static ReqMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceID => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceID() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomID => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoomID() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class ResMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResMessage', package: const $pb.PackageName('v3'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ResMessage._() : super();
  factory ResMessage() => create();
  factory ResMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResMessage clone() => ResMessage()..mergeFromMessage(this);
  ResMessage copyWith(void Function(ResMessage) updates) => super.copyWith((message) => updates(message as ResMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResMessage create() => ResMessage._();
  ResMessage createEmptyInstance() => create();
  static $pb.PbList<ResMessage> createRepeated() => $pb.PbList<ResMessage>();
  @$core.pragma('dart2js:noInline')
  static ResMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResMessage>(create);
  static ResMessage _defaultInstance;
}

class Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Request', package: const $pb.PackageName('v3'), createEmptyInstance: create)
    ..aOS(1, 'user')
    ..aOS(2, 'roomID', protoName: 'roomID')
    ..aOS(3, 'deviceID', protoName: 'deviceID')
    ..hasRequiredFields = false
  ;

  Request._() : super();
  factory Request() => create();
  factory Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Request clone() => Request()..mergeFromMessage(this);
  Request copyWith(void Function(Request) updates) => super.copyWith((message) => updates(message as Request));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  Request createEmptyInstance() => create();
  static $pb.PbList<Request> createRepeated() => $pb.PbList<Request>();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get user => $_getSZ(0);
  @$pb.TagNumber(1)
  set user($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomID => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoomID() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceID => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeviceID() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceID() => clearField(3);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Message', package: const $pb.PackageName('v3'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'content')
    ..aOS(3, 'roomID', protoName: 'roomID')
    ..aOS(4, 'deviceID', protoName: 'deviceID')
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message() => create();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Message clone() => Message()..mergeFromMessage(this);
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get roomID => $_getSZ(2);
  @$pb.TagNumber(3)
  set roomID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoomID() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoomID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceID => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceID($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceID() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceID() => clearField(4);
}

