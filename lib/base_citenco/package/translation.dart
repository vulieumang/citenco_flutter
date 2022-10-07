import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/core/translation.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';

class BaseTranslation {
  Map<String, Map<String, dynamic>> _dictionaries = {};
  String key = "base";

  BaseTranslation();

  factory BaseTranslation.init(Map<String, Map<String, dynamic>> data) {
    return BaseTranslation().._dictionaries = data;
  }

  setDictionary(String key, Map<String, dynamic> data) =>
      _dictionaries[key] = data;

  set(String locale, String key, String value) =>
      BasePKG().dataOf(() => _dictionaries[locale]![key] = value);

  String get(String key, [List<String>? args]) {
    String language =  BasePKG().stringOf(() => Translations().locale!.languageCode);
    if (language.isNotEmpty) {
      if (_dictionaries.containsKey(language)) {
        var value = _dictionaries[language]![key];
        if (value != null && value is String) {
          if (value.contains("{}")) {
            List<String> arr = value.split("{}");
            String text = "";
            for (int i = 0; i < arr.length - 1; i++) {
              String subValue = BasePKG().stringOf(() => args?[i]);
              text += arr[i] + subValue;
            }
            text += arr.last;
            return text;
          } else {
            return value;
          }
        } else {
          Log().shout("not found language key $key");
          return key;
        }
      }
    }
    return "";
  }
}
