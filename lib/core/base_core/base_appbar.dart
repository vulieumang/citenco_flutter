import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarData {
  final BuildContext context;
  String? text;
  final Widget? title;
  final bool? backArrow;
  final Widget? flexibleSpace;
  final Widget? leading;
  final Function()? onBack;
  final List<Widget>? actions;
  Color? backgroundColor;
  final Color? color;
  final double? evelation;
  final double? height;
  final SystemUiOverlayStyle? systemOverlayStyle;
  double radius;

  AppBarData(this.context,
      {this.title,
      this.actions,
      this.backgroundColor,
      this.color,
      String? text,
      this.backArrow,
      this.leading,
      this.onBack,
      this.systemOverlayStyle,
      this.flexibleSpace,
      this.radius = 30,
      this.height = 70,
      this.evelation})
      : text = text ?? "";

  factory AppBarData.backArrow(BuildContext context,
      {Widget? title,
      String? text,
      Widget? leading,
      Color? backgroundColor,
      Color? color,
      Function()? onBack,
      List<Widget>? actions,
      SystemUiOverlayStyle? systemOverlayStyle,
      double? radius = 30,
      double? evelation}) {
    return AppBarData(context,
        backgroundColor: backgroundColor,
        text: text,
        title: title,
        backArrow: true,
        color: color,
        leading: leading,
        actions: actions,
        onBack: onBack,
        evelation: evelation,
        radius: radius!,
        systemOverlayStyle: systemOverlayStyle);
  }

  PreferredSizeWidget netWork() {
    AppBarData _appbar = AppBarData(context,
        backgroundColor: Colors.red,
        leading: Container(
            padding: BasePKG().symmetric(horizontal: 10),
            child: Image.asset("lib/core/asset/image/ic_netword.png",
                width: 10, height: 10)),
        backArrow: false,
        title: Container(
            alignment: Alignment.bottomLeft,
            child: Text(BaseTrans().$networdMessage,
                maxLines: 4,
                textAlign: TextAlign.start,
                style: BasePKG()
                    .text!
                    .smallLowerNormal()
                    .copyWith(color: Colors.white))));
    return _appbar.parse();
  }

  PreferredSizeWidget parse() {
    LinearGradient gradient;
    List<BoxShadow> box = [
      BoxShadow(
          color: Color(0xff000000).withAlpha(6),
          blurRadius: 15,
          offset: Offset(0, 1))
    ];
    gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff031126),
          Color(0xff0F5A6B),
        ]);
    return PreferredSize(
      preferredSize: Size.fromHeight(radius == 0 ? 50 : height ?? 70.0),
      child: AppBar(
        flexibleSpace: flexibleSpace ?? Container(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius),
        )),
        backgroundColor: BasePKG().color.primaryColor,
        title: _initTitle(),
        leading: _initLeading(),
        centerTitle: true,
        primary: true,
        elevation: evelation ?? 0,
        actions: actions ?? [],
        // systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle(),
      ),
    );
  }

  Widget _initTitle() {
    var style = ModifyPKG()
        .text!
        .appBarTitle()
        .copyWith(color: BasePKG().color.colorTextHeader);
    if (color != null) style = style.copyWith(color: color);
    return title ?? Text(Utils.upperCaseFirst(text ?? ''), style: style);
  }

  Widget _initLeading() {
    return ModalRoute.of(context)?.settings.name! != "dash_board" &&
            ModalRoute.of(context)?.settings.name! != "login_page"
        ? BottonBack(onBack: onBack, context: context)
        : (leading ?? SizedBox());
  }
}

class BottonBack extends StatelessWidget {
  BottonBack({
    Key? key,
    this.onBack,
    required this.context,
  }) : super(key: key);

  Function()? onBack;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack ?? Navigator.of(context).pop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  "lib/base_citenco/asset/image/ic_arrow_left.svg",
                  height: 24,
                  width: 24,
                  color: BasePKG().color.iconColorPr,
                ),
                Text(
                  "Back",
                  style: BasePKG().text!.smallNormal().copyWith(
                        color: BasePKG().color.iconColorPr,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
