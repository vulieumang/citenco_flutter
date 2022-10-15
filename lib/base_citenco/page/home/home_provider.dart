import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/base_citenco/dialog/update_version_dialog/update_version_dialog.dart';
import 'package:cnvsoft/base_citenco/page/home/home_icon.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends BaseProvider with DataMix {
  final ScrollController scrollCtrl = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  final WidgetContentNotifier _widgetContent = WidgetContentNotifier();

  HomeProvider(State state) : super(state) {}

  @override
  BusProvider<DashboardChangeHome> initBus() =>
      BusProvider<DashboardChangeHome>.fromPackage(
          package: BasePKG(), listeners: {});

  void navigate(int value) {
    controllerPage!.jumpToPage(value);
  }

  final GridIconsNotifier _gridIcons = GridIconsNotifier();

  PageController? controllerPage = PageController();

  List<HomeIcon> initGridIconList() => [];

  @override
  void onReady(callback) async {
    super.onReady(callback);
    // showLazyLoad();
    onInitPage();
    hideLazyLoad(second: 1000);
    // _checkVersion();
  }

  logout() {
    StorageCNV().clearSession();
    Navigator.pushNamedAndRemoveUntil(context!, "login_page", (route) => false);
  }

  _checkVersion() {
    PackageManager().checkScopeInfo(state, onShowUpdate: () async {
      await UpdateVersionDialog.show(state);
    }, onContinue: () async {});
  }

  @override
  List<BaseNotifier> initNotifiers() => [_widgetContent, _gridIcons];

  Future<void> onInitPage() async {}

  void showDrawer() {
    openEndDrawer();
  }

  Future<void> onRefresh() async {
    // mixProfile(state);
    showLazyLoad();
    _loadPreferences();
    hideLazyLoad(second: 1000);
  }

  Future<void> _loadPreferences() async {}
}

class WidgetContentNotifier extends BaseNotifier<List> {
  WidgetContentNotifier() : super([]);

  @override
  ListenableProvider provider() =>
      ChangeNotifierProvider<WidgetContentNotifier>(create: (_) => this);
}

class GridIconsNotifier extends BaseNotifier<List<HomeIcon>> {
  GridIconsNotifier() : super([]);

  @override
  ListenableProvider provider() =>
      ChangeNotifierProvider<GridIconsNotifier>(create: (_) => this);
}
