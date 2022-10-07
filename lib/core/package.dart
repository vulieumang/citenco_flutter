import 'dart:convert';
import 'dart:io';

import 'package:cnvsoft/core/bus.dart';
import 'package:cnvsoft/core/http.dart';
import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/core/multiasync.dart';
import 'package:cnvsoft/core/scope.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'base_core/data_mix.dart';

abstract class Context {
  Http? http;
  String tag = "";

  String get baseAPIInte => http!.isStaging
      ? 'https://integration-staging.cnvloyalty.com/loyalty-app/'
      : 'https://integration.cnvloyalty.com/loyalty-app/';

  // String get baseAPIEcom => http!.isStaging
  //     ? 'http://103.82.196.189:7093/mobile/'
  //     : 'http://103.82.196.189:5093/mobile/';

  // String get baseAPIPoint => http!.isStaging
  //     ? 'http://103.82.196.189:7014/mobile/'
  //     : 'http://103.82.196.189:5014/mobile/';

  String get baseAPIEcom => http!.isStaging
      ? 'https://ecom-staging.apis.cnv.vn/mobile/'
      : 'https://ecom.apis.cnv.vn/mobile/';

  String get baseAPIPoint => http!.isStaging
      ? 'https://loyalty-staging.apis.cnv.vn/mobile/'
      : 'https://loyalty.apis.cnv.vn/mobile/';

  String get baseAPIInternal => http!.isStaging
      ? 'https://internal-staging.cnvloyalty.com/'
      : 'https://internal.cnvloyalty.com/';

  String get baseAPILogin =>
      http!.isStaging ? 'https://id-staging.cnv.vn/' : 'https://id.cnv.vn/';
  String get baseAPISpa =>
      http!.isStaging ? 'https://id-staging.cnv.vn/' : 'https://id.cnv.vn/';

  String get baseAPIService => http!.isStaging
      ? 'https://app-staging.cnvcdp.com/service/'
      : 'https://app.cnvcdp.com/service/';

  String get baseAPIFBBuilder => http!.isStaging
      ? "https://facebook-builder-staging.apis.cnv.vn/mobile/"
      : "https://facebook-builder.apis.cnv.vn/mobile/";

  String get baseAPIWarranty => http!.isStaging
      ? "https://warranty-staging.cnvloyalty.com/"
      : "https://warranty.cnvloyalty.com/";

  String get baseAPITopup => http!.isStaging
      ? "https://internal-staging.cnvloyalty.com/topup/mobile/"
      : "https://internal.cnvloyalty.com/topup/mobile/";

  String get baseAPIBooking => http!.isStaging
      ? "https://booking-staging.apis.cnv.vn/mobile/"
      : "https://booking.apis.cnv.vn/mobile/";
  String get baseAPIReferrals => http!.isStaging
      ? "https://plugins.cnvloyalty.com/referrals-staging/service/mobile/"
      : "https://plugins.cnvloyalty.com/referrals/service/mobile/";

  String get baseAPIPaffiliates => http!.isStaging
      ? "https://plugins.cnvloyalty.com/affiliates-staging/service/mobile/"
      : "https://plugins.cnvloyalty.com/affiliates/service/mobile/";

  String get baseAPITreament => http!.isStaging
      ? "https://plugins.cnvloyalty.com/treatments/service/"
      : "https://plugins.cnvloyalty.com/treatments/service/";

  String get baseAPIRating => http!.isStaging
      ? "https://cx-staging.apis.cnv.vn/mobile/"
      : "https://cx.apis.cnv.vn/mobile/";

  String get baseAPITopupNew => http!.isStaging
      ? "https://internal-staging.cnvloyalty.com/topup/"
      : "https://internal.cnvloyalty.com/topup/";
  String get baseAPIFeedBackBill => http!.isStaging
      ? "https://cx-staging.apis.cnv.vn/"
      : "https://cx.apis.cnv.vn/";

  String get baseAPIAppBuilder => http!.isStaging
      ? "https://app-builder-staging.cnvloyalty.com/internal/"
      : "https://app-builder.cnvloyalty.com/internal/";
  // API Khóa Học .Net
  String get baseAPICourse => http!.isStaging
      ? 'https://courses-staging.cnvloyalty.com/'
      : 'https://courses.cnvloyalty.com/';
}

abstract class Package with DataMix {
  Bus? bus;

  Map<String, Function(dynamic arguments)> getPages();

  Widget? getByRouteSettings(RouteSettings settings) {
    if (getPages().containsKey(settings.name))
      return getPages()[settings.name]!(settings.arguments);
    else
      return null;
  }

  bool existRoute(String name) {
    return getPages().containsKey(name);
  }

