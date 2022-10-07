import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agree_dialog_view.dart';

class AgreeDialogProvider extends BaseProvider<AgreeDialogState> {
  AgreeDialogProvider(AgreeDialogState state) : super(state);

  final EnableConfirmNotifier _enableConfirm = EnableConfirmNotifier(false);

  @override
  List<BaseNotifier> initNotifiers() {
    return [_enableConfirm];
  }

  void onCheckPressed() {
    _enableConfirm.value = !_enableConfirm.value!;
  }
}

class EnableConfirmNotifier extends BaseNotifier<bool> {
  EnableConfirmNotifier(bool value) : super(value);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<EnableConfirmNotifier>(create: (_) => this);
  }
}
