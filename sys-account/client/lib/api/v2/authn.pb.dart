///
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

import 'authn.pbenum.dart';

export 'authn.pbenum.dart';

class Project extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Project', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  Project._() : super();
  factory Project() => create();
  factory Project.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Project.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Project clone() => Project()..mergeFromMessage(this);
  Project copyWith(void Function(Project) updates) => super.copyWith((message) => updates(message as Project));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Project create() => Project._();
  Project createEmptyInstance() => create();
  static $pb.PbList<Project> createRepeated() => $pb.PbList<Project>();
  @$core.pragma('dart2js:noInline')
  static Project getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Project>(create);
  static Project _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class Org extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Org', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  Org._() : super();
  factory Org() => create();
  factory Org.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Org.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Org clone() => Org()..mergeFromMessage(this);
  Org copyWith(void Function(Org) updates) => super.copyWith((message) => updates(message as Org));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Org create() => Org._();
  Org createEmptyInstance() => create();
  static $pb.PbList<Org> createRepeated() => $pb.PbList<Org>();
  @$core.pragma('dart2js:noInline')
  static Org getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Org>(create);
  static Org _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

enum UserRoles_Resource {
  project, 
  org, 
  none, 
  all, 
  notSet
}

class UserRoles extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UserRoles_Resource> _UserRoles_ResourceByTag = {
    2 : UserRoles_Resource.project,
    3 : UserRoles_Resource.org,
    4 : UserRoles_Resource.none,
    5 : UserRoles_Resource.all,
    0 : UserRoles_Resource.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserRoles', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5])
    ..e<Roles>(1, 'role', $pb.PbFieldType.OE, defaultOrMaker: Roles.INVALID, valueOf: Roles.valueOf, enumValues: Roles.values)
    ..aOM<Project>(2, 'project', subBuilder: Project.create)
    ..aOM<Org>(3, 'org', subBuilder: Org.create)
    ..aOB(4, 'none')
    ..aOB(5, 'all')
    ..hasRequiredFields = false
  ;

  UserRoles._() : super();
  factory UserRoles() => create();
  factory UserRoles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRoles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserRoles clone() => UserRoles()..mergeFromMessage(this);
  UserRoles copyWith(void Function(UserRoles) updates) => super.copyWith((message) => updates(message as UserRoles));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserRoles create() => UserRoles._();
  UserRoles createEmptyInstance() => create();
  static $pb.PbList<UserRoles> createRepeated() => $pb.PbList<UserRoles>();
  @$core.pragma('dart2js:noInline')
  static UserRoles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRoles>(create);
  static UserRoles _defaultInstance;

