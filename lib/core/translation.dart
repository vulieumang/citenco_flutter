import 'dart:async';
import 'dart:convert';

import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/core/multiasync.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/translation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class Translations with DataMix {
  static Translations? _internal;

  Translations._();

  factory Translations() {
    if (_internal == null) _internal = Translations._();
    return _internal!;
  }

  Future<void> initialize(List<BaseTranslation> translations) async {
    // return _initialize(translations);
    String? _trans = StorageCNV().getString("TRANSLATION");
    String? _transVersion = StorageCNV().getString("TRANSLATION_VERSION");
    if (_transVersion != null &&
        _trans != null &&
        boolOf(() => BaseContext().http?.isProduction)) {
      var info = await PackageInfo.fromPlatform();
      // var currentVersion = info.version;
      var currentVersion = "${info.version}_${info.buildNumber}";
      if (_transVersion != currentVersion || kDebugMode) {
        return _initialize(translations);
      } else {
        Map<String, dynamic>? data;
        try {
          data = jsonDecode(_trans);
        } catch (e) {
          Log().severe(e);
        }
        if (data != null) {
          try {
            translations.forEach((trans) {
              Translations().supports.forEach((lang) {
                var value = data!["${trans.key}:${lang.languageCode}"];
                trans.setDictionary(
                    lang.languageCode, (value as Map<String, dynamic>));
              });
            });
          } catch (e) {
            Log().severe(e);
            return _initialize(translations);
          }
        } else {
          return _initialize(translations);
        }
      }
    } else {
      return _initialize(translations);
    }
  }

  Future<void> _initialize(List<BaseTranslation> translations) async {
    Map<String, AsyncFunction> tasks = {};
    Map<String, dynamic> result = {};
    Map<String, dynamic> local = {};
    var func = (package, language, path) async {
      print(path);
      var value;
      try {
        var data = await rootBundle.loadString(path);
        value = dataOf(() => jsonDecode(data));
      } catch (e) {
        value = {};
        Log().severe(e);
      }
      result["$package:$language"] = value as Map<String, dynamic>;
      local["$package:$language"] = value;
    };

    translations.forEach((trans) {
      Translations().supports.forEach((lang) {
        String key = trans.key;
        String language = lang.languageCode;
        String file = "$language.json";
        String path = "lib/special/$key/asset/language/$file";
        tasks["$key:$language"] = () => func(key, language, path);
      });
    });

    await MultiAsync().process(tasks);

    translations.forEach((trans) {
      Translations().supports.forEach((lang) {
        String key = trans.key;
        String language = lang.languageCode;
        trans.setDictionary(language, result["$key:$language"]);
      });
    });

    var info = await PackageInfo.fromPlatform();
    // var currentVersion = info.version;
    var currentVersion = "${info.version}_${info.buildNumber}";
    await MultiAsync().process({
      "TRANSLATION": () =>
          StorageCNV().setString("TRANSLATION", jsonEncode(local)),
      "TRANSLATION_VERSION": () =>
          StorageCNV().setString("TRANSLATION_VERSION", currentVersion)
    });
  }

  List<Locale> supports = [];
  Locale? locale;

  String translate(Map? source) {
    if (source == null || source[locale?.languageCode] == null) {
      return "";
    } else {
      return source[locale?.languageCode];
    }
  }
}
