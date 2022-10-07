import 'dart:convert';

import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'multiasync.dart';

class StorageCNV {
  static StorageCNV? _internal;
  late SharedPreferences _pref;

  StorageCNV._();

  factory StorageCNV() {
    if (_internal == null) _internal = StorageCNV._();
    return _internal!;
  }

  Future<void> init() async => _pref = await SharedPreferences.getInstance();

  Future<bool> setMapValue(
      String key, String? childKey, dynamic childValue) async {
    if (childKey == null || childKey.isEmpty) return Future.value(false);
    String? p = _pref.getString(key);
    Map<String, dynamic> map = {};
    try {
      map = json.decode(p!);
    } catch (e) {
      Log().severe(e);
    }
    map[childKey] = childValue;
    try {
      p = json.encode(map);
    } catch (e) {
      Log().severe(e);
    }
    if (p != null) {
      return await _pref.setString(key, p);
    }
    return false;
  }

  Future<bool> setString(String key, String? value) {
    return value == null ? Future.value(false) : _pref.setString(key, value);
  }

  Future<bool> setBool(String key, bool? value) {
    return value == null ? Future.value(false) : _pref.setBool(key, value);
  }

  Future<bool> setDouble(String key, double? value) {
    return value == null ? Future.value(false) : _pref.setDouble(key, value);
  }

  Future<bool> setInt(String key, int? value) {
    return value == null ? Future.value(false) : _pref.setInt(key, value);
  }

  Future<bool> setStringList(String key, List<String>? value) {
    return value == null
        ? Future.value(false)
        : _pref.setStringList(key, value);
  }

  dynamic get(String key) => _pref.get(key);

  dynamic getMapValue(String key, String childKey) {
    String? p = _pref.getString(key);
    Map<String, dynamic> map = {};
    try {
      map = json.decode(p!);
    } catch (e) {
      Log().severe(e);
    }
    return map[childKey];
  }

  bool? getBool(String key) => _pref.getBool(key);

  int? getInt(String key) => _pref.getInt(key);

  double? getDouble(String key) => _pref.getDouble(key);

  String? getString(String key) => _pref.getString(key);

  List<String>? getStringList(String key) => _pref.getStringList(key);

  bool containsKey(String key) => _pref.containsKey(key);

  Future<bool> remove(String key) => _pref.remove(key);

  Future<bool> clear() => _pref.clear();

