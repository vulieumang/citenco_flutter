import 'package:cnvsoft/special/base_citenco/package/package.dart';

class BottomMenuIcon {
  final String? asset;
  final String? assetActive;
  final int? index;
  final String? name;
  final Function()? onTap;
  final bool? hidden;
  final bool? fillColor;

  BottomMenuIcon(this.index,
      {required this.name,
      this.fillColor,
      this.hidden,
      required this.asset,
      required this.assetActive,
      required this.onTap});

  factory BottomMenuIcon.fromJson(dynamic json) {
    String asset = BasePKG().stringOf(() => json["asset"]);
    String assetActive = BasePKG().stringOf(() => json["assetActive"]);
    bool fillColor = BasePKG().boolOf(() => json["fill"]);
    String name = BasePKG().stringOf(() => json["name"]);
    String navigate = BasePKG().stringOf(() => json["navigate"]);
    String action = BasePKG().stringOf(() => json["action"]);
    String authenLogin = BasePKG().stringOf(() => json["authen_login"]);
    String authenPhone = BasePKG().stringOf(() => json["authen_phone"]);
    dynamic payload = BasePKG().dataOf(() => json["payload"]);
    int index = BasePKG().intOf(() => json["index"], -1);
    bool hidden = BasePKG().boolOf(() => json["hidden"]);
    var onTap = () => BasePKG()
        .bus!
        .fire<DashboardData>(DashboardData("dashboard_action", data: {
          "navigate": navigate,
          "action": action,
          "authenLogin": authenLogin,
          "authenPhone": authenPhone,
          "payload": payload,
          "index": index,
        }));
    return BottomMenuIcon(index,
        asset: asset,
        name: name,
        onTap: onTap,
        hidden: hidden,
        assetActive: assetActive,
        fillColor: fillColor);
  }
}
