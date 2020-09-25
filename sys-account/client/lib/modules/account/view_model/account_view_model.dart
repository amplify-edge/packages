import 'package:sys_account/core/core.dart';

class AccountViewModel extends BaseModel {
  bool _hasResponse = false;
  bool _isEmailEnabled = true;
  bool _isPasswordEnabled = true;
  bool _isRefreshTokenEnabled = false;
  bool _isAccountIdEnabled = false;
  String _userEmail = 'superadmin@getcouragenow.org';
  String _userPassword = 'superadmin';
  String _refreshToken = '';
  String _accessToken = '';
  String _accountId = '1hpR8BL89uYI1ibPNgcRHI9Nn5Wi';
  String _response = '';

  bool get hasResponse => _hasResponse;
  bool get isEmailEnabled => _isEmailEnabled;
  bool get isPasswordEnabled => _isPasswordEnabled;
  bool get isRefreshTokenEnabled => _isRefreshTokenEnabled;
  bool get isAccountEnabled => _isAccountIdEnabled;
  String get getEmail => _userEmail;
  String get getPassword => _userPassword;
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  String get accountId => _accountId;
  String get response => _response;

  void setAccessToken(String value) {
    _accessToken = value;
    notifyListeners();
  }

  void enableEmailField(bool value) {
    _isEmailEnabled = value;
    notifyListeners();
  }

  void enablePasswordField(bool value) {
    _isPasswordEnabled = value;
    notifyListeners();
  }

  void enableRefreshField(bool value) {
    _isRefreshTokenEnabled = value;
    notifyListeners();
  }

  void enableAccountField(bool value) {
    _isAccountIdEnabled = value;
    notifyListeners();
  }

  void enableResponseView(value) {
    _hasResponse = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _userEmail = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _userPassword = value;
    notifyListeners();
  }

  void setRefreshToken(String value) {
    _refreshToken = value;
    notifyListeners();
  }

  void setAccountId(String value) {
    _accountId = value;
    notifyListeners();
  }

  void setResponse(String value) {
    _response = value;
    notifyListeners();
  }
}
