import 'dart:io';
import 'dart:math';

import 'package:cnvsoft/core/http.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/scope.dart';
import 'package:cnvsoft/core/translation.dart';
import 'package:cnvsoft/special/base_citenco/extend/dashboard_extend/bottom_menu_icon.dart';
import 'package:cnvsoft/special/base_citenco/modify/home/home_icon.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:flutter/material.dart';

import 'level_asset.dart';
import 'package.dart';

class BaseScope extends BaseLoyaltyScope<BaseScope> {
  int version = 1;
  String mode = "live";
  List<String> enableLogin = BasePKG().enableLogin;
  List<String> enableGameProfile = BasePKG().enableGameProfile;
  bool enableSupportCenter = BasePKG().enableSupportCenter;
  bool showLevelCard = BasePKG().showLevelCard;
  bool hasLockApp = true;
  String liveStreamId = BasePKG().liveStreamId;
  String helpPageId = BasePKG().helpPageId;
  BoxFit? errorImageFit = BasePKG().errorImageFit;
  List<HomeIcon> headerIcons = BasePKG().headerIcons;
  List<HomeIcon> gridIcons = BasePKG().gridIcons;
  List<BottomMenuIcon> footerIcons = BasePKG().footerIcons;
  double elevationAppbar = BasePKG().elevationAppbar;
  bool _enablePayoo = BasePKG().enablePayoo;
  bool _enableMomo = BasePKG().enableMomo;
  bool centerGridIcons = BasePKG().centerGridIcons;

  // String homeRewardTitle = BasePKG().homeRewardTitle;
  // String homeProductTitle = BaseTrans().homeProductTitle;
  bool enableLocalImage = BasePKG().enableLocalImage;
  bool _enableTopUp = BasePKG().enableTopUp;
  String dsnErrorLog = BasePKG().dsnErrorLog;
  bool isMultiBrand = BasePKG().isMultiBrand;
  // bool setOrderLocation = BasePKG().setOrderLocation;
  String commitMessage = BasePKG().commitMessage;
  String commitTitle = BasePKG().commitTitle;
  bool enableHeaderColor = BasePKG().enableHeaderColor;
  bool enableOTP = BasePKG().enableOTP; //remove if QC test pass OTP new.
  bool allowNetwork = BasePKG().allowNetwork;
  bool showYoutube = BasePKG().showYoutube;
  String zaloOtp = "zalo://";
  String zaloDownload = "https://zalo.me";
  bool enableSetting = BasePKG().enableSetting;
  int minuteHomeDialog = 1440;
  int durationNumberCircle = BasePKG().durationNumberCircle;
  bool loginIcon = BasePKG().loginIcon;
  bool phoneBg = BasePKG().phoneBg;
  double borderRadiusBottomAppBar = BasePKG().borderRadiusBottomAppBar;
  double marginSkipBtn = BasePKG().marginSkipBtn;
  bool useNewSupportCenterPage = BasePKG().useNewSupportCenterPage;
  bool enableGiftCard = BasePKG().enableGiftCard;
  bool logoGallery = BasePKG().logoGallery;
  bool allowLocal = true;
  bool clearStuffSession = false;
  bool clearStorage = false;
  bool skipReferral = BasePKG().skipReferral;
  bool affiliate = false;
  bool? isShowPriceCompare = BasePKG().isShowPriceCompare;
  bool enableRewardSupportCenter = BasePKG().enableRewardSupportCenter;
  bool enableGame = BasePKG().enableGame;
  bool newUIProfile = BasePKG().newUIProfile;
  RatingType? ratingType = BasePKG().ratingType;

  bool ecommerceUI = BasePKG().ecommerceUI;
  bool redeemWithCode = BasePKG().redeemWithCode;
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
  String privacyLink = BasePKG().privacyLink;
  bool migrateOldVersion = false;
  bool showOtherGender = BasePKG().showOtherGender;
  bool forceUnAuth = BasePKG().forceUnAuth;
  bool enableBrand = BasePKG().enableBrand;
  String phoneApple = "";
  BoxFit landingBoxFit = BasePKG().landingBoxFit;
  bool enableInputTopupValue = false;

