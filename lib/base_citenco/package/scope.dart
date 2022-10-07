
import 'dart:io';
import 'dart:math';

import 'package:cnvsoft/core/http.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/scope.dart';
import 'package:cnvsoft/core/translation.dart';
import 'package:cnvsoft/base_citenco/extend/dashboard_extend/bottom_menu_icon.dart';
import 'package:cnvsoft/base_citenco/page/home/home_icon.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:flutter/material.dart';

import 'level_asset.dart';
import 'package.dart';

class BaseScope extends BaseLoyaltyScope<BaseScope> {
  int version = 1;
  String mode = "live";  
  bool allowLocal = true;
  bool clearStuffSession = false;
  bool clearStorage = false; 
  bool affiliate = false;  
  int clientAppHeader = BasePKG().clientAppHeader;
  Map<String, String> testNumber = {
    "0987654321": "111111",
    "0987654322": "111111",
    "0987654323": "111111",
    "0987654324": "111111",
    "0987654325": "111111",
    "0987654326": "111111",
    "0987654327": "111111",
    "0987654328": "111111",
    "0987654329": "111111"
  };
  ENV? env = BasePKG().env;
  String? botChannelId; // nếu scope không có channel thì không log
  List<String> phoneBotLog =
      []; // nếu scope không chứa ${BaseTrans().$phonenumber} thì không log 
  BoxFit landingBoxFit = BasePKG().landingBoxFit;
  bool enableInputTopupValue = false; 

  MemberCardStyle memberCardStyle = BasePKG().memberCardStyle;

  bool get isEcom => clientAppHeader == BasePKG.ECOM_APP;

  static BaseScope? _i;

  BaseScope._();

  factory BaseScope() {
    if (_i == null) _i = BaseScope._();
    return _i!;
  }

  @override
  void set(State state, Map<String, dynamic> json) {
    _i = BaseScope._();
    // _i!.testNumber = getMapValue<String, String>(
    //     json, ["test_phone_list", "number_test"], _i!.testNumber);
    _i!.version = intOf(() => json["version"], _i!.version);
    _i!.mode = stringOf(() => json["mode"], _i!.mode); 
  }

  ENV? getENV(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      String? code = PackageManager().deviceVersionCode;
      dynamic env;
      print(code);
      if (json[key].containsKey(code)) {
        env = json[key][code];
      } else if (json[key].containsKey("default")) {
        env = json[key]["default"];
      }
      if (env != null) {
        return ENV(
            env: stringOf(() => env["env"]),
            accountDomainName: stringOf(() => env["account_domain_name"]));
      }
    }
    return null;
  }

  String getTKey(Map<String, dynamic> json, String source) {
    String key = source;
    Locale myLocale = Translations().locale!;
    List<String> keys = json.keys.toList();
    int index = keys.indexWhere((e) => e == "${key}_${myLocale.languageCode}");
    if (index != -1) key = keys[index];
    return key;
  }

  List<HomeIcon> _getHeaderIcons(json, List<HomeIcon> origin) {
    print(json);
    List<HomeIcon> icons = [];
    listFrom(json, []).forEach((icon) {
      icons.add(HomeIcon.fromJson(icon));
    });
    if (icons.isEmpty) icons = origin;
    icons.removeWhere((e) => boolOf(() => e.hidden));
    return icons;
  }

  List<BottomMenuIcon> _getFooterIcons(json, List<BottomMenuIcon> origin) {
    List<BottomMenuIcon> icons = [];
    listFrom(json, []).forEach((icon) {
      icons.add(BottomMenuIcon.fromJson(icon));
    });
    if (icons.isEmpty) icons = origin;
    icons.removeWhere((e) => boolOf(() => e.hidden!));
    return icons;
  }

  bool get isReviewMode => mode == "review";


  bool enableFunction(State state, List list, String code) {
    return list.any((element) {
      //all => show android, ios
      //live => show live
      //review => show review
      //android => show android, hidden ios
      //android:live => show android:live,hide android:review, hidden ios
      //android:review => show android:review,hide android:live, hidden ios
      //ios => show ios, hidden android
      //ios:live => show ios:live,hide ios:review, hidden android
      //ios:review => show ios:review,hide ios:live, hidden android

      bool enable = false;
      String _method = stringOf(() => element.split(":")[0], "");
      String method = _method.replaceAll("-", "");
      String role = stringOf(() => element.split(":")[1], "all");
      String subRole = stringOf(() => element.split(":")[2], "all");
      bool inLive = PackageManager().onlyInLiveVersion(state);
      bool inReview = PackageManager().onlyInReviewVersion(state);
      bool isAndroid = role == "android" && Platform.isAndroid;
      bool isIOS = role == "ios" && Platform.isIOS;
      if (method == code) {
        if (role == "all")
          enable = true;
        else if (role == "live" && inLive)
          enable = true;
        else if (role == "review" && inReview)
          enable = true;
        else if (isAndroid) {
          if (subRole == "all")
            enable = true;
          else if (subRole == "live" && inLive)
            enable = true;
          else if (subRole == "review" && inReview) enable = true;
        } else if (isIOS) {
          if (subRole == "all")
            enable = true;
          else if (subRole == "live" && inLive)
            enable = true;
          else if (subRole == "review" && inReview) enable = true;
        }
        if (_method.contains("-")) enable = !enable;
      }
      return enable;
    });
  }
}