  checkConfigAcp(){
    var _acpConfig = StorageCNV().getString("APP_ACP_CONFIG");
    if(!StorageCNV().containsKey("APP_ACP_CONFIG") && _acpConfig == ""){
      return false;
    }
    var _senderid = StorageCNV().getString("APP_ACP_FCMSENDERID");
    if(!StorageCNV().containsKey("APP_ACP_FCMSENDERID") && _senderid == ""){
      return false;
    }
    var _serverKey = StorageCNV().getString("APP_ACP_FCMSERVERKEY");
    if(!StorageCNV().containsKey("APP_ACP_FCMSERVERKEY") && _serverKey == ""){
      return false;
    }
    var _invi = StorageCNV().getString("APP_ACP_INVI");
    if(!StorageCNV().containsKey("APP_ACP_INVI") && _invi == ""){
      return false;
    }
    var _sku = StorageCNV().getString("APP_ACP_SKU");
    if(!StorageCNV().containsKey("APP_ACP_SKU") && _sku == ""){
      return false;
    }
    var _homeConfig = StorageCNV().getString("HOME_ACP_CONFIG");
    if(!StorageCNV().containsKey("HOME_ACP_CONFIG") && _homeConfig == ""){
      return false;
    }
    var _homeGrid = StorageCNV().getString("HOME_ACP_GRID");
    if(!StorageCNV().containsKey("HOME_ACP_GRID") && _homeGrid == ""){
      return false;
    }
    var _homeHeader = StorageCNV().getString("HOME_ACP_HEADER");
    if(!StorageCNV().containsKey("HOME_ACP_HEADER") && _homeHeader == ""){
      return false;
    }
    var _homeMenu = StorageCNV().getString("HOME_ACP_MENU");
    if(!StorageCNV().containsKey("HOME_ACP_MENU") && _homeMenu == ""){
      return false;
    }
    var _homeContent = StorageCNV().getString("HOME_ACP_CONTENT");
    if(!StorageCNV().containsKey("HOME_ACP_CONTENT") && _homeContent == ""){
      return false;
    }
    var _homeLogo = StorageCNV().getString("HOME_ACP_LOGO");
    if(!StorageCNV().containsKey("HOME_ACP_LOGO") && _homeLogo == ""){
      return false;
    }
    // header 
    var _desHeaderBg = StorageCNV().getString("DES_ACP_HEADER_BACKGROUNDCOLOR");
    if(!StorageCNV().containsKey("DES_ACP_HEADER_BACKGROUNDCOLOR") && _desHeaderBg == ""){
      return false;
    }
    var _desTextColor = StorageCNV().getString("DES_ACP_HEADER_TEXTCOLOR");
    if(!StorageCNV().containsKey("DES_ACP_HEADER_TEXTCOLOR") && _desTextColor == ""){
      return false;
    }
    var _desIcon = StorageCNV().getString("DES_ACP_HEADER_ICONCOLOR");
    if(!StorageCNV().containsKey("DES_ACP_HEADER_ICONCOLOR") && _desIcon == ""){
      return false;
    }
    var _desNoti = StorageCNV().getString("DES_ACP_HEADER_NOTICOLOR");
    if(!StorageCNV().containsKey("DES_ACP_HEADER_NOTICOLOR") && _desNoti == ""){
      return false;
    }

    // BODY 
    var _desBody = StorageCNV().getString("DES_ACP_BODY_BACKGROUNDCOLOR");
    if(!StorageCNV().containsKey("DES_ACP_BODY_BACKGROUNDCOLOR") && _desBody == ""){
      return false;
    }
    var _desBodyText = StorageCNV().getString("DES_ACP_BODY_TEXTCOLOR");
    if(!StorageCNV().containsKey("DES_ACP_BODY_TEXTCOLOR") && _desBodyText == ""){
      return false;
    }

    // BODY 
    var _desIconActive = StorageCNV().getString("DES_ACP_ICON_ACTIVE");
    if(!StorageCNV().containsKey("DES_ACP_ICON_ACTIVE") && _desIconActive == ""){
      return false;
    }
    var _desIconDeactive = StorageCNV().getString("DES_ACP_ICON_UNACTIVE");
    if(!StorageCNV().containsKey("DES_ACP_ICON_UNACTIVE") && _desIconDeactive == ""){
      return false;
    }

    return true;
  }

    setDefault(){
    // header 
      StorageCNV().setString("DES_ACP_HEADER_BACKGROUNDCOLOR", "#3072FF" );
      StorageCNV().setString("DES_ACP_HEADER_TEXTCOLOR", "#FFFFFF" );
      StorageCNV().setString("DES_ACP_HEADER_ICONCOLOR",  "#FFFFFF" );
      StorageCNV().setString("DES_ACP_HEADER_NOTICOLOR", "#00A1F2");

      // BODY 
      StorageCNV().setString("DES_ACP_BODY_BACKGROUNDCOLOR",  "#FFFFFF" );
      StorageCNV().setString("DES_ACP_BODY_TEXTCOLOR",  "#030303" );
      StorageCNV().setString("DES_ACP_BODY_ACCENTCOLOR",  "#252733");

      // ICON 
      StorageCNV().setString("DES_ACP_ICON_ACTIVE","#F67C98" );
      StorageCNV().setString("DES_ACP_ICON_UNACTIVE", "#535F6B" );


      // home menu
      StorageCNV().setInt("DES_ACP_HOME",1 );
      StorageCNV().setInt("DES_ACP_MENU", 1);

      StorageCNV().setBool("HOME_ACP_TOPUP", false);
      StorageCNV().setBool("HOME_ACP_BRANCH", false);
  }

