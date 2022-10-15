import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/page/blank/blank_page.dart';
import 'package:flutter/material.dart';

import 'core/http.dart';
import 'core/package.dart';
import 'core/translation.dart';
import 'base_citenco/package/trans.dart';

class Config {
  static String title = "Shop ";

  //config
  static void initial() {
    PackageManager.user(
      sku: "vn",
      defaultPage: BlankPage(),
      packages: <Package>[
        ModifyPKG(),
        BasePKG(),
      ],
    );
  }

  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static Future<void> intialAsset() async {
    await Translations().initialize([BaseTrans()]);
  }

  static void config() {
    BasePKG().env = ENV(
        env: "production", accountDomainName: "http://citencoapi.vuweb.vn/");
  }
}
