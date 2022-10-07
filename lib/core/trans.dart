import 'package:cnvsoft/special/base_citenco/package/translation.dart';

class CoreTrans extends BaseTranslation {
  static CoreTrans? _internal;
  CoreTrans._();

  factory CoreTrans() {
    if (_internal == null) _internal = CoreTrans._();
    return _internal!;
  }

  @override
  String get key => "core";
}