  bool enableAgeUser = BasePKG().enableAgeUser;
  bool isIndividual = BasePKG().isIndividual;
  bool enableProfileWarranty = BasePKG().enableProfileWarranty;
  bool enableAnnoucement = BasePKG().enableAnnoucement;
  bool enableLocation = BasePKG().enableLocation;
  bool enableContact = BasePKG().enableContact;
  bool homeIconCircle = BasePKG().homeIconCircle;
  bool isGoogle = BasePKG().isGoogle;
  bool isApple = BasePKG().isApple;
  bool disableShadowHeaderMenuBottomMenu =
      BasePKG().disableShadowHeaderMenuBottomMenu;
  bool isGridIconMenuBorderBg = BasePKG().isGridIconMenuBorderBg;
  bool isLoginRandom = BasePKG().isLoginRandom;
  Color? colorLoginPrimary = BasePKG().colorLoginPrimary;
  Color? colorHeaderMenu = BasePKG().colorHeaderMenu;
  Color? colorBottombar = BasePKG().colorBottombar;

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
    _i!.colorLoginPrimary =
        HexColor(stringOf(() => json["colorLoginPrimary"], _i!.mode));
    _i!.colorHeaderMenu =
        HexColor(stringOf(() => json["colorHeaderMenu"], _i!.mode));
    _i!.colorBottombar =
        HexColor(stringOf(() => json["colorBottombar"], _i!.mode));
    _i!.enableLogin = getListValue<String>(
        json, ["login_method_list", "enable_login"], _i!.enableLogin);
    _i!.enableGameProfile =
        listFrom(json["enable_game_profile"], _i!.enableGameProfile);
    _i!.enableAgeUser = boolOf(() => json["enableAgeUser"], _i!.enableAgeUser);
    _i!.isLoginRandom = boolOf(() => json["isLoginRandom"], _i!.isLoginRandom);
    _i!.enableProfileWarranty =
        boolOf(() => json["enableProfileWarranty"], _i!.enableProfileWarranty);
    _i!.enableAnnoucement =
        boolOf(() => json["enableAnnoucement"], _i!.enableAnnoucement);
    _i!.isIndividual = boolOf(() => json["isIndividual"], _i!.isIndividual);
    _i!.enableLocation =
        boolOf(() => json["enableLocation"], _i!.enableLocation);
    _i!.enableContact = boolOf(() => json["enableContact"], _i!.enableContact);
    _i!.homeIconCircle =
        boolOf(() => json["homeIconCircle"], _i!.homeIconCircle);
    _i!.isGoogle = boolOf(() => json["isGoogle"], _i!.isGoogle);
    _i!.isApple = boolOf(() => json["isApple"], _i!.isApple);
    _i!.disableShadowHeaderMenuBottomMenu = boolOf(
        () => json["disableShadowHeaderMenuBottomMenu"],
        _i!.disableShadowHeaderMenuBottomMenu);
    _i!.isGridIconMenuBorderBg = boolOf(
        () => json["isGridIconMenuBorderBg"], _i!.isGridIconMenuBorderBg);
    _i!.showLevelCard =
        boolOf(() => json["show_level_card"], _i!.showLevelCard);
    _i!.enableSupportCenter =
        boolOf(() => json["enable_support_center"], _i!.enableSupportCenter);
    _i!.hasLockApp = boolOf(() => json["has_lock_app"], _i!.hasLockApp);
    _i!.liveStreamId = stringOf(() => json["live_stream_id"], _i!.liveStreamId);
    _i!.helpPageId = stringOf(() => json["help_page_id"], _i!.helpPageId);
    _i!.errorImageFit =
        dataOf(() => BoxFit.values[json["error_image_fit"]], _i!.errorImageFit);
    _i!.headerIcons = _getHeaderIcons(
        json[getTKey(
            json,
            json.containsKey("header_icons_override")
                ? "header_icons_override"
                : "header_icons")],
        _i!.headerIcons);
    _i!.gridIcons = _getHeaderIcons(
        json[getTKey(
            json,
            json.containsKey("grid_icons_override")
                ? "grid_icons_override"
                : "grid_icons")],
        _i!.gridIcons);
    _i!.footerIcons =
        _getFooterIcons(json[getTKey(json, "footer_icons")], _i!.footerIcons);
    _i!.elevationAppbar =
        doubleOf(() => json["elevation_appbar"] * 1.0, _i!.elevationAppbar);
    _i!._enablePayoo = boolOf(() => json["enable_payoo"], _i!._enablePayoo);
    _i!._enableMomo = boolOf(() => json["enable_momo"], _i!._enableMomo);
    _i!.centerGridIcons =
        boolOf(() => json["center_grid_icons"], _i!.centerGridIcons);
    _i!.enableLocalImage =
        boolOf(() => json["enable_local_image"], _i!.enableLocalImage);
    _i!._enableTopUp = getValue<bool>(
        json, ["enable_topup", "enable_top_up"], _i!._enableTopUp);
    _i!.dsnErrorLog = stringOf(() => json["dsn_error_log"], _i!.dsnErrorLog);
    _i!.isMultiBrand = getValue<bool>(
        json, ["enable_multi_brand", "is_multi_brand"], _i!.isMultiBrand);
    _i!.affiliate = getValue<bool>(
        json, ["enable_affiliate", "is_affiliate"], _i!.affiliate);
    // _i!.setOrderLocation = getValue<bool>(json,
    //     ["enable_order_location", "set_order_location"], _i!.setOrderLocation);
    _i!.commitMessage =
        stringOf(() => json["commit_message"], _i!.commitMessage);
    _i!.commitTitle = stringOf(() => json["commit_title"], _i!.commitTitle);
    _i!.enableHeaderColor =
        boolOf(() => json["enable_header_color"], _i!.enableHeaderColor);
    _i!.enableOTP = boolOf(() => json["enable_otp"], _i!.enableOTP);
    _i!.allowNetwork = boolOf(() => json["allow_network"], _i!.allowNetwork);
    _i!.showYoutube = boolOf(() => json["show_youtube"], _i!.showYoutube);
    _i!.zaloOtp = stringOf(() => json["zalo_otp"], _i!.zaloOtp);
    _i!.enableSetting = boolOf(() => json["enable_setting"], _i!.enableSetting);
    _i!.zaloDownload = stringOf(() => json["zalo_download"], _i!.zaloDownload);
    _i!.minuteHomeDialog =
        intOf(() => json["minute_home_dialog"], _i!.minuteHomeDialog);
    _i!.durationNumberCircle =
        intOf(() => json['duration_number_circle'], _i!.durationNumberCircle);
    _i!.loginIcon = boolOf(() => json['login_icon'], _i!.loginIcon);
    _i!.phoneBg = boolOf(() => json['phone_bg'], _i!.phoneBg);
    _i!.borderRadiusBottomAppBar = doubleOf(
        () => json['border_radius_bottom_AppBar'],
        _i!.borderRadiusBottomAppBar);
    _i!.marginSkipBtn =
        doubleOf(() => json['margin_skip_btn'], _i!.marginSkipBtn);
    _i!.useNewSupportCenterPage = boolOf(
        () => json["new_support_center_page"], _i!.useNewSupportCenterPage);
    _i!.enableGiftCard = boolOf(() => json['has_giftcard'], _i!.enableGiftCard);
    _i!.logoGallery = boolOf(() => json["request_logo"], _i!.logoGallery);
    _i!.allowLocal = boolOf(() => json['allow_local'], _i!.allowLocal);
    _i!.isShowPriceCompare =
        dataOf(() => json["is_show_price_compare"], _i!.isShowPriceCompare);
    _i!.skipReferral = getValue<bool>(
        json, ['enable_skip_referral', 'skip_referral'], _i!.skipReferral);
    _i!.newUIProfile = boolOf(() => json['new_ui_profile'], _i!.newUIProfile);
    _i!.enableRewardSupportCenter = getValue<bool>(
        json,
        ['enable_support_center_reward', 'enable_reward_support_center'],
        _i!.enableRewardSupportCenter);
    _i!.ratingType = dataOf(
        () => json["rating_type"] != null
            ? (json["rating_type"] == "product"
                ? RatingType.Product
                : RatingType.Order)
            : null,
        _i!.ratingType);
    _i!.ecommerceUI = boolOf(() => json["ecommerce_ui"], _i!.ecommerceUI);
    _i!.redeemWithCode = getValue<bool>(json,
        ["enable_redeem_with_code", "redeem_with_code"], _i!.redeemWithCode);
    _i!.clientAppHeader = getValue<int>(
        json, ["client_num", "client_app_header"], _i!.clientAppHeader);
    _i!.env = dataOf(() => getENV(json, "env"), _i!.env);
    _i!.botChannelId = dataOf(() => json["bot_channel_id"], _i!.botChannelId);
    _i!.phoneBotLog = getListValue<String>(
        json, ["bot_phone_list", "phone_bot_log"], _i!.phoneBotLog);
    _i!.privacyLink = stringOf(() => json['privacy_link'], _i!.privacyLink);
    _i!.clearStuffSession =
        boolOf(() => json['clear_stuff_session'], _i!.clearStuffSession);
    _i!.clearStorage = boolOf(() => json['clear_storage'], _i!.clearStorage);
    _i!.migrateOldVersion =
        boolOf(() => json["migrate_old_version"], _i!.migrateOldVersion);
    _i!.memberCardStyle = MemberCardStyle.values[getValue<int>(
            json,
            ["member_card_num", "member_card_style"],
            _i!.memberCardStyle.index) %
        MemberCardStyle.values.length];
    _i!.showOtherGender = getValue<bool>(json,
        ["enable_other_gender", "show_other_gender"], _i!.showOtherGender);
    _i!.forceUnAuth = boolOf(() => json["force_unauth"], _i!.forceUnAuth);
    _i!.enableBrand = boolOf(() => json["enable_brand"], _i!.enableBrand);
    _i!.phoneApple =
        getValue<String>(json, ["apple_phone", "phone_apple"], _i!.phoneApple);
    _i!.landingBoxFit = dataOf(() => BoxFit.values[max(
        0,
        min(
            intOf(() => json["landing_box_fit"],
                BoxFit.values.indexOf(_i!.landingBoxFit)),
            BoxFit.values.length - 1))])!;
    print(_i!.phoneApple);
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

