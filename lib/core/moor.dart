import 'dart:async';
import 'dart:convert';

import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/storage.dart';

class Moor with DataMix {
  static Moor? _internal;
  final String _key = "MOORS";
  Timer? _debounceMap;
  Map<String, String> _stack = {};

  Moor._();

  List<String> exceptions = [
    "otp",
    "v1/customers/devices/verify",
    "v1/analytics",
    "v1/registration-fcm-token",
    "v1/mini-games",
    "v1/lucky-boxes",
    "v1/lucky-phone-sessions",
  ];

  factory Moor() {
    if (_internal == null) {
      _internal = Moor._();
    }
    return _internal!;
  }

  Future save(String key, String value) {
    if (!exceptions.any((t) => key.startsWith(t))) _stack[key] = value;
    Completer<bool> _completer = Completer();

    if (_debounceMap?.isActive ?? false) _debounceMap?.cancel();
    _debounceMap = Timer(const Duration(milliseconds: 5000), () async {
      Map<String, dynamic>? _moor =
          dataOf(() => jsonDecode(StorageCNV().getString(_key) ?? "{}"), {});
      _stack.forEach((key, value) => _moor?[key] = value);
      print("");
      _stack = {};
      _completer.complete(await StorageCNV().setString(_key, jsonEncode(_moor)));
    });
    return _completer.future;
  }

  String load(String key) {
    Map<String, dynamic>? _moor =
        dataOf(() => jsonDecode(StorageCNV().getString(_key) ?? "{}"), {});
    return _moor?[key];
  }
}
