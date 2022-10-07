import 'dart:async';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/listenable_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cnvsoft/core/storage.dart';
import 'web_page.dart';

class FeedBackWebProivder extends BaseProvider<FeedBackWebebState> {
  FeedBackWebProivder(FeedBackWebebState state) : super(state) {
    // showLazyLoad();
  }
  final TitleNotifier _title = TitleNotifier("");
  final LoadTooltipsNotifier loadTooltips = LoadTooltipsNotifier(false);

  // String get url => BasePKG.of(state).http.isStaging
  //     ? 'https://games-staging.cnvloyalty.com/wheel/${BaseScope().idWheel}'
  //     : 'https://games.cnvloyalty.com/wheel/${BaseScope().idWheel}';
  
  String get url => state.widget.urlView.toString() + '?isMobile=true&color=' +
          BasePKG().color.primaryColor.value.toRadixString(16).substring(2);

  String get email => BasePKG().stringOf(() => MyProfile().email);

  String get name => BasePKG().stringOf(() => MyProfile().name);

  String get phone => BasePKG().stringOf(() => MyProfile().phone);

  String get customerId =>
      BasePKG().stringOf(() => MyProfile().customerId.toString());

  String get colorBg =>
      BasePKG().color.primaryColor.value.toRadixString(16).substring(2);

  String get colorText =>
      BasePKG().text!.appBarTitle().color!.value.toRadixString(16).substring(2);

  dynamic get header => BasePKG.of(state).http?.baseHeader;

  Color get colorPrimary => BasePKG().color.primaryColor;
  @override
  List<BaseNotifier> initNotifiers() {
    return [_title, loadTooltips];
  }

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  void backInWebView() {
    webViewController!.goBack();
  }

  checkWebHistory() {
    return webViewController!.canGoBack();
  }

  void onPageFinished(controller, url) {
    // hideLazyLoad();
    hideLoading();
  }

  onChangeTitle(InAppWebViewController? controller, String? data) async {
    _title.value = data;
  }

  scriptGetTitle(String title) {
    _title.value = title;
  }

  void onWebViewCreated(InAppWebViewController? controller) {
    if(StorageCNV().containsKey("CUSTOMER_ID_OLD")){
      if(StorageCNV().getString("CUSTOMER_ID") != StorageCNV().getString("CUSTOMER_ID_OLD")){
        controller!.clearCache();
      }
    }
    webViewController = controller;
  }

  void onPageStarted(controller, url) {
    showLoading();
  }

  void onShowToolTips() {
    bool? tips = loadTooltips.value;
    loadTooltips.value = !tips!;
  }

  void onTapToolTips() {
    onShowToolTips();
    webViewController!.reload();
  }
}

class TitleNotifier extends BaseNotifier<String> {
  TitleNotifier(value) : super(value);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<TitleNotifier>(create: (_) => this);
  }
}

class LoadTooltipsNotifier extends BaseNotifier<bool> {
  LoadTooltipsNotifier(value) : super(value);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<LoadTooltipsNotifier>(create: (_) => this);
  }
}
