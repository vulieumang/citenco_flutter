import 'dart:convert';
import 'dart:io';

import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/check_version.dart';
import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/modify/scope.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

import 'package.dart';

abstract class BaseLoyaltyScope<T> extends BaseModel with DataMix {
  void set(State state, Map<String, dynamic> json);

 T getValue<T>(Map<String, dynamic> json, List<String> keys, T initValue,
      [T? packageValue]) {
    T value = packageValue ?? initValue;
    for (int i = 0; i < keys.length; i++) {
      if (json.containsKey(keys[i])) {
        value = dataOf<T>(() => json[keys[i]]) ?? value;
        break;
      }
    }
    return value;
  }

  List<T> getListValue<T>(
      Map<String, dynamic> json, List<String> keys, List<T> initValue) {
    List<T> value = initValue;
    for (int i = 0; i < keys.length; i++) {
      if (json.containsKey(keys[i])) {
        value = listFrom<T>(json[keys[i]], initValue);
        break;
      }
    }
    return value;
  }

  Map<K, V> getMapValue<K, V>(
      Map<String, dynamic> json, List<String> keys, Map<K, V> initValue) {
    Map<K, V> value = initValue;
    for (int i = 0; i < keys.length; i++) {
      if (json.containsKey(keys[i])) {
        value = dataOf<Map<K, V>>(
                () => Map.castFrom<dynamic, dynamic, K, V>(json[keys[i]]),
                initValue) ??
            initValue;
        break;
      }
    }
    return value;
  }

  @override
  Map<String, dynamic> toJson() => {};
}

class AppVersion with DataMix {
  String? androidVersion;
  String? androidStoreLink;
  String? iosVersion;
  String? iosStoreLink;

  static AppVersion? _internal;

  AppVersion._();

  int get version => intOf(() => int.parse(versionStr.split(".").join("")), 0);

  String get versionStr =>
      stringOf(() => Platform.isAndroid ? androidVersion : iosVersion, "");

  String get link =>
      stringOf(() => Platform.isAndroid ? androidStoreLink : iosStoreLink);

  factory AppVersion() {
    if (_internal == null) {
      _internal = AppVersion._();
    }
    return _internal!;
  }

  set(Map<String, dynamic> json) {
    try {
      androidVersion = json["android_version"];
      iosVersion = json["ios_version"];
      androidStoreLink = json["android_store_link"];
      iosStoreLink = json["ios_store_link"];
      _saveLocal();
    } catch (e) {
      Log().severe(e);
    }
  }

  Future load(State state, [bool force = false]) async {
    if (StorageCNV().containsKey("VERSION") && !force) {
      _loadNetwork();
      return _loadLocal();
    } else {
      return _loadNetwork();
    }
  }

  Future _loadNetwork() async {
    final version = NewVersionCNV();
    var status = await version.getVersionStatus().catchError((onError) {
      print("Ứng dụng chưa có trên store");
    });
    if (status != null) {
      androidVersion = status.storeVersion;
      androidStoreLink = status.appStoreLink;
      iosVersion = status.storeVersion;
      iosStoreLink = status.appStoreLink;
      // androidVersion = "1.0.0";
      _saveLocal();
    }
  }

  Future _saveLocal() async {
    return StorageCNV().setString(
        "VERSION",
        jsonEncode({
          "android_version": androidVersion,
          "android_store_link": androidStoreLink,
          "ios_version": iosVersion,
          "ios_store_link": iosStoreLink,
        }));
  }

  Future _loadLocal() async {
    String? version = StorageCNV().getString("VERSION");
    try {
      var _version = jsonDecode(version ?? "{}");
      androidVersion = stringOf(() => _version["android_version"]);
      androidStoreLink = stringOf(() => _version["android_store_link"]);
      iosVersion = stringOf(() => _version["ios_version"]);
      iosStoreLink = stringOf(() => _version["ios_store_link"]);
    } catch (e) {
      Log().severe(e);
    }
  }
}

class AppScope extends BaseLoyaltyScope<AppScope> {
  AppScope();

  var id;
  String? sku;
  String? code;
  String? description;

  String? inviteLink;
  String? apiUrl;
  String? apiClientId;
  String? apiClientSecret;
  bool? allowsTabletAccess;
  DateTime? createdAt;
  DateTime? updatedAt;
  var pure = {};

  @override
  void set(State state, Map<String, dynamic> json) {
    pure = json;
    dataOf(() => DataScope().set(state, json["data"]));
    id = json["id"]??1;
    sku = stringOf(() => json["sku"]);
    code = stringOf(() => json["code"]);
    description = stringOf(() => json["description"]);
    inviteLink = stringOf(() => json["invite_link"]);
    allowsTabletAccess = boolOf(() => json["allows_tablet_access"]);
    createdAt = dataOf<DateTime>(() => DateTime.parse(json["created_at"]));
    updatedAt = dataOf<DateTime>(() => DateTime.parse(json["updated_at"]));
  }
}

class DataScope extends BaseLoyaltyScope<DataScope> {
  static DataScope? _i;
  List<String> alias = [];

  DataScope._();

  factory DataScope() {
    if (_i == null) _i = DataScope._();
    return _i!;
  }

  @override
  void set(State state, Map<String, dynamic> json) {
    _i = DataScope._();
    dataOf(() => PackageManager().onDataScopeChanged!(state, json));
    dataOf(() => LoyaltyScope().set(state, json["loyalty"]));
    _i?.alias = dataOf(
        () => listFrom(json["apis"], [])
            .map((e) => e["name"].toString())
            .toList(),
        _i!.alias) as List<String>;
  }
}
