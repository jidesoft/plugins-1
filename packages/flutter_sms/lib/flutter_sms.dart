import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterSms {
  static const MethodChannel _channel = const MethodChannel('flutter_sms');

  static Future<String> sendSMS({
    @required String message,
    @required List<String> recipients,
  }) async {
    var mapData = Map<dynamic, dynamic>();
    mapData["message"] = message;
    if (Platform.isIOS) {
      mapData["recipients"] = recipients;
      final String result = await _channel.invokeMethod('sendSMS', mapData);
      return result;
    } else {
      String _phones = "";
      for (var p in recipients) {
        _phones += p + ",";
      }
      _phones = _phones.substring(0, _phones.length - 1);
      mapData["recipients"] = _phones;
      final String result = await _channel.invokeMethod('sendSMS', mapData);
      return result;
    }
  }
}
