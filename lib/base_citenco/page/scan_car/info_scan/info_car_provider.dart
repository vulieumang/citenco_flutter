import 'package:cnvsoft/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/base_citenco/package/level_asset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_car_page.dart';

class InfoCarProvider extends BaseProvider<InfoCarPageState> {
  InfoCarProvider(InfoCarPageState state) : super(state);
  final OpenScanNotifier _openScan = OpenScanNotifier();
  final OnCheckNotifier _onCheckNotifier = OnCheckNotifier();

  @override
  List<BaseNotifier> initNotifiers() => [_openScan, _onCheckNotifier];

  @override
  Future<void> onReady(callback) async {
    if (state.widget.data == null) {
      MessageDialog.show(
        state,
        "Không có dữ liệu",
        "Thông báo",
      );
    }
  }

  submitSend() async {
    showLoading();
    var res =
        await BasePKG.of(state).scanVerify(id: state.widget.data!.vehicleId);
    if (res.data["code"] == 200) {
      Navigator.pushNamed(state.context, "verify_car_page");
    } else {
      MessageDialog.showErrors(
        state,
        res.data["description"] ?? "Quét mã xác nhận thất bại !",
        "Thông báo",
      );
    }
    hideLoading();
  }

  onChangCheck() async {
    _onCheckNotifier.value = !_onCheckNotifier.value!;
  }
}

class OpenScanNotifier extends BaseNotifier<bool> {
  OpenScanNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<OpenScanNotifier>(create: (_) => this);
  }
}

class OnCheckNotifier extends BaseNotifier<bool> {
  OnCheckNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<OnCheckNotifier>(create: (_) => this);
  }
}
