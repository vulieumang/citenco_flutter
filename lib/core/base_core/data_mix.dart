import 'base_model.dart';

mixin DataMix {
  T? dataOf<T>(T? Function() getValue, [T? defaultValue, List<T>? exception]) {
    try {
      T? result = getValue() ?? defaultValue;
      return ((exception ?? []).contains(result)) ? defaultValue : result;
    } catch (e) {
      // log.shout(e.toString());
      return defaultValue == null ? null : defaultValue;
    }
  }

  String stringOf(String? Function() getValue,
      [String defaultValue = "", List<String>? exception]) {
    return dataOf<String>(getValue, defaultValue, exception) ?? defaultValue;
  }

  int intOf(int? Function() getValue,
      [int defaultValue = 0, List<int>? exception]) {
    int? _result = dataOf<int>(getValue, defaultValue, exception);
    return (_result != null && _result.isFinite) ? _result : defaultValue;
  }

  double doubleOf(double? Function() getValue,
      [double defaultValue = 0.0, List<double>? exception]) {
    double? _result = dataOf<double>(getValue, defaultValue, exception);
    return (_result != null && _result.isFinite) ? _result : defaultValue;
  }

  bool boolOf(bool? Function() getValue, [bool defaultValue = false]) {
    return dataOf<bool>(getValue, defaultValue) ?? defaultValue;
  }

  Map<String, dynamic> jsonOf(JsonModel source) {
    return dataOf<Map<String, dynamic>>(() => source.toJson(), null) ?? {};
  }

  DateTime? dateTimeOf(dynamic source, [DateTime? defaultValue]) {
    var value =
        dataOf<DateTime>(() => DateTime.parse(source).toLocal(), defaultValue);
    return value;
  }

  List<T> listOf<T>(List<T>? Function() getValue, [List<T>? defaultValue]) {
    return dataOf<List<T>>(getValue, defaultValue) ?? [];
  }

  List<T> listFrom<T>(dynamic data, List<T> defaultValue) {
    return listOf<T>(() => List<T>.from(data.map((x) => x)), defaultValue);
  }

  List<dynamic> listJson(List<JsonModel> data, List<String> defaultValue) {
    return listOf<dynamic>(
        () => List<dynamic>.from(data.map((x) => x.toJson())), defaultValue);
  }

  String isoOf(DateTime source) {
    return dataOf(() => stringOf(() => source.toIso8601String()), null, [""]) ??
        "";
  }
}
