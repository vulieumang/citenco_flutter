import 'dart:async';

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

  final GlobalKey _qrKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();
  final PermissionStatusNotifier _permissionStatus = PermissionStatusNotifier();
  final CountDownNotifier _countDown = CountDownNotifier(60);

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
    return [_permissionStatus, _countDown];
  }

  @override
  void dispose() {
    if (_permissionStatus.value == PermissionStatus.granted) {
      qrViewController?.dispose();
    }
    super.dispose();
  }

  //methods
  void startCountDown([int? initSeconds]) {
    Timer.periodic(Duration(seconds: 1), (_) {
      if (state.mounted) {
        _countDown.value = _countDown.value! - 1;
      }
    });
  }

  onOpenCamera(bool openCamera) async {
    openCamera
        ? await qrViewController?.resumeCamera()
        : await qrViewController?.pauseCamera();
  }

  List<BarcodeFormat> get formatsAllowed {
    List<BarcodeFormat> _formatsAllowed = [];
    switch (state.widget.qrFlutterScanType) {
      case QrFlutterScanType.QRCODE:
        _formatsAllowed = [
          BarcodeFormat.qrcode,
          BarcodeFormat.aztec,
          BarcodeFormat.dataMatrix,
          BarcodeFormat.maxicode,
          BarcodeFormat.pdf417
        ];
        break;
      case QrFlutterScanType.BARCODE:
        _formatsAllowed = [
          BarcodeFormat.codabar,
          BarcodeFormat.code39,
          BarcodeFormat.code93,
          BarcodeFormat.code128,
          BarcodeFormat.ean8,
          BarcodeFormat.ean13,
          BarcodeFormat.itf,
          BarcodeFormat.rss14,
          BarcodeFormat.rssExpanded,
          BarcodeFormat.upcA,
          BarcodeFormat.upcE,
          BarcodeFormat.upcEanExtension,
        ];
        break;
      default:
        _formatsAllowed = [];
        break;
    }

    return _formatsAllowed;
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

  onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scanInvert(true);
    qrViewController.scannedDataStream.listen((scanData) async {
      if (state.widget.scanData != null) {
        state.widget.scanData!(scanData);
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

class CountDownNotifier extends BaseNotifier<int> {
  CountDownNotifier(int value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CountDownNotifier>(create: (_) => this);
  }
}
