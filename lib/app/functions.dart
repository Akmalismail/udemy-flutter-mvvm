import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
    }

    if (Platform.isIOS) {
      // return ios device info
    }
  } on PlatformException {
    // return default here
  }

  return DeviceInfo(name, identifier, version);
}