  Future<void> clearSession() async {
    
    var _languages = StorageCNV().getString("LANGUAGES");
    var _scope = StorageCNV().getString("SCOPE");
    var _version = StorageCNV().getString("VERSION");
    var _deviceId = StorageCNV().getString("DEVICE_ID");
    var _customerID = StorageCNV().getString("CUSTOMER_ID");
    var _codeReferralInputeds = StorageCNV().getString("CODE_REFERRAL_INPUTEDS");
    var _skipReferrals = StorageCNV().getString("SKIP_REFERRALS");
    var _headerImageHeight = StorageCNV().getDouble("HEADER_HEIGHT_IMAGE");
    var _messageId = StorageCNV().getString("google.message_id");
    var _error = StorageCNV().getString("ERRORS");
    var _translation = StorageCNV().getString("TRANSLATION");
    var _translationVersion = StorageCNV().getString("TRANSLATION_VERSION");
    var _checkFileExist = StorageCNV().getString("CHECK_FILE_EXIST");
    var _checkName = StorageCNV().getString("PROFILE_NAME");


    var _acp = StorageCNV().getString("APP_ACP_VERSION");
    var _acpConfig = StorageCNV().getString("APP_ACP_CONFIG");
    var _senderid = StorageCNV().getString("APP_ACP_FCMSENDERID");
    var _serverKey = StorageCNV().getString("APP_ACP_FCMSERVERKEY");
    var _invi = StorageCNV().getString("APP_ACP_INVI");
    var _sku = StorageCNV().getString("APP_ACP_SKU");
    var _homeConfig = StorageCNV().getString("HOME_ACP_CONFIG");
    var _homeGrid = StorageCNV().getString("HOME_ACP_GRID");
    var _homeHeader = StorageCNV().getString("HOME_ACP_HEADER");
    var _homeMenu = StorageCNV().getString("HOME_ACP_MENU");
    var _homeContent = StorageCNV().getString("HOME_ACP_CONTENT");
    var _homeLogo = StorageCNV().getString("HOME_ACP_LOGO");
    var _homeTopup = StorageCNV().getBool("HOME_ACP_TOPUP");
    var _homeBranch = StorageCNV().getBool("HOME_ACP_BRANCH");
    // header 
    var _desHeaderBg = StorageCNV().getString("DES_ACP_HEADER_BACKGROUNDCOLOR");
    var _desTextColor = StorageCNV().getString("DES_ACP_HEADER_TEXTCOLOR");
    var _desIcon = StorageCNV().getString("DES_ACP_HEADER_ICONCOLOR");
    var _desNoti = StorageCNV().getString("DES_ACP_HEADER_NOTICOLOR");

    // BODY 
    var _desBody = StorageCNV().getString("DES_ACP_BODY_BACKGROUNDCOLOR");
    var _desBodyText = StorageCNV().getString("DES_ACP_BODY_TEXTCOLOR");

    // BODY 
    var _desIconActive = StorageCNV().getString("DES_ACP_ICON_ACTIVE");
    var _desIconDeactive = StorageCNV().getString("DES_ACP_ICON_UNACTIVE");

    // home bar menu
    var _desHome = StorageCNV().getInt("DES_ACP_HOME");
    var _desMenu = StorageCNV().getInt("DES_ACP_MENU");
    var _pur = StorageCNV().getInt("PUR_ACP_CONFIG");
    var _acp_new = StorageCNV().getBool("APP_ACP_VERSION_NEW");

    await StorageCNV().clear();
    setDefault();
    await MultiAsync().process({
      '"LANGUAGES"': () => StorageCNV().setString("LANGUAGES", _languages),
      '"PROFILE_NAME"': () => StorageCNV().setString("PROFILE_NAME", _checkName),
      '"SCOPE"': () => StorageCNV().setString("SCOPE", _scope),
      '"VERSION"': () => StorageCNV().setString("VERSION", _version),
      '"DEVICE_ID"': () => StorageCNV().setString("DEVICE_ID", _deviceId),
      '"CODE_REFERRAL_INPUTEDS"': () =>
          StorageCNV().setString("CODE_REFERRAL_INPUTEDS", _codeReferralInputeds),
      '"SKIP_REFERRALS"': () =>
          StorageCNV().setString("SKIP_REFERRALS", _skipReferrals),
      '"HEADER_HEIGHT_IMAGE"': () =>
          StorageCNV().setDouble("HEADER_HEIGHT_IMAGE", _headerImageHeight),
      '"ERRORS"': () => StorageCNV().setString("ERRORS", _error),
      '"google.message_id"': () =>
          StorageCNV().setString("google.message_id", _messageId),
      '"TRANSLATION"': () => StorageCNV().setString("TRANSLATION", _translation),
      '"TRANSLATION_VERSION"': () =>
          StorageCNV().setString("TRANSLATION_VERSION", _translationVersion),
      '"CHECK_FILE_EXIST"': () =>
          StorageCNV().setString("CHECK_FILE_EXIST", _checkFileExist),
    });
    await StorageCNV().setString("APP_ACP_VERSION",_acp);
    await StorageCNV().setString("APP_ACP_CONFIG", _acpConfig);
    await StorageCNV().setString("APP_ACP_FCMSENDERID", _senderid);
    await StorageCNV().setString("APP_ACP_FCMSERVERKEY", _serverKey);
    await StorageCNV().setString("APP_ACP_INVI", _invi);
    await StorageCNV().setString("APP_ACP_SKU", _sku);
    await StorageCNV().setString("HOME_ACP_CONFIG", _homeConfig);
    await StorageCNV().setString("HOME_ACP_GRID", _homeGrid);
    await StorageCNV().setString("HOME_ACP_HEADER", _homeHeader);
    await StorageCNV().setString("HOME_ACP_MENU", _homeMenu);
    await StorageCNV().setString("HOME_ACP_CONTENT", _homeContent);
    await StorageCNV().setString("HOME_ACP_LOGO", _homeLogo);
    await StorageCNV().setBool("HOME_ACP_TOPUP", _homeTopup);
    await StorageCNV().setBool("HOME_ACP_BRANCH", _homeBranch);
    // header 
    await StorageCNV().setString("DES_ACP_HEADER_BACKGROUNDCOLOR",_desHeaderBg);
    await StorageCNV().setString("DES_ACP_HEADER_TEXTCOLOR", _desTextColor);
    await StorageCNV().setString("DES_ACP_HEADER_ICONCOLOR", _desIcon);
    await StorageCNV().setString("DES_ACP_HEADER_NOTICOLOR", _desNoti);

    // BODY 
    await StorageCNV().setString("DES_ACP_BODY_BACKGROUNDCOLOR",_desBody);
    await StorageCNV().setString("DES_ACP_BODY_TEXTCOLOR", _desBodyText);
    // StorageCNV().setString("DES_ACP_BODY_ACCENTCOLOR", resDesi.data!.body!.accentColor == null ? "#252733" : resDesi.data!.body!.accentColor!);

    // BODY 
    await StorageCNV().setString("DES_ACP_ICON_ACTIVE",_desIconActive);
    await StorageCNV().setString("DES_ACP_ICON_UNACTIVE", _desIconDeactive);

    // home bar menu
    await StorageCNV().setInt("DES_ACP_HOME",_desHome);
    await StorageCNV().setInt("DES_ACP_MENU",_desMenu);
    await StorageCNV().setInt("PUR_ACP_CONFIG", _pur);
    await StorageCNV().setString("CUSTOMER_ID_OLD", _customerID.toString());
    await StorageCNV().setBool("APP_ACP_VERSION_NEW", false);
  }

