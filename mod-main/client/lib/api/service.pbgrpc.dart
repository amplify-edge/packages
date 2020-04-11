///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'service.pb.dart' as $0;
export 'service.pb.dart';

class QuestionClient extends $grpc.Client {
  static final _$newAnswer =
      $grpc.ClientMethod<$0.NewAnswerRequest, $0.NewAnswerResponse>(
          '/proto.Question/NewAnswer',
          ($0.NewAnswerRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NewAnswerResponse.fromBuffer(value));
  static final _$getAnswer = $grpc.ClientMethod<$0.AnswerIdRequest, $0.Answer>(
      '/proto.Question/GetAnswer',
      ($0.AnswerIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Answer.fromBuffer(value));
  static final _$deleteAnswer =
      $grpc.ClientMethod<$0.AnswerIdRequest, $0.DeleteAnswerResponse>(
          '/proto.Question/DeleteAnswer',
          ($0.AnswerIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteAnswerResponse.fromBuffer(value));

  QuestionClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.NewAnswerResponse> newAnswer(
      $0.NewAnswerRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$newAnswer, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.Answer> getAnswer($0.AnswerIdRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getAnswer, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.DeleteAnswerResponse> deleteAnswer(
      $0.AnswerIdRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteAnswer, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class QuestionServiceBase extends $grpc.Service {
  $core.String get $name => 'proto.Question';

  QuestionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NewAnswerRequest, $0.NewAnswerResponse>(
        'NewAnswer',
        newAnswer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NewAnswerRequest.fromBuffer(value),
        ($0.NewAnswerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AnswerIdRequest, $0.Answer>(
        'GetAnswer',
        getAnswer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AnswerIdRequest.fromBuffer(value),
        ($0.Answer value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AnswerIdRequest, $0.DeleteAnswerResponse>(
        'DeleteAnswer',
        deleteAnswer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AnswerIdRequest.fromBuffer(value),
        ($0.DeleteAnswerResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NewAnswerResponse> newAnswer_Pre($grpc.ServiceCall call,
      $async.Future<$0.NewAnswerRequest> request) async {
    return newAnswer(call, await request);
  }

  $async.Future<$0.Answer> getAnswer_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AnswerIdRequest> request) async {
    return getAnswer(call, await request);
  }

  $async.Future<$0.DeleteAnswerResponse> deleteAnswer_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AnswerIdRequest> request) async {
    return deleteAnswer(call, await request);
  }

  $async.Future<$0.NewAnswerResponse> newAnswer(
      $grpc.ServiceCall call, $0.NewAnswerRequest request);
  $async.Future<$0.Answer> getAnswer(
      $grpc.ServiceCall call, $0.AnswerIdRequest request);
  $async.Future<$0.DeleteAnswerResponse> deleteAnswer(
      $grpc.ServiceCall call, $0.AnswerIdRequest request);
}