  UserRoles_Resource whichResource() => _UserRoles_ResourceByTag[$_whichOneof(0)];
  void clearResource() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Roles get role => $_getN(0);
  @$pb.TagNumber(1)
  set role(Roles v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  @$pb.TagNumber(2)
  Project get project => $_getN(1);
  @$pb.TagNumber(2)
  set project(Project v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProject() => $_has(1);
  @$pb.TagNumber(2)
  void clearProject() => clearField(2);
  @$pb.TagNumber(2)
  Project ensureProject() => $_ensure(1);

  @$pb.TagNumber(3)
  Org get org => $_getN(2);
  @$pb.TagNumber(3)
  set org(Org v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOrg() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrg() => clearField(3);
  @$pb.TagNumber(3)
  Org ensureOrg() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get none => $_getBF(3);
  @$pb.TagNumber(4)
  set none($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNone() => $_has(3);
  @$pb.TagNumber(4)
  void clearNone() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get all => $_getBF(4);
  @$pb.TagNumber(5)
  set all($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAll() => $_has(4);
  @$pb.TagNumber(5)
  void clearAll() => clearField(5);
}

class Account extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Account', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'email')
    ..aOS(3, 'password')
    ..aOM<UserRoles>(4, 'role', subBuilder: UserRoles.create)
    ..hasRequiredFields = false
  ;

  Account._() : super();
  factory Account() => create();
  factory Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Account clone() => Account()..mergeFromMessage(this);
  Account copyWith(void Function(Account) updates) => super.copyWith((message) => updates(message as Account));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Account create() => Account._();
  Account createEmptyInstance() => create();
  static $pb.PbList<Account> createRepeated() => $pb.PbList<Account>();
  @$core.pragma('dart2js:noInline')
  static Account getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Account>(create);
  static Account _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);

  @$pb.TagNumber(4)
  UserRoles get role => $_getN(3);
  @$pb.TagNumber(4)
  set role(UserRoles v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRole() => $_has(3);
  @$pb.TagNumber(4)
  void clearRole() => clearField(4);
  @$pb.TagNumber(4)
  UserRoles ensureRole() => $_ensure(3);
}

class ErrorReason extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrorReason', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'reason')
    ..hasRequiredFields = false
  ;

  ErrorReason._() : super();
  factory ErrorReason() => create();
  factory ErrorReason.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrorReason.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ErrorReason clone() => ErrorReason()..mergeFromMessage(this);
  ErrorReason copyWith(void Function(ErrorReason) updates) => super.copyWith((message) => updates(message as ErrorReason));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorReason create() => ErrorReason._();
  ErrorReason createEmptyInstance() => create();
  static $pb.PbList<ErrorReason> createRepeated() => $pb.PbList<ErrorReason>();
  @$core.pragma('dart2js:noInline')
  static ErrorReason getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorReason>(create);
  static ErrorReason _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reason => $_getSZ(0);
  @$pb.TagNumber(1)
  set reason($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);
}

class RegisterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterRequest', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..aOS(2, 'password')
    ..aOS(3, 'passwordConfirm')
    ..hasRequiredFields = false
  ;

  RegisterRequest._() : super();
  factory RegisterRequest() => create();
  factory RegisterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RegisterRequest clone() => RegisterRequest()..mergeFromMessage(this);
  RegisterRequest copyWith(void Function(RegisterRequest) updates) => super.copyWith((message) => updates(message as RegisterRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  RegisterRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterRequest> createRepeated() => $pb.PbList<RegisterRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get passwordConfirm => $_getSZ(2);
  @$pb.TagNumber(3)
  set passwordConfirm($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPasswordConfirm() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasswordConfirm() => clearField(3);
}

class LoginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginRequest', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..aOS(2, 'password')
    ..hasRequiredFields = false
  ;

  LoginRequest._() : super();
  factory LoginRequest() => create();
  factory LoginRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  LoginRequest copyWith(void Function(LoginRequest) updates) => super.copyWith((message) => updates(message as LoginRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() => $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class LoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginResponse', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'accessToken')
    ..aOS(3, 'refreshToken')
    ..aOM<ErrorReason>(4, 'errorReason', subBuilder: ErrorReason.create)
    ..aOM<$0.Timestamp>(5, 'lastLogin', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  LoginResponse._() : super();
  factory LoginResponse() => create();
  factory LoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  LoginResponse copyWith(void Function(LoginResponse) updates) => super.copyWith((message) => updates(message as LoginResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accessToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set accessToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => clearField(3);

  @$pb.TagNumber(4)
  ErrorReason get errorReason => $_getN(3);
  @$pb.TagNumber(4)
  set errorReason(ErrorReason v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorReason() => clearField(4);
  @$pb.TagNumber(4)
  ErrorReason ensureErrorReason() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Timestamp get lastLogin => $_getN(4);
  @$pb.TagNumber(5)
  set lastLogin($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastLogin() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastLogin() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureLastLogin() => $_ensure(4);
}

class RegisterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterResponse', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'successMsg')
    ..aOM<ErrorReason>(3, 'errorReason', subBuilder: ErrorReason.create)
    ..hasRequiredFields = false
  ;

  RegisterResponse._() : super();
  factory RegisterResponse() => create();
  factory RegisterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RegisterResponse clone() => RegisterResponse()..mergeFromMessage(this);
  RegisterResponse copyWith(void Function(RegisterResponse) updates) => super.copyWith((message) => updates(message as RegisterResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterResponse create() => RegisterResponse._();
  RegisterResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterResponse> createRepeated() => $pb.PbList<RegisterResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterResponse>(create);
  static RegisterResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get successMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set successMsg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessMsg() => clearField(2);

  @$pb.TagNumber(3)
  ErrorReason get errorReason => $_getN(2);
  @$pb.TagNumber(3)
  set errorReason(ErrorReason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorReason() => clearField(3);
  @$pb.TagNumber(3)
  ErrorReason ensureErrorReason() => $_ensure(2);
}

class ForgotPasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ForgotPasswordRequest', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..hasRequiredFields = false
  ;

  ForgotPasswordRequest._() : super();
  factory ForgotPasswordRequest() => create();
  factory ForgotPasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgotPasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ForgotPasswordRequest clone() => ForgotPasswordRequest()..mergeFromMessage(this);
  ForgotPasswordRequest copyWith(void Function(ForgotPasswordRequest) updates) => super.copyWith((message) => updates(message as ForgotPasswordRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest create() => ForgotPasswordRequest._();
  ForgotPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordRequest> createRepeated() => $pb.PbList<ForgotPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordRequest>(create);
  static ForgotPasswordRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class ForgotPasswordResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ForgotPasswordResponse', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'successMsg')
    ..aOM<ErrorReason>(3, 'errorReason', subBuilder: ErrorReason.create)
    ..aOM<$0.Timestamp>(4, 'forgotPasswordRequestedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ForgotPasswordResponse._() : super();
  factory ForgotPasswordResponse() => create();
  factory ForgotPasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgotPasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ForgotPasswordResponse clone() => ForgotPasswordResponse()..mergeFromMessage(this);
  ForgotPasswordResponse copyWith(void Function(ForgotPasswordResponse) updates) => super.copyWith((message) => updates(message as ForgotPasswordResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse create() => ForgotPasswordResponse._();
  ForgotPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordResponse> createRepeated() => $pb.PbList<ForgotPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordResponse>(create);
  static ForgotPasswordResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get successMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set successMsg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessMsg() => clearField(2);

  @$pb.TagNumber(3)
  ErrorReason get errorReason => $_getN(2);
  @$pb.TagNumber(3)
  set errorReason(ErrorReason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorReason() => clearField(3);
  @$pb.TagNumber(3)
  ErrorReason ensureErrorReason() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get forgotPasswordRequestedAt => $_getN(3);
  @$pb.TagNumber(4)
  set forgotPasswordRequestedAt($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasForgotPasswordRequestedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearForgotPasswordRequestedAt() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureForgotPasswordRequestedAt() => $_ensure(3);
}

class ResetPasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResetPasswordRequest', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..aOS(2, 'password')
    ..aOS(3, 'passwordConfirm')
    ..hasRequiredFields = false
  ;

  ResetPasswordRequest._() : super();
  factory ResetPasswordRequest() => create();
  factory ResetPasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResetPasswordRequest clone() => ResetPasswordRequest()..mergeFromMessage(this);
  ResetPasswordRequest copyWith(void Function(ResetPasswordRequest) updates) => super.copyWith((message) => updates(message as ResetPasswordRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest create() => ResetPasswordRequest._();
  ResetPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordRequest> createRepeated() => $pb.PbList<ResetPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordRequest>(create);
  static ResetPasswordRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get passwordConfirm => $_getSZ(2);
  @$pb.TagNumber(3)
  set passwordConfirm($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPasswordConfirm() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasswordConfirm() => clearField(3);
}

class ResetPasswordResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResetPasswordResponse', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'successMsg')
    ..aOM<ErrorReason>(3, 'errorReason', subBuilder: ErrorReason.create)
    ..aOM<$0.Timestamp>(4, 'resetPasswordRequestedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ResetPasswordResponse._() : super();
  factory ResetPasswordResponse() => create();
  factory ResetPasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResetPasswordResponse clone() => ResetPasswordResponse()..mergeFromMessage(this);
  ResetPasswordResponse copyWith(void Function(ResetPasswordResponse) updates) => super.copyWith((message) => updates(message as ResetPasswordResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse create() => ResetPasswordResponse._();
  ResetPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordResponse> createRepeated() => $pb.PbList<ResetPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordResponse>(create);
  static ResetPasswordResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get successMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set successMsg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessMsg() => clearField(2);

  @$pb.TagNumber(3)
  ErrorReason get errorReason => $_getN(2);
  @$pb.TagNumber(3)
  set errorReason(ErrorReason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorReason() => clearField(3);
  @$pb.TagNumber(3)
  ErrorReason ensureErrorReason() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get resetPasswordRequestedAt => $_getN(3);
  @$pb.TagNumber(4)
  set resetPasswordRequestedAt($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasResetPasswordRequestedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearResetPasswordRequestedAt() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureResetPasswordRequestedAt() => $_ensure(3);
}

class RefreshAccessTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RefreshAccessTokenRequest', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'refreshToken')
    ..hasRequiredFields = false
  ;

  RefreshAccessTokenRequest._() : super();
  factory RefreshAccessTokenRequest() => create();
  factory RefreshAccessTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshAccessTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RefreshAccessTokenRequest clone() => RefreshAccessTokenRequest()..mergeFromMessage(this);
  RefreshAccessTokenRequest copyWith(void Function(RefreshAccessTokenRequest) updates) => super.copyWith((message) => updates(message as RefreshAccessTokenRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshAccessTokenRequest create() => RefreshAccessTokenRequest._();
  RefreshAccessTokenRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshAccessTokenRequest> createRepeated() => $pb.PbList<RefreshAccessTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshAccessTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshAccessTokenRequest>(create);
  static RefreshAccessTokenRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => clearField(1);
}

class RefreshAccessTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RefreshAccessTokenResponse', package: const $pb.PackageName('getcouragenow.v2.sys_account'), createEmptyInstance: create)
    ..aOS(1, 'accessToken')
    ..aOM<ErrorReason>(2, 'errorReason', subBuilder: ErrorReason.create)
    ..hasRequiredFields = false
  ;

  RefreshAccessTokenResponse._() : super();
  factory RefreshAccessTokenResponse() => create();
  factory RefreshAccessTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshAccessTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RefreshAccessTokenResponse clone() => RefreshAccessTokenResponse()..mergeFromMessage(this);
  RefreshAccessTokenResponse copyWith(void Function(RefreshAccessTokenResponse) updates) => super.copyWith((message) => updates(message as RefreshAccessTokenResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshAccessTokenResponse create() => RefreshAccessTokenResponse._();
  RefreshAccessTokenResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshAccessTokenResponse> createRepeated() => $pb.PbList<RefreshAccessTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshAccessTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshAccessTokenResponse>(create);
  static RefreshAccessTokenResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  ErrorReason get errorReason => $_getN(1);
  @$pb.TagNumber(2)
  set errorReason(ErrorReason v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorReason() => clearField(2);
  @$pb.TagNumber(2)
  ErrorReason ensureErrorReason() => $_ensure(1);
}

class AuthServiceApi {
  $pb.RpcClient _client;
  AuthServiceApi(this._client);

  $async.Future<RegisterResponse> register($pb.ClientContext ctx, RegisterRequest request) {
    var emptyResponse = RegisterResponse();
    return _client.invoke<RegisterResponse>(ctx, 'AuthService', 'Register', request, emptyResponse);
  }
  $async.Future<LoginResponse> login($pb.ClientContext ctx, LoginRequest request) {
    var emptyResponse = LoginResponse();
    return _client.invoke<LoginResponse>(ctx, 'AuthService', 'Login', request, emptyResponse);
  }
  $async.Future<ForgotPasswordResponse> forgotPassword($pb.ClientContext ctx, ForgotPasswordRequest request) {
    var emptyResponse = ForgotPasswordResponse();
    return _client.invoke<ForgotPasswordResponse>(ctx, 'AuthService', 'ForgotPassword', request, emptyResponse);
  }
  $async.Future<ResetPasswordResponse> resetPassword($pb.ClientContext ctx, ResetPasswordRequest request) {
    var emptyResponse = ResetPasswordResponse();
    return _client.invoke<ResetPasswordResponse>(ctx, 'AuthService', 'ResetPassword', request, emptyResponse);
  }
  $async.Future<RefreshAccessTokenResponse> refreshAccessToken($pb.ClientContext ctx, RefreshAccessTokenRequest request) {
    var emptyResponse = RefreshAccessTokenResponse();
    return _client.invoke<RefreshAccessTokenResponse>(ctx, 'AuthService', 'RefreshAccessToken', request, emptyResponse);
  }
}

