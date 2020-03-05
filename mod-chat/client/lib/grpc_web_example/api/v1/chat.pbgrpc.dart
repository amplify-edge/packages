///
//  Generated code. Do not modify.
//  source: v3.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.ReqMessage, $0.ResMessage>(
      '/v3.ChatService/Send',
      ($0.ReqMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResMessage.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$0.Request, $0.Message>(
      '/v3.ChatService/Subscribe',
      ($0.Request value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.ResMessage> send($0.ReqMessage request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$send, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Message> subscribe($0.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$subscribe, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'v3.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ReqMessage, $0.ResMessage>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReqMessage.fromBuffer(value),
        ($0.ResMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Request, $0.Message>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Request.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.ResMessage> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ReqMessage> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.Message> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Request> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$0.ResMessage> send(
      $grpc.ServiceCall call, $0.ReqMessage request);
  $async.Stream<$0.Message> subscribe(
      $grpc.ServiceCall call, $0.Request request);
}