  Future<void> clearVersion() async {
    await remove("VERSION");
  }

  Future<void> clearStorageCNV() async {
    await StorageCNV().clear();
  }

  Future<void> clearStuffSession() async {
    var _authen = StorageCNV().getString("AUTH_TOKEN");
    var _login = StorageCNV().getString("LOGIN_TOKEN");
    var _phone = StorageCNV().getString("PHONE_NUMBER");
    var _customerId = StorageCNV().getString("CUSTOMER_ID");

    await StorageCNV().clear();

    await MultiAsync().process({
      '"AUTH_TOKEN"': () => StorageCNV().setString("AUTH_TOKEN", _authen),
      '"LOGIN_TOKEN"': () => StorageCNV().setString("LOGIN_TOKEN", _login),
      '"PHONE_NUMBER"': () => StorageCNV().setString("PHONE_NUMBER", _phone),
      '"CUSTOMER_ID"': () => StorageCNV().setString("CUSTOMER_ID", _customerId.toString()),
    });
  }

  Future<bool> checkFileExist(String path) async {
    String key = "CHECK_FILE_EXIST";
    var func = () async {
      var exist = await Utils.assetExists(path);
      try {
        var s = jsonDecode(getString(key) ?? "{}");
        s[path] = exist;
        await setString(key, jsonEncode(s));
      } catch (e) {
        await setString(key, "{}");
        Log().severe(e);
      }
      return exist;
    };
    if (containsKey(key)) {
      String src = getString(key) ?? "";
      try {
        Map<String, dynamic> s = jsonDecode(src);
        if (s.containsKey(path)) {
          return s[path] as bool;
        } else {
          return func();
        }
      } catch (e) {
        Log().severe(e);
        return func();
      }
    } else {
      return func();
    }
  }
}
