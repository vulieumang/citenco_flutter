import 'dart:math';

import 'package:cnvsoft/core/base_core/base_model.dart'; 
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart'; 
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class Profile extends BaseModel with DataMix {
  var customerId;

  // var id;
  String? uid;
  String? fbid;
  String? firstName;
  String? lastName;

  String? name;
  String? email;
  String? myPhone;
  int? gender;
  DateTime? dob;
  String? avatarUrl; 
  EcommerceInfo? ecommerce;
  String? createdAt;
  String? updatedAt;
  int? point;
  int? pointUsable; 
  String?
      countryCode; // lúc đăng nhập .NET chưa có phần gửi lên country code => sau này cần sử dụng thì request thêm phần gửi country code ở api login và auto login
  String? facebookId;
  String? googleId;
  String? appleId;
  var typeID;
  String? typeName;
  List<CustomFields>? customFields;
  Map<String, dynamic>? customFieldData;
  double? mapLatitude;
  double? mapLongitude;

  bool? isGuest;
  bool? mobileDeleted;

  DateTime? get birthday => dob == null ? null : dob!.toLocal();

  String get fullName => stringOf(
      () => name,
      stringOf(() => (lastName ?? "") + " ") + stringOf(() => firstName),
      [""]).trim();

  Profile(
      {this.customerId,
      this.uid,
      this.fbid,
      this.isGuest,
      this.firstName,
      this.lastName,
      this.email,
      this.myPhone,
      this.gender,
      this.dob,
      this.avatarUrl,
      this.name,
      // this.company,
      // this.addressLine1,
      // this.addressLine2,
      // this.countryId,
      // this.provinceId,
      // this.districtId,
      // this.address,
      // this.wardId,
      // this.postalCode,
      this.ecommerce,
      this.createdAt,
      this.updatedAt,
      this.point,
      this.pointUsable,
      this.googleId,
      this.facebookId,
      this.appleId,
      this.countryCode,
      this.mapLatitude,
      this.mapLongitude,
      this.typeID,
      this.mobileDeleted,
      this.typeName});

  factory Profile.init() {
    return Profile(
        // customerId: 1,
        isGuest: false,
        avatarUrl: "",
        myPhone: "",
        email: "",
        firstName: "",
        lastName: "",
        name: "",
        countryCode: "", 
        point: 0,
        pointUsable: 0);
  }

  Profile.from(Profile? profile,  
      int? point, int? pointUsable, ) {
    isGuest = false;
    customerId = BasePKG().dataOf(() => profile?.customerId);
    uid = BasePKG().dataOf(() => profile?.uid);
    fbid = BasePKG().dataOf(() => profile?.fbid);
    firstName = BasePKG().stringOf(() => profile?.firstName);
    lastName = BasePKG().stringOf(() => profile?.lastName);
    email = BasePKG().stringOf(() => profile?.email);
    myPhone = BasePKG().stringOf(() => profile?.myPhone);
    gender = BasePKG().dataOf(() => profile?.gender);
    dob = BasePKG().dataOf(() => profile?.dob);
    avatarUrl = BasePKG().stringOf(() => profile?.avatarUrl); 
    name = profile?.name;
    mobileDeleted = profile?.mobileDeleted; 
    createdAt = BasePKG().stringOf(() => profile?.createdAt!);
    updatedAt = BasePKG().stringOf(() => profile?.updatedAt!);
    mapLatitude = BasePKG().doubleOf(() => profile?.mapLatitude!);
    mapLongitude = BasePKG().doubleOf(() => profile?.mapLongitude!); 
    this.point = BasePKG().intOf(() => point);
    this.pointUsable = BasePKG().intOf(() => pointUsable); 
    countryCode = BasePKG().stringOf(() => profile?.countryCode!);
    appleId = BasePKG().stringOf(() => profile?.appleId);
    facebookId = BasePKG().stringOf(() => profile?.facebookId);
    googleId = BasePKG().stringOf(() => profile?.googleId);
    typeID = profile?.typeID;
    typeName = BasePKG().stringOf(() => profile?.typeName);
    customFields = BasePKG().listOf(() => profile?.customFields);
    customFieldData = BasePKG().dataOf(() => profile?.customFieldData, {});
  }

  bool get isVerifiedPhone =>
      BasePKG().boolOf(() => myPhone?.isNotEmpty) &&
      (!myPhone!.startsWith("fb:") &&
          !myPhone!.startsWith("gg:") &&
          !myPhone!.startsWith("ap:"));

  String? get phone =>
      !isVerifiedPhone ? BaseTrans().$phoneNotVerified : myPhone;

  void setPhone(String phone) => myPhone = phone;

  Profile.fromJson(Map<String, dynamic> json) {
    json = json["data"] ?? {};
    isGuest = false;
    customerId = json['id'] ?? 0;
    uid = json['uid'] ?? '';
    fbid = json['fbid'] ?? '';
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    myPhone = json['phone'] ?? '';
    gender = json['gender'] ?? null;
    mobileDeleted = json['mobileDeleted'] ?? false;

    if (json['birthday'] != null) {
      if (json['birthday'].toString().contains(":")) {
        dob = DateTime.parse(json['birthday']);
      } else {
        dob = DateFormat("dd-MM-yyyy").parse(json['birthday']);
      }
    }

    avatarUrl = json['avatar'] ?? ''; 
    ecommerce =
        BasePKG().dataOf(() => EcommerceInfo.fromJson(json["ecommerce"]));
    name = json['name'] ?? ''; 
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    mapLatitude =
        BasePKG().doubleOf(() => json['map_latitude'].toDouble(), 0.0);
    mapLongitude =
        BasePKG().doubleOf(() => json['map_longitude'].toDouble(), 0.0);
    countryCode = json["company"];
    typeID = json["type_id"];
    typeName = BasePKG().stringOf(() => json["type_name"]);
    facebookId = BasePKG().stringOf(() => json['facebook_id']);
    googleId = BasePKG().stringOf(() => json['google_id']);
    appleId = BasePKG().stringOf(() => json['apple_id']);
    customFieldData = BasePKG().dataOf(() => json['custom_field_data'], {});
    if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {
        customFields!.add(new CustomFields.fromJson(
            v, dataOf(() => customFieldData![v["name"]])));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.customerId;
    data['uid'] = this.uid;
    data['fbid'] = this.fbid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.myPhone;
    data['gender'] = this.gender;
    data['mobileDeleted'] = this.mobileDeleted;
    if (this.dob != null) {
      data['birthday'] = BasePKG().stringOf(
          () => DateFormat("dd-MM-yyyy").format(this.dob ?? DateTime.now()));
    }
    data['avatar'] = this.avatarUrl; 
    if (this.ecommerce != null) {
      data['ecommerce'] = this.ecommerce!.toJson();
    }
    data['name'] = this.name;
    // data['company'] = this.company;
    // data['address_line_1'] = this.addressLine1;
    // data['address_line_2'] = this.addressLine2;
    // data['country_id'] = this.countryId;
    // data['province_id'] = this.provinceId;
    // data['district_id'] = this.districtId;
    // data['province'] = this.province;
    // data['district'] = this.district;
    // data['ward'] = this.ward;
    // data['address'] = this.address;
    // data['full_address'] = this.fullAddress;
    // data['ward_id'] = this.wardId;
    // data['postal_code'] = this.postalCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_code'] = this.countryCode;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    data['apple_id'] = this.appleId;
    data['type_id'] = this.typeID;
    data['map_latitude'] = this.mapLatitude;
    data['map_longitude'] = this.mapLongitude;
    data['type_name'] = this.typeName;

    if (this.customFields != null) {
      data['custom_fields'] =
          this.customFields!.map((v) => v.toJson()).toList();
    }
    if (this.customFieldData != null) {
      data['custom_field_data'] = this.customFieldData;
    }
    return data;
  } 

  factory Profile.guest() {
    return Profile(
        isGuest: true,
        customerId: null,
        avatarUrl: "",
        countryCode: "",
        myPhone: "",
        email: "",
        name: "Guest",
        firstName: "Guest",
        lastName: "", 
        point: 0);
  }

  String get pointUsableFull => Utils.numberToCurrency(
      source: intOf(() => pointUsable!), currencySymbol: "");

  String get pointUsableFormatted => Utils.numberToCurrency(
      source: intOf(() => pointUsable!), currencySymbol: "");

  String getCustomFieldLable(String name) {
    return customFields!.firstWhere((element) => element.name == name).label!;
  }

  updateKeySocialId(String key, String id) {
    if (key == "google_id") {
      googleId = id;
    } else if (key == "facebook_id") {
      facebookId = id;
    } else if (key == "appple_id") {
      appleId = id;
    }
  }

  bool get hasLoginBySocial =>
      (stringOf(() => googleId!).isNotEmpty ||
          stringOf(() => facebookId!).isNotEmpty ||
          stringOf(() => appleId!).isNotEmpty) &&
      stringOf(() => phone!).allMatches("[0-9]{10}").isEmpty;
}

class CustomFields with DataMix {
  String? name;
  String? label;
  String? type;
  bool? isVisibe;
  TextEditingController? textEditingController;
  TextInputType? textInputType;
  dynamic value;

  CustomFields({this.name, this.label, this.type, this.isVisibe});

  CustomFields.fromJson(Map<String, dynamic> json, dynamic value) {
    print('name ${json['name']}');
    name = json['name'];
    print('label ${json['label']}');
    label = json['label'];
    print('type ${json['type']}');
    type = json['type'];
    print('is_visible ${json['is_visible']}');
    isVisibe = json['is_visible'];

    textInputType = getInpuType(type);
    this.value = value;
    textEditingController =
        TextEditingController(text: dataOf(() => value, "").toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['label'] = this.label;
    data['type'] = this.type;
    return data;
  }

  TextInputType getInpuType(String? type) {
    switch (type) {
      case "number":
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

class EcommerceInfo with DataMix {
  int? totalOrdersCount;
  int? totalOrdersAmount;
  DateTime? lastOrderDate;
  String? lastOrderNumber;
  int? lastOrderId;

  EcommerceInfo(
      {this.totalOrdersCount,
      this.totalOrdersAmount,
      this.lastOrderDate,
      this.lastOrderNumber,
      this.lastOrderId});

  EcommerceInfo.fromJson(Map<String, dynamic> json) {
    this.totalOrdersCount = json["totalOrdersCount"];
    this.totalOrdersAmount = json["totalOrdersAmount"];
    this.lastOrderDate =
        dataOf(() => DateTime.parse(json["lastOrderDate"]).toLocal());
    this.lastOrderNumber = json["lastOrderNumber"];
    this.lastOrderId = json["lastOrderId"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["totalOrdersCount"] = this.totalOrdersCount;
    json["totalOrdersAmount"] = this.totalOrdersAmount;
    json["lastOrderDate"] = dataOf(() => this.lastOrderDate!.toIso8601String());
    json["lastOrderNumber"] = this.lastOrderNumber;
    json["lastOrderId"] = this.lastOrderId;
    return json;
  }
}
