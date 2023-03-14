import 'package:cnvsoft/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
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
  ChangeNameNotifier _changeNameNotifier = ChangeNameNotifier();
  RefreshNameNotifier _refreshNameNotifier = RefreshNameNotifier();
  ChangeShowVerifyVehicleNotifier _changeShowVerifyVehicleNotifier =
      ChangeShowVerifyVehicleNotifier();
  @override
  List<BaseNotifier> initNotifiers() => [
        _openScan,
        _onCheckNotifier,
        _changeNameNotifier,
        _refreshNameNotifier,
        _changeShowVerifyVehicleNotifier
      ];

  TextEditingController nameController = TextEditingController();
  String nameVehicle = "";

  @override
  Future<void> onReady(callback) async {
    if (state.widget.data == null) {
      MessageDialog.show(
        state,
        "Không có dữ liệu",
        "Thông báo",
      );
    }
    _changeShowVerifyVehicleNotifier.value =
        state.widget.data!.pendingHistoryId == null ? true : false;
    nameVehicle = state.widget.data!.vehicleDriverName!;
    nameController.text = state.widget.data!.vehicleDriverName!;
  }

  submitSend() async {
    showLoading();
    var res = await BasePKG.of(state).scanVerify(
        id: state.widget.data!.vehicleId,
        name: BasePKG().stringOf(() => state.widget.data?.vehicleDriverName));
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

  checkOldname() {
    if (nameController.text != nameVehicle) {
      _changeNameNotifier.value = false;
      _refreshNameNotifier.value = false;
    } else {
      _changeNameNotifier.value = true;
    }
  }

  refreshName() {
    state.widget.data!.vehicleDriverName = nameVehicle;
    nameController.text = state.widget.data!.vehicleDriverName!;
    _refreshNameNotifier.value = true;
    _changeNameNotifier.value = true;
  }

  changeShowVerifyVehicle() {
    _changeShowVerifyVehicleNotifier.value =
        !_changeShowVerifyVehicleNotifier.value!;
  }

  submitOut() async {
    showLoading();
    var res = await BasePKG.of(state)
        .putOut(historyId: state.widget.data!.pendingHistoryId!);

    if (res.data["code"] == 200) {
      Navigator.pushNamed(state.context, "verify_car_page",
          arguments: {"isOut": true});
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

class ChangeNameNotifier extends BaseNotifier<bool> {
  ChangeNameNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<ChangeNameNotifier>(create: (_) => this);
  }
}

class RefreshNameNotifier extends BaseNotifier<bool> {
  RefreshNameNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<RefreshNameNotifier>(create: (_) => this);
  }
}

class ChangeShowVerifyVehicleNotifier extends BaseNotifier<bool> {
  ChangeShowVerifyVehicleNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<ChangeShowVerifyVehicleNotifier>(
        create: (_) => this);
  }
}

class OnCheckNotifier extends BaseNotifier<bool> {
  OnCheckNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<OnCheckNotifier>(create: (_) => this);
  }
}
