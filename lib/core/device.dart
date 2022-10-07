import 'dart:io';

import 'package:cnvsoft/core/storage.dart';
import 'package:device_info/device_info.dart';
import 'package:uuid/uuid.dart';

import 'base_core/data_mix.dart';

class Device with DataMix {
  static Device? _internal;
  final String _key = "DEVICE_ID";

  Device._();

  factory Device() {
    if (_internal == null) _internal = Device._();
    return _internal!;
  }

  String? get deviceId => StorageCNV().getString(_key);

  Future<String> getDeviceId() async {
    if (StorageCNV().containsKey(_key)) {
      return StorageCNV().getString(_key)!;
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String _deviceId = "";
      if (Platform.isIOS) {
        var _iOSInfo =
            await deviceInfo.iosInfo.timeout(Duration(milliseconds: 1000));
        _deviceId = stringOf(() => _iOSInfo.identifierForVendor);
      } else {
        var _androidInfo =
            await deviceInfo.androidInfo.timeout(Duration(milliseconds: 1000));
        _deviceId = stringOf(() => _androidInfo.androidId);
      }

      if (_deviceId.isEmpty) {
        _deviceId = Uuid().v4();
      } else {
        StorageCNV().setString(_key, _deviceId);
      }
      return _deviceId;
    }
  }
}
