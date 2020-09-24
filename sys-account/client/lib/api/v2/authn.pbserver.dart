///
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'authn.pb.dart' as $1;
import 'authn.pbjson.dart';

export 'authn.pb.dart';

abstract class AuthServiceBase extends $pb.GeneratedService {
  $async.Future<$1.RegisterResponse> register($pb.ServerContext ctx, $1.RegisterRequest request);
  $async.Future<$1.LoginResponse> login($pb.ServerContext ctx, $1.LoginRequest request);
  $async.Future<$1.ForgotPasswordResponse> forgotPassword($pb.ServerContext ctx, $1.ForgotPasswordRequest request);
  $async.Future<$1.ResetPasswordResponse> resetPassword($pb.ServerContext ctx, $1.ResetPasswordRequest request);
  $async.Future<$1.RefreshAccessTokenResponse> refreshAccessToken($pb.ServerContext ctx, $1.RefreshAccessTokenRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'Register': return $1.RegisterRequest();
      case 'Login': return $1.LoginRequest();
      case 'ForgotPassword': return $1.ForgotPasswordRequest();
      case 'ResetPassword': return $1.ResetPasswordRequest();
      case 'RefreshAccessToken': return $1.RefreshAccessTokenRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'Register': return this.register(ctx, request);
      case 'Login': return this.login(ctx, request);
      case 'ForgotPassword': return this.forgotPassword(ctx, request);
      case 'ResetPassword': return this.resetPassword(ctx, request);
      case 'RefreshAccessToken': return this.refreshAccessToken(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AuthServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => AuthServiceBase$messageJson;
}

