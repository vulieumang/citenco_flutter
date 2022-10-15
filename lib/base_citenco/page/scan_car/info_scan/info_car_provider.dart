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

  @override
  List<BaseNotifier> initNotifiers() => [_openScan];

  @override
  Future<void> onReady(callback) async {}

  scanData(id) async {}
}

class OpenScanNotifier extends BaseNotifier<bool> {
  OpenScanNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<OpenScanNotifier>(create: (_) => this);
  }
}
