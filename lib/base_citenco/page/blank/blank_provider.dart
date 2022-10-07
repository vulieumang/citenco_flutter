import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlankProvider extends BaseProvider {
  final CountNotifier _count = CountNotifier(0);

  BlankProvider(State state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() => [_count];

  //methods
  void count() {
    loading(() async {
      await Future.delayed(Duration(seconds: 2));
      _count.value = _count.value! + 1;
    });
  }
}

class CountNotifier extends BaseNotifier<int> {
  CountNotifier(int value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CountNotifier>(create: (_) => this);
  }
}
