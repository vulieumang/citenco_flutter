// To parse this JSON data, do
//
//     final lgoin = lgoinFromJson(jsonString);

import 'dart:convert';

Lgoin lgoinFromJson(String str) => Lgoin.fromJson(json.decode(str));

String lgoinToJson(Lgoin data) => json.encode(data.toJson());

class Lgoin {
  Lgoin({
    this.data,
  });

  LgoinData? data;

  factory Lgoin.fromJson(Map<String, dynamic> json) => Lgoin(
        data: json["data"] == null ? null : LgoinData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class LgoinData {
  LgoinData({
    this.code,
    this.message,
    this.description,
    this.error,
    this.data,
  });

  int? code;
  String? message;
  String? description;
  String? error;
  DataData? data;

  factory LgoinData.fromJson(Map<String, dynamic> json) => LgoinData(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        description: json["description"] == null ? null : json["description"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "description": description == null ? null : description,
        "error": error == null ? null : error,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataData {
  DataData({
    this.userId,
    this.fullName,
    this.stationId,
    this.permissions,
    this.token,
    this.refreshToken,
  });

  int? userId;
  String? fullName;
  int? stationId;
  List<String>? permissions;
  String? token;
  String? refreshToken;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        userId: json["userId"] == null ? null : json["userId"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        stationId: json["stationId"] == null ? null : json["stationId"],
        permissions: json["permissions"] == null
            ? null
            : List<String>.from(json["permissions"].map((x) => x)),
        token: json["token"] == null ? null : json["token"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "fullName": fullName == null ? null : fullName,
        "stationId": stationId == null ? null : stationId,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x)),
        "token": token == null ? null : token,
        "refreshToken": refreshToken == null ? null : refreshToken,
      };
}
