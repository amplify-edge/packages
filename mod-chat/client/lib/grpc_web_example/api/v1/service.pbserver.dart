///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'service.pb.dart' as $0;
import 'service.pbjson.dart';

export 'service.pb.dart';

abstract class BroadcastServiceBase extends $pb.GeneratedService {
  $async.Future<$0.Message> createStream($pb.ServerContext ctx, $0.Connect request);
  $async.Future<$0.Close> broadcastMessage($pb.ServerContext ctx, $0.Message request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateStream': return $0.Connect();
      case 'BroadcastMessage': return $0.Message();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateStream': return this.createStream(ctx, request);
      case 'BroadcastMessage': return this.broadcastMessage(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => BroadcastServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => BroadcastServiceBase$messageJson;
}

