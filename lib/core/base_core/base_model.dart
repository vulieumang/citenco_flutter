import 'dart:io';

import 'package:cnvsoft/core/base_core/data_mix.dart';

class BaseModel extends JsonModel {
  dynamic error;
  String? redirectLink;
  int? statusCode;

  bool get isSuccess => statusCode == HttpStatus.ok && error == null;

  @override
  Map<String, dynamic> toJson() => {};
}

class BaseDataModel<T> extends BaseModel {
  final T data;

  BaseDataModel(this.data);
}

abstract class JsonModel with DataMix {
  Map<String, dynamic> toJson();
}