  bool isGoogleLoginEnable(State state) =>
      enableFunction(state, enableLogin, "google");

  bool isFBLoginEnable(State state) =>
      enableFunction(state, enableLogin, "facebook");

  bool isAppleLoginEnable(State state) =>
      enableFunction(state, enableLogin, "apple");

  bool get isShowLevelCard => showLevelCard;

  bool get isShowIndividual => isIndividual;

  bool get isenableSupportCenter => enableSupportCenter;

  bool get ishasLockApp => hasLockApp;

  bool enableWheelGame(State state) =>
      enableFunction(state, enableGameProfile, "wheel");

  bool enableWheelGameWeb(State state) =>
      enableFunction(state, enableGameProfile, "wheel_web");

  bool enableVirusKillerGame(State state) =>
      enableFunction(state, enableGameProfile, "virus_killer");

  bool enableGiftBoxGame(State state) =>
      enableFunction(state, enableGameProfile, "gift_box");

  bool enablePhoneNumberGame(State state) =>
      enableFunction(state, enableGameProfile, "phone_number");

  bool enable123DzoGame(State state) =>
      enableFunction(state, enableGameProfile, "123_dzo");

  bool get enableCommitDialog =>
      boolOf(() => commitMessage.isNotEmpty && commitTitle.isNotEmpty);

  bool get enablePayoo => boolOf(() => _enablePayoo);

  bool get enableMomo => boolOf(() => _enableMomo);

  bool get enableTopUp => boolOf(() => _enableTopUp);

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