  double convert(double value) => value;

  EdgeInsets only({double? top, double? left, double? bottom, double? right}) {
    return EdgeInsets.only(
        top: convert(top ?? 0),
        left: convert(left ?? 0),
        bottom: convert(bottom ?? 0),
        right: convert(right ?? 0));
  }

  EdgeInsets symmetric({double? vertical, double? horizontal}) {
    return EdgeInsets.symmetric(
        vertical: convert(vertical ?? 0.0),
        horizontal: convert(horizontal ?? 0.0));
  }

  EdgeInsets all(double value) {
    return EdgeInsets.all(convert(value));
  }

  EdgeInsets zero = EdgeInsets.zero;

  // dùng để khởi tạo các class của package đó
  // các package được add vào app sẽ không gọi được các class của package đó
  // hiện tại đang sử dụng để init giỏ hàng
  Future<void> serviceInit(State state) async {}

  // dùng để destory các class của package đó
  // các package được add vào app sẽ không gọi được các class của package đó
  // hiện tại đang sử dụng để destroy giỏ hàng
  Future<void> serviceDestroy(State state) async {}
}

class PageManager {
  final Map<String, Function(dynamic arguments)> pages;

  PageManager(this.pages);

  Widget? getByRouteSettings(RouteSettings settings) {
    if (pages.containsKey(settings.name))
      return pages[settings.name]!(settings.arguments);
    else
      return null;
  }
}

class PackageManager with DataMix {
  AppScope _scope = AppScope();
  Map<Type, Package> _packages = {};
  Widget? _defaultPage;

  int? _customerId;
  String? _sku;
  String? _deviceVersion;
  String? _deviceVersionCode;
  String _initialRoute = "landing";
  bool _hasLockApp = false;
  Function(State state, Map<String, dynamic> result)? onHandleVersion;
  Function(State state, Map<String, dynamic> result)? onDataScopeChanged;
  bool usedUnitCode = true; //Using for Vietsing PET/CT
  bool requiredLogout = false; // required log out if unauthenticated

  final Map<String, String> xSecret = {
    'X-Api-Secret': r'y$Lk/ozO1ZEI1vOVcWo8X/KO1uGWaebwufCcWgu.lrkcANF7mWqtf0O'
  };

  static PackageManager? _internal;

  factory PackageManager() => _internal!;

  PackageManager._();

  String get getSKU => _sku!;

  String get defaultSharing => StorageCNV().getString("APP_ACP_INVI")!;

  bool get hasLockApp => boolOf(() => _hasLockApp);

  String get deviceVersion => _deviceVersion!;

  String? get deviceVersionCode => _deviceVersionCode;

  // bool get unitCode => usedUnitCode;

  void setHasLockApp(bool value) => _hasLockApp = value;

  static void user(
      {required List<Package> packages,
      String? sku,
      required Widget defaultPage}) async {
    if (_internal == null) {
      _internal = PackageManager._();
      packages.forEach((p) => _internal!._packages[p.runtimeType] = p);
      _internal!._scope = AppScope();
      _internal!._defaultPage = defaultPage;
      _internal!._sku = sku;
    }
  }

  // Future httpInfo(State state, String code) => Http(state: state, factories: {})
  //     .get("mobile-applications/info?code=$code",
  //         baseAPI: "http://api.cnv.vn/v1/", headers: xSecret)
  //     .timeout(Duration(seconds: 6), onTimeout: () => null);

  Future _httpVersion(State state, String sku) async {
    String? scope = StorageCNV().getString("SCOPE");
    Map<String, dynamic>? result;
    try {
      if (scope != null) result = jsonDecode(scope);
    } catch (e) {
      Log().severe(e);
    }
    Function func = () async {
      return Http(state: state, factories: {})
          .get("mobile-applications/$sku/version",
              baseAPI: "http://api.cnv.vn/v1/", headers: xSecret)
          .timeout(Duration(seconds: 6), onTimeout: () => null);
    };

    Function saveScope = (json) async {
      try {
        String str = jsonEncode(json);
        Log().info(json);
        StorageCNV().setString("SCOPE", str);
      } catch (e) {
        Log().severe(e);
      }
    };

    if (result == null) {
      result = await func();
      _scope.set(state, result ?? {});
      await saveScope(result);
    } else {
      _scope.set(state, result);
      func().then((result) async {
        _scope.set(state, result);
        await saveScope(result);
      });
    }

    return result;
  }

  Future<void> _setScope(State state, dynamic result) async {
    if (result != null && result is Map) {
      if (boolOf(() => result["data"]["enable_xversion"])) {
        AppVersion().set(result["data"]);
      }
    }
  }

