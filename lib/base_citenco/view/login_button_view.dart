import 'dart:io';

import 'package:cnvsoft/base_citenco/package/color_style.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum LoginType { Facebook, Apple, Google }

class LoginButtonGesture {
  final LoginType type;
  final Function() onTap;

  LoginButtonGesture({required this.type, required this.onTap});
}

class LoginButtonView extends StatelessWidget {
  final bool visiblePrivacy;
  final List<LoginButtonGesture> gestures;

  LoginButtonView(
      {Key? key, required this.gestures, required this.visiblePrivacy});

  EdgeInsets get margin => EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  EdgeInsets get padding => EdgeInsets.symmetric(horizontal: 12, vertical: 14);

  bool get existApple =>
      this.gestures.isNotEmpty && this.gestures.first.type == LoginType.Apple;

  @override
  Widget build(BuildContext context) {
    List<LoginButtonGesture> gestures = (this.gestures)
        .where((element) => element.type != LoginType.Apple)
        .toList();

    return Column(children: <Widget>[
      SizedBox(height: BasePKG().convert(5)),
      SquareButton(
        padding: padding,
        text: BaseTrans().$loginByPhoneNumber,
        theme: BasePKG().button!.loginButton(context),
        radius: 2,
        margin: margin,
        onTap: () async {
          if (visiblePrivacy) {
            var result = await Navigator.of(context)
                .pushNamed("privacy_page", arguments: {"is_login": true});
            if (result == true) Navigator.of(context).pushNamed("login_phone");
          } else {
            Navigator.of(context).pushNamed("login_phone");
          }
        },
      ),
      if (existApple && Platform.isIOS) ...[
        _buildVerticalButton(context, this.gestures.first)
      ],
      if (gestures.isNotEmpty) ...[
        Column(
          children: <Widget>[
            Padding(
              padding: BasePKG().only(top: 12, bottom: 20),
              child: Text(BaseTrans().$socialLogin,
                  style: BasePKG().text!.description()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: gestures
                  .map((e) => _buildHorizontalButton(context, e))
                  .toList(),
            )
          ],
        )
      ]
    ]);
  }

  Widget _buildVerticalButton(BuildContext context, LoginButtonGesture e) {
    return Padding(
      padding: BasePKG().symmetric(vertical: 5),
      child: _buildButton(context, e),
    );
  }

  Widget _buildHorizontalButton(BuildContext context, LoginButtonGesture e) {
    return Padding(
      padding: BasePKG().all(10),
      child: _buildIcon(
        context,
        e,
      ),
    );
  }

  Widget _buildButton(BuildContext context, LoginButtonGesture e) {
    switch (e.type) {
      case LoginType.Facebook:
        return SquareButton(
          margin: margin,
          padding: padding,
          icon: Padding(
            padding: BasePKG().symmetric(horizontal: 5),
            child: ColorStyle.invertColor
                ? SvgPicture.asset(
                    "lib/special/base_citenco/asset/image/fbIcon.svg",
                    height: 18,
                    color: BasePKG().color.facebook,
                  )
                : Image.asset(
                    "lib/special/base_citenco/asset/image/fbIcon.png",
                    height: 14,
                  ),
          ),
          text: BaseTrans().$loginByFacebook,
          theme: BasePKG().button!.facebookButton(context),
          onTap: e.onTap,
        );
      case LoginType.Apple:
        return SquareButton(
          paddingText: EdgeInsets.only(top: 2),
          margin: margin,
          padding: padding,
          onTap: e.onTap,
          radius: 2,
          icon: Padding(
            padding: BasePKG().symmetric(horizontal: 5),
            child: Image.asset(
              "lib/special/base_citenco/asset/image/appleIcon.png",
              height: 20,
              color: BasePKG()
                  .button!
                  .appleButton(context)
                  .textTheme
                  .button!
                  .color,
            ),
          ),
          text: BaseTrans().$loginByApple,
          theme: BasePKG().button!.appleButton(context),
        );
      case LoginType.Google:
        return SquareButton(
          margin: margin,
          padding: padding,
          onTap: e.onTap,
          icon: Padding(
            padding: BasePKG().symmetric(horizontal: 5),
            child: SvgPicture.asset(
              "lib/special/base_citenco/asset/image/google_logo.svg",
              height: 14,
            ),
          ),
          text: BaseTrans().$loginByApple,
          theme: BasePKG().button!.googleButton(context),
        );
      default:
        return SizedBox();
    }
  }

  Widget _buildIcon(BuildContext context, LoginButtonGesture e) {
    Color? color;
    Color? background;
    String asset = "";

    switch (e.type) {
      case LoginType.Facebook:
        color = Colors.white;
        background = BasePKG().color.facebook;
        asset = "facebook";
        break;
      case LoginType.Apple:
        color = ColorStyle.invertColor ? Colors.black : Colors.white;
        background = ColorStyle.invertColor ? Colors.white : Colors.black;
        asset = "apple";
        break;
      case LoginType.Google:
        background = Colors.white;
        asset = "google";
        break;
      default:
        break;
    }
    double _height = 44;
    double _width = 44;
    double _radius = 4;
    double _padding = 10;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: _height,
        width: _width,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(_radius),
            child: Container(
              padding: BasePKG().all(_padding),
              child: Center(
                child: SvgPicture.asset(
                  "lib/special/base_citenco/asset/image/${asset}_logo.svg",
                  color: color,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            onTap: e.onTap,
          ),
        ));
  }
}
