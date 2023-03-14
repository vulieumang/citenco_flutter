// To parse this JSON data, do
//
//     final dataScan = dataScanFromJson(jsonString);

import 'dart:convert';

import 'package:cnvsoft/core/base_core/base_model.dart';

DataScan dataScanFromJson(String str) => DataScan.fromJson(json.decode(str));

String dataScanToJson(DataScan data) => json.encode(data.toJson());

class DataScan extends BaseModel {
  DataScan({
    this.data,
  });

  DataScanData? data;

  factory DataScan.fromJson(Map<String, dynamic> json) => DataScan(
        data: json["data"] == null ? null : DataScanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class DataScanData {
  DataScanData({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  DataData? data;

  factory DataScanData.fromJson(Map<String, dynamic> json) => DataScanData(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataData {
  DataData(
      {this.vehicleId,
      this.vehicleType,
      this.vehicleLicensePlate,
      this.vehicleDriverName,
      this.vehicleVerifiedBy,
      this.vehicleCitencoId,
      this.vehicleLoad,
      this.dailyLimit,
      this.vehicleCollectionUnitId,
      this.vehicleCollectionUnitName,
      this.stationId,
      this.stationName,
      this.count,
      this.images,
      this.actionType,
      this.pendingHistoryId});

  int? vehicleId;
  String? vehicleType;
  String? vehicleLicensePlate;
  String? vehicleDriverName;
  String? vehicleVerifiedBy;
  String? vehicleCitencoId;
  String? pendingHistoryId;
  int? vehicleLoad;
  int? dailyLimit;
  int? vehicleCollectionUnitId;
  String? vehicleCollectionUnitName;
  int? stationId;
  String? stationName;
  int? count;
  int? actionType;
  List<ImageScan>? images;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
        vehicleType: json["vehicleType"] == null ? null : json["vehicleType"],
        vehicleLicensePlate: json["vehicleLicensePlate"] == null
            ? null
            : json["vehicleLicensePlate"],
        vehicleDriverName: json["vehicleDriverName"] == null
            ? null
            : json["vehicleDriverName"],
        vehicleVerifiedBy: json["vehicleVerifiedBy"] == null
            ? null
            : json["vehicleVerifiedBy"],
        vehicleCitencoId:
            json["vehicleCitencoId"] == null ? null : json["vehicleCitencoId"],
        vehicleLoad: json["vehicleLoad"] == null ? null : json["vehicleLoad"],
        dailyLimit: json["dailyLimit"] == null ? null : json["dailyLimit"],
        vehicleCollectionUnitId: json["vehicleCollectionUnitId"] == null
            ? null
            : json["vehicleCollectionUnitId"],
        vehicleCollectionUnitName: json["vehicleCollectionUnitName"] == null
            ? null
            : json["vehicleCollectionUnitName"],
        stationId: json["stationId"] == null ? null : json["stationId"],
        actionType: json["actionType"] == null ? null : json["actionType"],
        stationName: json["stationName"] == null ? null : json["stationName"],
        count: json["count"] == null ? null : json["count"],
        pendingHistoryId:
            json["pendingHistoryId"] == null ? null : json["pendingHistoryId"],
        images: json["images"] == null
            ? null
            : List<ImageScan>.from(
                json["images"].map((x) => ImageScan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId == null ? null : vehicleId,
        "vehicleType": vehicleType == null ? null : vehicleType,
        "vehicleLicensePlate":
            vehicleLicensePlate == null ? null : vehicleLicensePlate,
        "vehicleDriverName": vehicleDriverName == null ? "" : vehicleDriverName,
        "vehicleVerifiedBy":
            vehicleVerifiedBy == null ? null : vehicleVerifiedBy,
        "vehicleCitencoId": vehicleCitencoId == null ? null : vehicleCitencoId,
        "vehicleLoad": vehicleLoad == null ? null : vehicleLoad,
        "dailyLimit": dailyLimit == null ? null : dailyLimit,
        "vehicleCollectionUnitId":
            vehicleCollectionUnitId == null ? null : vehicleCollectionUnitId,
        "vehicleCollectionUnitName": vehicleCollectionUnitName == null
            ? null
            : vehicleCollectionUnitName,
        "stationId": stationId == null ? null : stationId,
        "actionType": actionType == null ? null : actionType,
        "stationName": stationName == null ? null : stationName,
        "pendingHistoryId": pendingHistoryId == null ? null : pendingHistoryId,
        "count": count == null ? null : count,
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class ImageScan {
  ImageScan({
    this.vehicleImageId,
    this.imagePath,
  });

  int? vehicleImageId;
  String? imagePath;

  factory ImageScan.fromJson(Map<String, dynamic> json) => ImageScan(
        vehicleImageId:
            json["vehicleImageId"] == null ? null : json["vehicleImageId"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleImageId": vehicleImageId == null ? null : vehicleImageId,
        "imagePath": imagePath == null ? null : imagePath,
      };
}
