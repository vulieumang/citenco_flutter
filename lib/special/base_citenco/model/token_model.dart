import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';

// class TokenModel extends BaseModel {
//   TokenModel({
//     this.tokenType,
//     this.accessToken,
//   });

//   String tokenType;
//   String accessToken;

//   factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
//       tokenType: BasePKG().stringOf(() => json["token_type"]),
//       accessToken: BasePKG().stringOf(() => json["access_token"]));

//   Map<String, dynamic> toJson() => {
//         "token_type": tokenType,
//         "access_token": accessToken,
//       };
// }

// {"data":{"verified":true,"contact_id":16823,"api_token":"60a241b85dca240001609a83","login_token":"60a241b85dca240001609a82"}}

class TokenModel extends BaseModel {
  TokenModel({
    this.verified,
    this.customerId,
    this.accessToken,
    this.loginToken,
  });

  bool? verified;
  var customerId;
  String? accessToken;
  String? loginToken;

  TokenModel.fromJson(Map<String, dynamic> json) {
    json = json["data"] ?? {};
    verified = BasePKG().boolOf(() => json["verified"]);
    customerId = json["contact_id"];
    accessToken = json["api_token"];
    loginToken = json["login_token"];
  }

  Map<String, dynamic> toJson() => {
        "data": {
          "verified": verified,
          "contact_id": customerId,
          "api_token": accessToken,
          "login_token": loginToken,
        }
      };
}
