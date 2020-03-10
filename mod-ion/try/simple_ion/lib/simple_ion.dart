import 'dart:async';

import 'package:flutter/services.dart';

class SimpleIon {
  static const MethodChannel _channel =
      const MethodChannel('simple_ion');

  static Future<String> get start async {
    final String version = await _channel.invokeMethod('start');
    return version;
  }
}
