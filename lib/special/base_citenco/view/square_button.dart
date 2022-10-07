import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

enum IsSafeArea { Default, SafeArea }
enum SquareButtonStyle { Radius, Stadium }

class SquareButton extends StatelessWidget {
  final IsSafeArea? type;
  final Widget? icon;
  final String? text;
  final EdgeInsets? padding;
  final EdgeInsets? paddingText;
  final EdgeInsets? margin;
  final ThemeData? theme;
  final double? radius;
  final Function()? onTap;
  final List<BoxShadow>? shadow;
  final Widget? child;

  const SquareButton(
      {Key? key,
      this.text,
      this.padding,
      this.paddingText,
      this.margin,
      this.theme,
      this.onTap,
      this.radius,
      this.icon,
      this.type,
      this.shadow,
      this.child})
      : super(key: key);

  factory SquareButton.safeArea({
    Widget? icon,
    String? text,
    EdgeInsets? padding,
    EdgeInsets? margin,
    ThemeData? theme,
    double? radius,
    Function()? onTap,
    Widget? child,
  }) =>
      SquareButton(
        type: IsSafeArea.SafeArea,
        onTap: onTap,
        text: text,
        padding: padding,
        margin: margin,
        theme: theme,
        radius: radius,
        icon: icon,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IsSafeArea.SafeArea:
        return SafeArea(child: button(context));
      default:
        return button(context);
    }
  }

  BorderRadius getRadius() {
    var _radius = this.radius ?? 4;
    var radius = BorderRadius.circular(_radius);
    return radius;
  }

  Color getBoderColor(BuildContext context) {
    var theme = getTheme(context);
    return theme.canvasColor;
  }

  Color? getBackgroundColor(BuildContext context) {
    var theme = getTheme(context);
    if (theme.buttonColor == BasePKG().color.primaryColor) {
      return BasePKG().dataOf(
          () => BasePKG().decoration!.primaryDecoration().color,
          theme.buttonColor);
    } else {
      return theme.buttonColor;
    }
  }

  BoxBorder getBoxBorder(BuildContext context) {
    var theme = getTheme(context);
    if (theme.buttonColor == BasePKG().color.primaryColor) {
      return BasePKG().decoration!.primaryDecoration().border!;
    } else {
      return Border.all(color: theme.canvasColor,width: 0.5);
    }
  }

  BoxDecoration getDecoration(BuildContext context) {
    var theme = getTheme(context);
    if (theme.buttonColor == BasePKG().color.primaryColor) {
      return BasePKG().decoration!.primaryDecoration(
          shadow: shadow,
          radius: getRadius(),
          borderColor: getBoderColor(context));
    } else {
      return BoxDecoration(
          boxShadow: shadow,
          borderRadius: getRadius(),
          color: getBackgroundColor(context),
          border: getBoxBorder(context));
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    return getTheme(context).textTheme.button!;
  }

  ThemeData getTheme(BuildContext context) {
    return this.theme ?? Theme.of(context);
  }

  bool isStadium() {
    return BasePKG().buttonStyle == SquareButtonStyle.Stadium;
  }

  Widget button(BuildContext context) {
    return Padding(
      padding: margin ?? BasePKG().symmetric(horizontal: 20, vertical: 10),
      child: isStadium()
          ? _buildStadiumButton(context)
          : Container(
              decoration: getDecoration(context),
              alignment: Alignment.center,
              child: Material(
                borderRadius: getRadius(),
                color: getBackgroundColor(context),
                child: InkWell(onTap: onTap, child: _innerButton(context)),
              )),
    );
  }

  Widget _buildStadiumButton(BuildContext context) {
    Color _borderColor = getBoderColor(context);
    Color? _backgroundColor = getBackgroundColor(context);
    return Material(
      color: _borderColor,
      shape: StadiumBorder(),
      child: Container(
        padding: EdgeInsets.all(1.0),
        child: InkWell(
            child: Material(
          shape: StadiumBorder(),
          color: _backgroundColor,
          child: InkWell(
            child: _innerButton(context),
            onTap: onTap,
            highlightColor: _backgroundColor?.withOpacity(0.2),
            customBorder: StadiumBorder(),
          ),
        )),
      ),
    );
  }

  Widget _innerButton(BuildContext context) {
    return Padding(
        padding: padding ?? BasePKG().symmetric(horizontal: 20, vertical: 18),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon ?? SizedBox(),
                Padding(
                  padding: paddingText ?? EdgeInsets.zero,
                  child: Text(text!, style: getTextStyle(context)),
                ),
              ],
            ));
  }
}
