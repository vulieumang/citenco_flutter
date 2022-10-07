import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:simple_logger/simple_logger.dart';

class Log {
  static Log? _internal;
  SimpleLogger _log = SimpleLogger();

  Log._();

  factory Log() {
    if (_internal == null) {
      _internal = Log._();
      _internal!._log.setLevel(kDebugMode ? Level.ALL : Level.OFF,
          // _internal!._log.setLevel(Level.ALL,
          includeCallerInfo: true);
      _internal!._log.formatter = (info) {
        return '${_internal!._log.levelPrefixes[info.level]}'
            '${info.time}'
            '[${info.callerFrame ?? 'caller info not available'}] '
            '${info.message}';
      };
    }
    return _internal!;
  }

  /// Key for highly detailed tracing ([value] = 300).
  void finest(message) => _log.finest(message ?? "");

  /// Key for fairly detailed tracing ([value] = 400).
  void finer(message) => _log.finer(message ?? "");

  /// Key for tracing information ([value] = 500).
  void fine(message) => _log.fine(message ?? "");

  /// Key for static configuration messages ([value] = 700).
  void config(message) => _log.config(message ?? "");

  /// Key for informational messages ([value] = 800).
  void info(message) => _log.info(message ?? "");

  /// Key for potential problems ([value] = 900).
  void warning(message) => _log.warning(message ?? "");

  /// Key for serious failures ([value] = 1000).
  void severe(message) => _log.severe(message ?? "");

  /// Key for extra debugging loudness ([value] = 1200).
  void shout(message) => _log.shout(message ?? "");

  void bot(State state,
      {required String? content,
      required String? title,
      required Map<String, dynamic>? data,
      required bool? isError}) {
    var botId = BasePKG().stringOf(() => BaseScope().botChannelId);
    var phoneNumber = BasePKG().stringOf(() => MyProfile().phone);
    var allow =
        BasePKG().boolOf(() => BaseScope().phoneBotLog.contains(phoneNumber));

    data = {
      "User name": StorageCNV().containsKey("PROFILE_NAME")
          ? StorageCNV().getString("PROFILE_NAME")
          : "Cnv bug ngoài login",
      "User phone": StorageCNV().containsKey("PHONE_NUMBER")
          ? StorageCNV().getString("PHONE_NUMBER")
          : "Cnv bug ngoài login",
      "Bug call API": data
    };
    if (!kDebugMode) {
      String time = Utils.dateToString(
          source: DateTime.now().toLocal(),
          toPattern: Utils.DEFAULT_TIME_DATE_PATTERN);
      try { 
      } catch (e) {}
    }
  }
}
