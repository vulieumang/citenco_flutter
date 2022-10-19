import 'dart:async';

import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/qr_flutter/qr_flutter_page.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef BarcodeValueCallback(Barcode scanData);

class QrFlutterProvider extends BaseProvider<QrFlutterPageState> {
  QrFlutterProvider(QrFlutterPageState state) : super(state);

  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  final GlobalKey _containerKey = GlobalKey();
  final PermissionStatusNotifier _permissionStatus = PermissionStatusNotifier();
  final CountDownNotifier _countDown = CountDownNotifier(60);
  final ShowLightNotifier _showLightNotifier = ShowLightNotifier();

  TextEditingController idController = TextEditingController();

  QRViewController? qrViewController;
  bool isOpenedSettings = false;

  GlobalKey get qrKey => _qrKey;
  GlobalKey get containerKey => _containerKey;
  bool get allowCamera => _permissionStatus.value == PermissionStatus.granted;

  @override
  Future<void> onReady(callback) async {
    super.onReady(callback);
    await refreshCameraPermission();
    if (!allowCamera) showPermissionRequest(false);
    startCountDown();
  }

  @override
  List<BaseNotifier> initNotifiers() {
    return [_permissionStatus, _countDown, _showLightNotifier];
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    idController.dispose();
    super.dispose();
  }

  //methods
  void startCountDown([int? initSeconds]) {
    Timer.periodic(Duration(seconds: 1), (_) {
      if (state.mounted) {
        if (_countDown.value == 0) Navigator.of(state.context);
        if (_countDown.value != 0) _countDown.value = _countDown.value! - 1;
      }
    });
  }

  onOpenCamera(bool openCamera) async {
    openCamera
        ? await qrViewController?.resumeCamera()
        : await qrViewController?.pauseCamera();
  }

  Future<void> postRequestCamera() async {
    var _cameraPermission = await Permission.camera.request();
    _permissionStatus.value = _cameraPermission;
  }

  Future<void> refreshCameraPermission() async {
    _permissionStatus.value = await Permission.camera.request();
  }

  Future<void> showPermissionRequest([bool allowOpenSettings = true]) async {
    final DateTime _dateTime = DateTime.now();
    if (state.mounted) {
      await Permission.camera.request();
      final DateTime _after = DateTime.now();
      if (_after.difference(_dateTime).inMilliseconds > 100)
        await postRequestCamera();
      else {
        if (allowOpenSettings) {
          isOpenedSettings = true;
          openAppSettings();
        }
      }
    }
  }

  onShowLight() {
    _showLightNotifier.value = !_showLightNotifier.value!;
    qrViewController!.toggleFlash();
  }

  onScanQR() async {
    showLoading();
    super.hideKeyboard();
    qrViewController!.pauseCamera();
    var res;
    if (idController.text.isNotEmpty) {
      res = await BasePKG.of(state).scan(id: idController.text);
    }

    if (res != null) if (res.data.code == 200) {
      await Navigator.of(state.context).pushNamed("info_car_page",
          arguments: {"data": res.data.data}).then((value) {
        qrViewController!.resumeCamera();
        _countDown.value = 60;
      });
    } else {
      qrViewController!.resumeCamera();
      _countDown.value = 60;
    }
    qrViewController!.resumeCamera();
    hideLoading();
  }

  onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scanInvert(true);
    qrViewController.scannedDataStream.listen((scanData) async {
      if (scanData.code != "") {
        showLoading();
        var res;
        qrViewController.pauseCamera();
        res = await BasePKG.of(state).scan(id: scanData.code);
        if (res.data.code == 200) {
          await Navigator.of(state.context).pushNamed("info_car_page",
              arguments: {"data": res.data.data}).then((value) {
            qrViewController.resumeCamera();
            _countDown.value = 60;
          });
        } else {
          qrViewController.resumeCamera();
          _countDown.value = 60;
        }
        hideLoading();
      }
    });
  }
}

class PermissionStatusNotifier extends BaseNotifier<PermissionStatus> {
  PermissionStatusNotifier() : super(PermissionStatus.denied);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<PermissionStatusNotifier>(
        create: (_) => this);
  }
}

class ShowLightNotifier extends BaseNotifier<bool> {
  ShowLightNotifier() : super(false);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<ShowLightNotifier>(create: (_) => this);
  }
}

class CountDownNotifier extends BaseNotifier<int> {
  CountDownNotifier(int value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CountDownNotifier>(create: (_) => this);
  }
}
