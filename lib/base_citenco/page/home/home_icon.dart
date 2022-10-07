import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/translation.dart';
import 'package:cnvsoft/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeIcon {
  dynamic pure;

  final String? asset;
  final String? name;
  final void Function()? onTap;
  final bool? fillColor;
  final Color? color;
  final Color? textColor;
  final dynamic hidden;
  final double? iconSize;
  String? off = "";
  final String? versionHide;
  final String? versionShow;

  HomeIcon(
      {this.pure,
      this.hidden,
      required this.asset,
      this.color,
      this.iconSize,
      this.off,
      this.versionHide,
      this.versionShow,
      required this.textColor,
      required this.name,
      required this.onTap,
      required this.fillColor});

  factory HomeIcon.fromJson(json) {
    dynamic hidden = json["hidden"];
    bool fillColor = BasePKG().boolOf(() => json["fill"]);
    double size = BasePKG().doubleOf(() => json["size"] * 1.0, 44.0);
    String asset = BasePKG().stringOf(() => json["asset"]);
    Color? textColor;
    if (json["text_color_value"] == null)
      textColor =
          BasePKG().dataOf(() => Color(int.parse("0xff" + json["text_color"])));
    else
      textColor = BasePKG().dataOf(() => Color(json["text_color_value"]));

    Color? color;
    if (json["color_value"] == null)
      color = BasePKG().dataOf(() => Color(int.parse("0xff" + json["color"])));
    else
      color = BasePKG().dataOf(() => Color(json["color_value"]));

    dynamic name = BasePKG().dataOf(() => json["name"], "");
    String navigate = BasePKG().stringOf(() => json["navigate"]);
    String action = BasePKG().stringOf(() => json["action"]);
    String off = BasePKG().stringOf(() => json["off"]);
    String versionShow = BasePKG().stringOf(() => json["version_show"]);
    String versionHide = BasePKG().stringOf(() => json["version_hide"]);
    bool authenLogin = BasePKG().boolOf(() => json["authen"] == "login");
    bool authenPhone = BasePKG().boolOf(() => json["authen"] == "phone");
    dynamic payload = BasePKG().dataOf(() => json["payload"]);

    var onTap = () => BasePKG()
        .bus!
        .fire<DashboardData>(DashboardData("dashboard_action", data: {
          "navigate": navigate,
          "action": action,
          "authenLogin": authenLogin,
          "authenPhone": authenPhone,
          "payload": payload,
        }));

    return HomeIcon.fromServer(
        pure: json,
        color: color,
        asset: asset,
        name: name,
        hidden: hidden,
        onTap: onTap,
        size: size,
        off: off,
        versionShow: versionShow,
        versionHide: versionHide,
        fillColor: fillColor,
        textColor: textColor);
  }

  factory HomeIcon.multiColor(
    State state, {
    required String asset,
    required String name,
    required void Function() onTap,
    bool? authenLogin,
    double? iconSize,
    dynamic hidden,
    bool? authenPhone,
    Color? textColor,
  }) {
    void Function()? _onTap = onTap;
    if (authenLogin ?? false) {
      _onTap = () => MyProfile().loginAuthentic(state, onTap);
    }
    if (authenPhone ?? false) {
      _onTap = () => MyProfile().phoneAuthentic(state, onTap);
    }
    return HomeIcon(
        hidden: hidden,
        textColor: textColor ?? BasePKG().color.text,
        asset: asset,
        name:   Utils.upperCaseFullFirst(name),
        onTap: _onTap,
        iconSize: iconSize,
        fillColor: false);
  }

  factory HomeIcon.fromServer({
    pure,
    required String asset,
    required dynamic name,
    required Function() onTap,
    Color? color,
    dynamic hidden,
    double? size,
    String? off,
    Color? textColor,
    bool? fillColor,
    required String versionShow,
    required String versionHide,
  }) {
    void Function() _onTap = onTap;
    String _name =
        name is Map ? Translations().translate(name) : name.toString();
    return HomeIcon(
        pure: pure,
        hidden: hidden,
        color: color,
        textColor: textColor ?? BasePKG().color.text,
        asset: asset,
        iconSize: size,
        off: off,
        versionShow: versionShow,
        versionHide: versionHide,
        name:  Utils.upperCaseFullFirst(_name),
        onTap: _onTap,
        fillColor: fillColor ?? false);
  }

  factory HomeIcon.primaryColor(
    State state, {
    required String asset,
    required String name,
    required Function() onTap,
    bool? authenLogin,
    dynamic hidden,
    double? iconSize,
    bool? authenPhone,
    Color? textColor,
  }) {
    void Function() _onTap = onTap;
    if (authenLogin ?? false) {
      _onTap = () => MyProfile().loginAuthentic(state, onTap);
    }
    if (authenPhone ?? false) {
      _onTap = () => MyProfile().phoneAuthentic(state, onTap);
    }
    return HomeIcon(
        hidden: hidden,
        textColor: textColor ?? BasePKG().color.text,
        asset: asset,
        iconSize: iconSize,
        name: Utils.upperCaseFullFirst(name),
        onTap: _onTap,
        fillColor: true);
  }

  bool get isLiveOff => off == "live";

  bool get isReviewOff => off == "review";

  bool inVisible(State state) {
    bool hidden = BasePKG().boolOf(
        () => this.hidden,
        BasePKG().boolOf(() {
          int version =
              int.parse(PackageManager().deviceVersion.replaceAll(".", ""));
          bool isEquals = BasePKG().boolOf(
              () => version == int.parse(this.hidden["="].replaceAll(".", "")));
          bool isGreater = BasePKG().boolOf(
              () => version > int.parse(this.hidden[">"].replaceAll(".", "")));
          bool isLess = BasePKG().boolOf(
              () => version < int.parse(this.hidden["<"].replaceAll(".", "")));
          return isEquals || isGreater || isLess;
        }));

    if (hidden) return true;
    if (isLiveOff) return PackageManager().onlyInLiveVersion(state, true);
    if (isReviewOff) return PackageManager().onlyInReviewVersion(state);
    try {
      String deviceVersion = PackageManager().deviceVersion.split(".").join("");
      int version = int.tryParse(deviceVersion) ?? -1;
      if (version != -1) {
        if (versionHide != null && versionHide!.isNotEmpty) {
          if (versionHide!.startsWith(">") || versionHide!.startsWith("<")) {
            String _version = versionHide!.substring(1).split(".").join("");
            int hide = int.tryParse(_version) ?? -1;
            bool gt = version > hide && versionHide!.startsWith(">");
            bool lt = version < hide && versionHide!.startsWith("<");
            if (hide != -1 && (gt || lt)) return true;
          } else {
            String _version = versionHide!.split(".").join("");
            int hide = int.tryParse(_version) ?? -1;
            if (hide != -1 && version == hide) return true;
          }
        }
        if (versionShow != null && versionShow!.isNotEmpty) {
          if (versionShow!.startsWith(">") || versionShow!.startsWith("<")) {
            String _version = versionShow!.substring(1).split(".").join("");
            int show = int.tryParse(_version) ?? -1;
            bool gt = version > show && versionShow!.startsWith(">");
            bool lt = version < show && versionShow!.startsWith("<");
            if (show != -1 && (gt || lt)) return false;
          } else {
            String _version = versionShow!.split(".").join("");
            int show = int.tryParse(_version) ?? -1;
            if (show != -1 && version == show) return false;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Widget buildIcon(double size, {bool isFill = false}) {
    double _size = size;
    if (this.iconSize != null && this.iconSize! > 0) _size = this.iconSize!;
    return GestureDetector(
      child: Center(
        child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: asset!.startsWith("http")
                ? _buildNetworkIcon(49,isFill:isFill)
                : _buildAssetIcon(49)),
      ),
      onTap: onTap,
    );
  }

  Widget _buildNetworkIcon(double size,{bool isFill = false}) {
    return asset!.endsWith(".svg")
        ? _buildSVGIcon(size, network: true)
        : _buildPNGIcon(size, network: true);
  }

  Widget _buildAssetIcon(double size) {
    return asset!.endsWith(".svg") ? _buildSVGIcon(size) : _buildPNGIcon(size);
  }

  Color? get _iconColor =>
      color ?? (asset!.endsWith(".svg") ? BasePKG().color.primaryColor : null);

  Widget _buildSVGIcon(double size, {bool network: false}) {
    return network
        ? FadeInImageView.fromSize(
            asset!,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: _iconColor!,
          )
        : SvgPicture.asset(
            asset!,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: _iconColor,
          );
  }

  Widget _buildPNGIcon(double size, {bool network: false ,bool isFill = false}) {
    return network
        ? FadeInImageView.fromSize(
            asset!,
            width: size,
            height: size,
            fit: BoxFit.scaleDown,
            color: isFill ? _iconColor : null,
          )
        : Image.asset(
            asset!,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: _iconColor,
          );
  }
}
