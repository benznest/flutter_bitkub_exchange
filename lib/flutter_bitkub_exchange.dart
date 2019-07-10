import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBitkubExchange {
  static const MethodChannel _channel =
      const MethodChannel('flutter_bitkub_exchange');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
