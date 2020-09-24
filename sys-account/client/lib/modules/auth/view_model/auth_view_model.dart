import 'package:sys_account/core/core.dart';

class AuthViewModel extends BaseModel {
  bool _hasResponse = false;

  bool get hasResponse => _hasResponse;

  void enableResponseView(value) {
    _hasResponse = value;
    notifyListeners();
  }
}
