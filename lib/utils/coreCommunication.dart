import 'dart:io';

import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/deviceModel.dart';

class Core {
  static Future<DeviceInfo> getDeviceDetails() async {
    String? deviceName;
    String? deviceVersion;
    String? identifier;
    String? source;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;

        deviceVersion = build.version.release;
        identifier = build.id; //UUID for Android
        source = "android";
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
        source = "ios";
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return DeviceInfo(
        deviceName: deviceName,
        deviceVersion: deviceVersion,
        identifier: identifier,
        source: source,
        appName: appName,
        packageName: packageName,
        buildNumber: buildNumber,
        version: version);
  }
}
