import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/device.dart';
import 'package:cnvsoft/core/multiasync.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/special/base_citenco/dialog/confirm_dialog.dart';
import 'package:cnvsoft/special/base_citenco/dialog/request_login_dialog.dart'; 
import 'package:cnvsoft/special/base_citenco/model/profile.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart'; 
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/fcm/fcm.dart';
import '../../../core/package.dart';

class MyProfile with DataMix {
  static MyProfile? _internal;
  Profile _profile = Profile.init(); 

  MyProfile._();

  factory MyProfile() {
    if (_internal == null) {
      _internal = MyProfile._();
    }
    return _internal!;
  }

  final String imageKey = "UPDATE_IMAGE_KEY";

  bool get isGuest => (_profile.isGuest ?? false) || isGuestApple;

  bool get isGuestApple => StorageCNV().getBool("IS_APPLE") ?? false; 

  Profile? get profile => _profile;


  bool get isVerifiedPhone => _profile.isVerifiedPhone;

  String? get avatarUrl => _profile.avatarUrl;

  String? get email => _profile.email;

  String get name => isGuestApple ? "Guest" : _profile.fullName;

  int? get pointUsable => _profile.pointUsable;

  dynamic get customerId => _profile.customerId;

  String get firstName => _profile.firstName ?? "";

  String get lastName => _profile.lastName ?? "";

  set firstName(String value) => _profile.firstName = value;

  set lastName(String value) => _profile.lastName = value;

  String? get phone => isGuestApple ? "" : _profile.phone;

  String? get myPhone => isGuestApple ? "" : _profile.myPhone; 

  String? get countryCode => _profile.countryCode;

  DateTime? get birthday => _profile.birthday; 

  String? get appleId => _profile.appleId;

  String? get facebookId => _profile.facebookId;

  String? get googleId => _profile.googleId;

  int? get gender => _profile.gender; 

  Map<String, dynamic>? get customFieldData => _profile.customFieldData;

  List<CustomFields>? get customFields => _profile.customFields;

  double? get mapLatitude => _profile.mapLatitude;

  double? get mapLongitude => _profile.mapLongitude;

  int? get point => _profile.point;

  String? get typeName => _profile.typeName;

  String? get uid => _profile.uid;

  String get pointUsableFormatted => _profile.pointUsableFormatted;

  double get levelIconSize => 25;

  bool get isLogin => stringOf(() => StorageCNV().getString("TOKEN")).isNotEmpty;

  bool get isVerifiedUserInfo => BasePKG().boolOf(() => StorageCNV().getString("PROFILE_NAME")!.isNotEmpty);

  bool get isMobileDelete => BasePKG().boolOf(() => _profile.mobileDeleted);


  void init() {
    _profile = Profile.init();
  }

  void initGuest() {
    _profile = Profile.guest();
  }

  Future<void> _loadAPI(State state, {required var customerId}) async {
    
    Profile? _profile;  
    Function barcodeAsync = (profile) async {
      if (profile != null &&
          profile.myPhone != null &&
          profile.myPhone.isNotEmpty &&  profile.myPhone != "") {
        var phone = profile.myPhone;

        // var value = await BasePKG.of(state).getUserBarCode(phone);
        // if (value != null) _barcode = value;
      }
    }; 
    
    await setProfile(
      state, 
      profile: _profile, 
    );
  }

