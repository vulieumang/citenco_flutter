import 'dart:convert';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error_list_page.dart';

class ErrorListProvider extends BaseProvider<ErrorListPageState> {
  final ErrorsNotifier _errors = ErrorsNotifier();

  ErrorListProvider(ErrorListPageState state) : super(state);

  @override
  void onReady(callback) {
    super.onReady(callback);
    _loadErrors();
  }

  @override
  List<BaseNotifier> initNotifiers() => [_errors];

  Future<void> _loadErrors() async {
    loading(() async {
      var result = StorageCNV().getString("ERRORS");
      if (result != null && state.mounted) {
        _errors.value = result.split(" - ");
        _errors.value = _errors.value! + [];
      }
    });
  }

  void onShowErrorDetail(String error) {
    Map<String, dynamic> _error = json.decode(error);
    Navigator.of(context!).pushNamed("error", arguments: {"error": _error});
  }

  Future<void> onRemoveItem(int index) async {
    var errors = StorageCNV().getString("ERRORS");
    if (errors != null) {
      var _items = errors.split(" - ");
      _items.removeAt(index);
      if (_items.isEmpty) {
        StorageCNV().remove("ERRORS");
        _errors.value?.clear();
        _errors.value = BasePKG().listOf(() => _errors.value) + [];
      } else {
        var _value = _items.join(" - ");
        StorageCNV().setString("ERRORS", _value);
        _loadErrors();
      }
    }
  }

  String getContent(String content) {
    Map<String, dynamic> _err = jsonDecode(content);
    List<String> _errors = [];
    _err.forEach((k, v) {
      _errors.add("- $k: $v");
    });
    return _errors.join("\n");
  }
}

class ErrorsNotifier extends BaseNotifier<List<String>> {
  ErrorsNotifier() : super([]);

  @override
  ListenableProvider provider() =>
      ChangeNotifierProvider<ErrorsNotifier>(create: (_) => this);
}
