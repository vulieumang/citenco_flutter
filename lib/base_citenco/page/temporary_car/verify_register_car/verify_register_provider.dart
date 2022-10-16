import 'dart:async';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verify_register_page.dart';

class VerifyCarRegisterProvider
    extends BaseProvider<VerifyCarRegisterPageState> {
  VerifyCarRegisterProvider(VerifyCarRegisterPageState state) : super(state);

  final CountDownNotifier _countDown = CountDownNotifier(3);

  @override
  Future<void> onReady(callback) async {
    super.onReady(callback);
    startCountDown();
  }

  @override
  List<BaseNotifier> initNotifiers() {
    return [_countDown];
  }

  @override
  void dispose() {
    super.dispose();
  }

  toDashBoard() {
    Navigator.pushNamedAndRemoveUntil(
        state.context, "dash_board", (route) => false);
  }

  //methods
  void startCountDown([int? initSeconds]) {
    Timer.periodic(Duration(milliseconds: 3000), (_) {
      if (state.mounted) {
        _countDown.value = _countDown.value! - 1;
        if (_countDown.value == 0) {
          Navigator.pushNamedAndRemoveUntil(
              state.context, "dash_board", (route) => false);
        }
      }
    });
  }
}

class CountDownNotifier extends BaseNotifier<int> {
  CountDownNotifier(int value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CountDownNotifier>(create: (_) => this);
  }
}
