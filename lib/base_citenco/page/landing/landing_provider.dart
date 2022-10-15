import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/base_citenco/package/level_asset.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';

class LandingProvider extends BaseProvider<LandingPageState> {
  LandingProvider(LandingPageState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() => [];

  @override
  Future<void> onReady(callback) async {
    LevelAsset().initialize();
    Future.delayed(Duration(seconds: 1), () {
      loginBySaved();
    });
  }

  String get splashImage => "lib/basecitenco/modify/asset/image/splash.jpg";

  void loginBySaved() async {
    String? _auth = StorageCNV().containsKey("AUTH_TOKEN")
        ? StorageCNV().getString("AUTH_TOKEN")
        : "";

    if (_auth!.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
          context!, "dash_board", (route) => false);
    } else {
      await Navigator.pushNamed(context!, "login_page");
    }
  }
}
