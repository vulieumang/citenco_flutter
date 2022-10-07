class TokenRequest {
  final String? phone;
  final String? accountDomainName;
  final String? deviceId;
  var customerId;
  final String? loginToken;
  final String? googleId;
  final String? appleId;

  TokenRequest(
      {required this.phone,
      required this.accountDomainName,
      required this.deviceId,
      this.googleId,
      this.appleId,
      this.customerId,
      this.loginToken});

  factory TokenRequest.fromJson(json) {
    return TokenRequest(
        phone: json["phone"],
        googleId: json["google_id"],
        appleId: json["apple_id"],
        accountDomainName: json["account_domain_name"],
        deviceId: json["device_id"]);
  }

  Map toJson() {
    return {
      "phone": phone,
      "account_domain_name": accountDomainName,
      "device_id": deviceId,
      "google_id": googleId,
      "apple_id": appleId,
    };
  }

  Map toJsonAutoLogin() {
    return {
      "phone": phone,
      "account_domain_name": accountDomainName,
      "device_id": deviceId,
      "contact_id": customerId,
      "login_token": loginToken,
      "google_id": googleId,
      "apple_id": appleId,
    };
  }
}
