library client;

//conditional import for web and native
import 'package:mod_session/src/device_info.dart'
    if (dart.library.js) 'package:mod_session/src/device_info_web.dart';

class SessionModule {
  static get deviceID => DeviceInfo.label;

  static get deviceUserAgent => DeviceInfo.userAgent;
}