  // Future getInfoByCode(State state, String code) => httpInfo(state, code);
  //
  // Future<bool> setCodeScope(State state, String code) async {
  //   var result = await httpInfo(state, code);
  //   if (result == null) {
  //     MessageDialog.showErrors(state, "Không lấy được thông tin kết nối");
  //   } else {
  //     if (result["message"] == null) {
  //       await _setScope(state, result);
  //       return true;
  //     } else {
  //       MessageDialog.showErrors(state, result);
  //     }
  //   }
  //   return false;
  // }

  AppScope getScope() => _scope;

  dynamic get customerId => _customerId;

  String get initialRoute => _initialRoute;

  String? get _serverVersion => AppVersion().versionStr;

  Future<void> saveLoginInfo({
    required String? token,
    required String? loginToken,
  }) async {
    await MultiAsync().process({
      "TOKEN": () => StorageCNV().setString("TOKEN", token!.trim()),
      "LOGIN_TOKEN": () async {
        if (!MyProfile().isGuest)
          await StorageCNV().setString("LOGIN_TOKEN", loginToken!.trim());
      }
    });
  }

  Widget getByRouteSettings(RouteSettings settings) {
    for (var package in _packages.values) {
      var _page = package.getByRouteSettings(settings);
      if (_page != null) return _page;
    }
    return _defaultPage!;
  }

  Future<String> _getSKU() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var sku = stringOf(() => this._sku ?? packageInfo.packageName);
    this._sku = sku;
    print("My sku: $sku");
    return sku;
  }

  Future checkScopeInfo(State state,
      {required Function() onShowUpdate,
      required Function() onContinue}) async {
    int serverVersion = -1;
    int deviceVersion = -1;
    String _serverVersion = "";

    // var sku = (await _getSKU());

    var info = await PackageInfo.fromPlatform();
    this._deviceVersion = info.version;
    this._deviceVersionCode = info.buildNumber;
    // var result = await _httpVersion(state, BasePKG().sku ?? sku);

    AppVersion().load(state);
    // _setScope(state, result);ß

    // check version store
    _serverVersion = stringOf(() =>
        Platform.isIOS ? AppVersion().iosVersion : AppVersion().androidVersion);

    serverVersion = parseVerion(_serverVersion);
    deviceVersion = parseVerion(_deviceVersion ?? "");

    print("Server version: $serverVersion");
    print("Device version: $deviceVersion");

    // onShowUpdate();

    // var kDebugMode = false;
    if (deviceVersion == -1 || serverVersion == -1 || kDebugMode) {
      print("onContinue");
      onContinue();
    } else {
      if (serverVersion > deviceVersion) {
        onShowUpdate();
      } else {
        onContinue();
      }
    }
  }

//return true if app version same server version
  bool onlyInLiveVersion(State state, [bool force = false]) {
    try {
      bool _isDebug = kDebugMode;
      if (!_isDebug) {
        int _serverVersion = parseVerion(this._serverVersion ?? "");
        int _deviceVersion = parseVerion(this._deviceVersion!);
        bool _allow = _serverVersion != -1 &&
            _deviceVersion != -1 &&
            _serverVersion == _deviceVersion;
        return _allow;
      } else
        return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  bool onlyInReviewVersion(State state) {
    try {
      bool _isDebug = kDebugMode;
      if (!_isDebug) {
        int _serverVersion = parseVerion(this._serverVersion ?? "");
        int _deviceVersion = parseVerion(this._deviceVersion!);
        print("==========version====by=======sku: $_sku");
        print("=======serverVersion=========>$_serverVersion");
        print("=======deviceVersion=========>$_deviceVersion");
        bool _allow = _serverVersion == -1 || _serverVersion < _deviceVersion;
        return _allow;
      } else
        return false;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  int parseVerion(String source) {
    try {
      return int.parse(source.replaceAll(".", ""));
    } catch (e) {
      return -1;
    }
  }

  getPackage<T extends Package>() => _packages[T];

  Bus? getBus<T extends Package>() => _packages[T]?.bus;

  bool existRoute(String name) {
    return _packages.values.any((package) => package.existRoute(name));
  }

  Future serviceInit(State state) {
    Map<String, AsyncFunction> funcs = {};
    _packages.values.forEach((element) {
      funcs["init service ${funcs.length}"] = () => element.serviceInit(state);
    });
    return MultiAsync().process(funcs);
  }

  Future serviceDestory(State state) {
    Map<String, AsyncFunction> funcs = {};
    _packages.values.forEach((element) {
      funcs["destroy service ${funcs.length}"] =
          () => element.serviceDestroy(state);
    });
    return MultiAsync().process(funcs);
  }
}
