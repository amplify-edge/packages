///
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'google/protobuf/timestamp.pbjson.dart' as $0;

const ErrorReason$json = const {
  '1': 'ErrorReason',
  '2': const [
    const {'1': 'reason', '3': 1, '4': 1, '5': 9, '10': 'reason'},
  ],
};

const RegisterRequest$json = const {
  '1': 'RegisterRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'password_confirm', '3': 3, '4': 1, '5': 9, '10': 'passwordConfirm'},
  ],
};

const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 3, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'error_reason', '3': 4, '4': 1, '5': 11, '6': '.getcouragenow.v2.sys_account.ErrorReason', '10': 'errorReason'},
    const {'1': 'last_login', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
  ],
};

const RegisterResponse$json = const {
  '1': 'RegisterResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'success_msg', '3': 2, '4': 1, '5': 9, '10': 'successMsg'},
    const {'1': 'error_reason', '3': 3, '4': 1, '5': 11, '6': '.getcouragenow.v2.sys_account.ErrorReason', '10': 'errorReason'},
  ],
};

const ForgotPasswordRequest$json = const {
  '1': 'ForgotPasswordRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

const ForgotPasswordResponse$json = const {
  '1': 'ForgotPasswordResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'success_msg', '3': 2, '4': 1, '5': 9, '10': 'successMsg'},
    const {'1': 'error_reason', '3': 3, '4': 1, '5': 11, '6': '.getcouragenow.v2.sys_account.ErrorReason', '10': 'errorReason'},
    const {'1': 'forgot_password_requested_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'forgotPasswordRequestedAt'},
  ],
};

const ResetPasswordRequest$json = const {
  '1': 'ResetPasswordRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'password_confirm', '3': 3, '4': 1, '5': 9, '10': 'passwordConfirm'},
  ],
};

const ResetPasswordResponse$json = const {
  '1': 'ResetPasswordResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'success_msg', '3': 2, '4': 1, '5': 9, '10': 'successMsg'},
    const {'1': 'error_reason', '3': 3, '4': 1, '5': 11, '6': '.getcouragenow.v2.sys_account.ErrorReason', '10': 'errorReason'},
    const {'1': 'reset_password_requested_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resetPasswordRequestedAt'},
  ],
};

const RefreshAccessTokenRequest$json = const {
  '1': 'RefreshAccessTokenRequest',
  '2': const [
    const {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

const RefreshAccessTokenResponse$json = const {
  '1': 'RefreshAccessTokenResponse',
  '2': const [
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'error_reason', '3': 2, '4': 1, '5': 11, '6': '.getcouragenow.v2.sys_account.ErrorReason', '10': 'errorReason'},
  ],
};

const AuthServiceBase$json = const {
  '1': 'AuthService',
  '2': const [
    const {'1': 'Register', '2': '.getcouragenow.v2.sys_account.RegisterRequest', '3': '.getcouragenow.v2.sys_account.RegisterResponse', '4': const {}},
    const {'1': 'Login', '2': '.getcouragenow.v2.sys_account.LoginRequest', '3': '.getcouragenow.v2.sys_account.LoginResponse', '4': const {}},
    const {'1': 'ForgotPassword', '2': '.getcouragenow.v2.sys_account.ForgotPasswordRequest', '3': '.getcouragenow.v2.sys_account.ForgotPasswordResponse', '4': const {}},
    const {'1': 'ResetPassword', '2': '.getcouragenow.v2.sys_account.ResetPasswordRequest', '3': '.getcouragenow.v2.sys_account.ResetPasswordResponse', '4': const {}},
    const {'1': 'RefreshAccessToken', '2': '.getcouragenow.v2.sys_account.RefreshAccessTokenRequest', '3': '.getcouragenow.v2.sys_account.RefreshAccessTokenResponse', '4': const {}},
  ],
};

const AuthServiceBase$messageJson = const {
  '.getcouragenow.v2.sys_account.RegisterRequest': RegisterRequest$json,
  '.getcouragenow.v2.sys_account.RegisterResponse': RegisterResponse$json,
  '.getcouragenow.v2.sys_account.ErrorReason': ErrorReason$json,
  '.getcouragenow.v2.sys_account.LoginRequest': LoginRequest$json,
  '.getcouragenow.v2.sys_account.LoginResponse': LoginResponse$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.getcouragenow.v2.sys_account.ForgotPasswordRequest': ForgotPasswordRequest$json,
  '.getcouragenow.v2.sys_account.ForgotPasswordResponse': ForgotPasswordResponse$json,
  '.getcouragenow.v2.sys_account.ResetPasswordRequest': ResetPasswordRequest$json,
  '.getcouragenow.v2.sys_account.ResetPasswordResponse': ResetPasswordResponse$json,
  '.getcouragenow.v2.sys_account.RefreshAccessTokenRequest': RefreshAccessTokenRequest$json,
  '.getcouragenow.v2.sys_account.RefreshAccessTokenResponse': RefreshAccessTokenResponse$json,
};