  Future<void> _loadLocal(State state) async {
    dynamic dprofile;
    dynamic dbarcode;
    dynamic dlevel;
    dynamic dpoint;
    

    if (StorageCNV().containsKey("PROFILE")){
      dprofile = BasePKG().dataOf(
          () => {"data": jsonDecode(StorageCNV().getString("PROFILE") ?? "{}")});
    }

    if (StorageCNV().containsKey("USER_BARCODE")){

      dbarcode = BasePKG().dataOf(
          () => jsonDecode(StorageCNV().getString("USER_BARCODE") ?? "{}"));
    }
      

    if (StorageCNV().containsKey("LEVEL")){
      dlevel = BasePKG()
          .dataOf(() => jsonDecode(StorageCNV().getString("LEVEL") ?? "{}"));
    }
      

    if (StorageCNV().containsKey("POINT")){
      dpoint = BasePKG()
          .dataOf(() => jsonDecode(StorageCNV().getString("POINT") ?? "{}"));
    }

    Profile? _profile; 
    
    if(customerId == null  && dprofile == null) {
      await StorageCNV().clearSession();
      this.clearSession();
      Navigator.of(state.context).pushReplacementNamed("login");
    }

    print("Load local dprofile");
    if (dprofile != null && Profile.fromJson(dprofile).fullName.isNotEmpty) {
      print("=> dprofile: $dprofile");
      _profile = Profile.fromJson(dprofile);
    }else{
      if(customerId == null) logOut(state);  
    } 

    print("Set profile");
    await setProfile(
      state, 
      profile: _profile, 
    );
  }

  Future<void> load(State state, {var customerId, bool force: true, bool isLogin: false}) async {
    
    if (BasePKG().boolOf(() => this._profile.isGuest))
      return;
    else {
      if (!force){
        await _loadLocal(state);
      }else{
        await _loadAPI(state, customerId:  StorageCNV().containsKey("CUSTOMER_ID") ? StorageCNV().getString("CUSTOMER_ID") : customerId);
        
      }
    }
  }

  Future<void> setProfile(State state,
      {  required Profile? profile, }) async {
    if (profile != null) {
      if (boolOf(() => profile.isGuest)) return;
      if (state.mounted) { 

        await MultiAsync().process({
          '"PROFILE"': () =>
              StorageCNV().setString("PROFILE", json.encode(profile.toJson())),
          // '"EGE_USER"': () => StorageCNV().setString("EGE_USER", profile.createdAt),
          '"PROFILE_NAME"': () => StorageCNV().setString("PROFILE_NAME", profile.fullName),
          // '"LEVEL"': () =>
          //     StorageCNV().setString("LEVEL", json.encode(level.toJson())),
          // '"POINT"': () =>
          //     StorageCNV().setString("POINT", json.encode(point.toJson())),
        });
      }
    }
  } 

  Future loginAuthentic(State state, Function()? onAuthenticated,
      {Function()? onNegative}) async {
    if (BasePKG().boolOf(() => this._profile.isGuest)) {
      if (state.mounted)
        return RequestLoginDialog.show(state, requiredBack: false);
    } else {
      return (onAuthenticated ?? () {})();
    }
  }

  Future phoneAuthentic(State state, Function()? onAuthenticated,
      {Function()? onNegative}) async {
    if (!this._profile.isVerifiedPhone) {
      if (state.mounted)
        return await showDialog(
            barrierDismissible: false,
            context: state.context,
            builder: (context) => ConfirmDialog(
                msg: BaseTrans().$mustPhoneAuthentic,
                onNegative: () => (onNegative ?? () {})(),
                onPositive: () => Navigator.of(context).pushNamed(
                    "phone_authentic",
                    arguments: {"is_login": false})));
    } else {
      return (onAuthenticated ?? () {})();
    }
  }

  Future<T> authentic<T>(State state, Function() onAuthenticated,
      {Function()? onNegative}) async {
    return await loginAuthentic(
        state, () => phoneAuthentic(state, onAuthenticated));
  }

  Future<void> logOut(State state, [bool initLogin = true]) async {
    await FCM().dispose(state);
    // fix logout ios gì đó 
    await MultiAsync().process({
      "clearPrf": () => StorageCNV().clearSession(),
    });
    this.clearSession();
    Navigator.of(state.context).pushReplacementNamed("login");
  }

  void clearSession() {
    this._profile = Profile.init();
  }

  Future<void>? savePhone(State state, String phone) {
    this._profile.myPhone = phone;
  }
 
}

// class ProfileNotifier extends BaseNotifier<Profile> {
//   ProfileNotifier() : super(ProfileMix.profile ?? Profile.init());
//
//   @override
//   ListenableProvider provider() {
//     return ChangeNotifierProvider<ProfileNotifier>(create: (_) => this);
//   }
// }
