///
//  Generated code. Do not modify.
//  source: users.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'users.pb.dart' as $3;
import 'users.pbjson.dart';

export 'users.pb.dart';

abstract class AccountServiceBase extends $pb.GeneratedService {
  $async.Future<$3.Account> newAccount($pb.ServerContext ctx, $3.Account request);
  $async.Future<$3.Account> getAccount($pb.ServerContext ctx, $3.GetAccountRequest request);
  $async.Future<$3.ListAccountsResponse> listAccounts($pb.ServerContext ctx, $3.ListAccountsRequest request);
  $async.Future<$3.SearchAccountsResponse> searchAccounts($pb.ServerContext ctx, $3.SearchAccountsRequest request);
  $async.Future<$3.Account> assignAccountToRole($pb.ServerContext ctx, $3.AssignAccountToRoleRequest request);
  $async.Future<$3.Account> updateAccount($pb.ServerContext ctx, $3.Account request);
  $async.Future<$3.Account> disableAccount($pb.ServerContext ctx, $3.DisableAccountRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'NewAccount': return $3.Account();
      case 'GetAccount': return $3.GetAccountRequest();
      case 'ListAccounts': return $3.ListAccountsRequest();
      case 'SearchAccounts': return $3.SearchAccountsRequest();
      case 'AssignAccountToRole': return $3.AssignAccountToRoleRequest();
      case 'UpdateAccount': return $3.Account();
      case 'DisableAccount': return $3.DisableAccountRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'NewAccount': return this.newAccount(ctx, request);
      case 'GetAccount': return this.getAccount(ctx, request);
      case 'ListAccounts': return this.listAccounts(ctx, request);
      case 'SearchAccounts': return this.searchAccounts(ctx, request);
      case 'AssignAccountToRole': return this.assignAccountToRole(ctx, request);
      case 'UpdateAccount': return this.updateAccount(ctx, request);
      case 'DisableAccount': return this.disableAccount(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AccountServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => AccountServiceBase$messageJson;
}

