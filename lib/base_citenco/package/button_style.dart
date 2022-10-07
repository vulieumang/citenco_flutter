import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

import 'color_style.dart';
import 'text_style.dart';

class BaseButton {
  static BaseButton? _internal;
  ThemeData? data;

  BaseButton._({ThemeData? data});

  factory BaseButton() {
    if (_internal == null) {
      _internal = BaseButton._(
          data: ThemeData.light().copyWith(
              accentColor: BasePKG().color.accentColor,
              primaryColor: BasePKG().color.primaryColor,
              appBarTheme: ThemeData.light()
                  .appBarTheme
                  .copyWith(color: BasePKG().color.accentColor)));
    }
    return _internal!;
  }

  ThemeData loginButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.backgroundLoginButton,
        backgroundColor: BasePKG().color.backgroundLoginButton,
        buttonColor: BasePKG().color.backgroundLoginButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 18,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: BasePKG().color.textLoginButton)));
  }

  ThemeData facebookButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.facebook,
        backgroundColor: BasePKG().color.facebookButtonBg,
        buttonColor: BasePKG().color.facebook,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 18,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: ColorStyle.invertColor
                    ? BasePKG().color.facebook
                    : Colors.white)));
  }

  ThemeData appleButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.apple,
        backgroundColor: BasePKG().color.apple,
        buttonColor: BasePKG().color.apple,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 18,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: BasePKG().color.appleText)));
  }

  ThemeData googleButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: Colors.grey,
        backgroundColor: Colors.white,
        buttonColor: Colors.white,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 18,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: Colors.black)));
  }

  ThemeData primaryButton(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      Color? backgroundColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor:
            backgroundColor ?? BasePKG().color.backgroundPrimaryButton,
        backgroundColor:
            backgroundColor ?? BasePKG().color.backgroundPrimaryButton,
        buttonColor:
            backgroundColor ?? BasePKG().color.backgroundPrimaryButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? BasePKG().color.colorTextHeader)));
  }

  ThemeData enableButton(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      Color? backgroundColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: backgroundColor ?? Color(0xff1B2228).withOpacity(0.8),
        backgroundColor: backgroundColor ?? Colors.white,
        buttonColor: backgroundColor ?? Colors.white,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? Color(0xff1B2228))));
  }

  ThemeData redButton(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      Color? backgroundColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: backgroundColor ?? Color(0xffB53B3B),
        backgroundColor: backgroundColor ?? Color(0xffB53B3B),
        buttonColor: backgroundColor ?? Color(0xffB53B3B),
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? Color(0xffffffff))));
  }

  ThemeData primaryDialogButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.backgroundPrimaryDialogButton ??
            BasePKG().color.backgroundPrimaryButton,
        backgroundColor: BasePKG().color.backgroundPrimaryDialogButton ??
            BasePKG().color.backgroundPrimaryButton,
        buttonColor: BasePKG().color.backgroundPrimaryDialogButton ??
            BasePKG().color.backgroundPrimaryButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: BasePKG().color.textPrimaryDialogButton ??
                    BasePKG().color.colorTextHeader)));
  }

  ThemeData alternativeButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var _textTheme = Theme.of(context).textTheme;
    color = color ?? BasePKG().color.textAlternaiveButton;
    return ThemeData(
        canvasColor: color,
        backgroundColor: BasePKG().color.backgroundAlternativeButton,
        buttonColor: BasePKG().color.backgroundAlternativeButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: color)));
  }

  ThemeData alternativeButton1(BuildContext context,
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var _textTheme = Theme.of(context).textTheme;
    color = color ?? BasePKG().color.textAlternaiveButton;
    return ThemeData(
        canvasColor: color,
        backgroundColor: BasePKG().color.background,
        buttonColor: BasePKG().color.background,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: color)));
  }

  ThemeData alternativeGreenButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.green,
        backgroundColor: BasePKG().color.backgroundAlternativeButton,
        buttonColor: BasePKG().color.backgroundAlternativeButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: BasePKG().color.green)));
  }

  ThemeData primaryLargeTextField(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        primaryColor: BasePKG().color.line,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: BasePKG().color.line),
        canvasColor: BasePKG().color.line,
        textTheme: _textTheme.copyWith(
          headline6: BaseText().valueLabel(),
          subtitle2: BaseText().label(),
        ));
  }

  ThemeData primaryTextField(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        primaryColor: BasePKG().color.line,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: BasePKG().color.line),
        canvasColor: BasePKG().color.line,
        textTheme: _textTheme.copyWith(
          headline6: BaseText().valueLabel().copyWith(height: 1.5),
          subtitle2: BaseText()
              .label()
              .copyWith(color: BasePKG().color.description),
        ));
  }

  ThemeData primaryEnableTextField(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        primaryColor: BasePKG().color.line,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: BasePKG().color.line),
        canvasColor: BasePKG().color.line,
        textTheme: _textTheme.copyWith(
          headline6: BaseText()
              .valueLabel()
              .copyWith(height: 1.5, color: BasePKG().color.hint),
          subtitle2: BaseText()
              .label()
              .copyWith(color: BasePKG().color.description),
        ));
  }

  ThemeData numberPhoneTextField(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        primaryColor: BasePKG().color.line,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: BasePKG().color.line),
        canvasColor: BasePKG().color.line,
        textTheme: _textTheme.copyWith(
          headline6: BaseText().valueLabel().copyWith(height: 1.5),
          subtitle2: BaseText()
              .label()
              .copyWith(color: BasePKG().color.description, fontSize: 12),
        ));
  }

  ThemeData negativeButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight, Color? textButtonColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.borderLineNegativeButton,
        backgroundColor: BasePKG().color.backgroundNegativeButton,
        buttonColor: BasePKG().color.backgroundNegativeButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textButtonColor ??
                    BasePKG().color.textNegativeButton)));
  }

  // ThemeData positiveButton(BuildContext context,
  //     {double fontSize, FontWeight fontWeight, Color textButtonColor}) {
  //   var _textTheme = Theme.of(context).textTheme;
  //   return ThemeData(
  //       canvasColor:BasePKG().color.backgroundPositiveButton,
  //       backgroundColor:BasePKG().color.backgroundPositiveButton,
  //       buttonColor:BasePKG().color.backgroundPositiveButton,
  //       textTheme: _textTheme.copyWith(
  //           button: _textTheme.button.copyWith(
  //               fontSize: fontSize ?? 15,
  //               fontWeight: fontWeight ?? FontWeight.w500,
  //               color: textButtonColor ??BasePKG().color.textPositiveButton)));
  // }

  ThemeData createButton(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      Color? background,
      Color? textColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: background ?? BasePKG().color.backgroundPrimaryButton,
        backgroundColor:
            background ?? BasePKG().color.backgroundPrimaryButton,
        buttonColor: background ?? BasePKG().color.backgroundPrimaryButton,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? BasePKG().color.textPrimaryButton)));
  }

  ThemeData disableButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight, Color? textColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.disable.withOpacity(0),
        backgroundColor: BasePKG().color.disable,
        buttonColor: BasePKG().color.disable,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? BasePKG().color.disableText)));
  }

  ThemeData completedButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: Colors.green,
        backgroundColor: Colors.green,
        buttonColor: Colors.green,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: BasePKG().color.textPrimaryButton)));
  }

  ThemeData youtubeButton(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.youtube,
        backgroundColor: BasePKG().color.youtube,
        buttonColor: BasePKG().color.youtube,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 18,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: ColorStyle.invertColor
                    ? BasePKG().color.youtube
                    : Colors.white)));
  }

  ThemeData dynamicButton(BuildContext context,
      {Color? canvasColor,
      Color? backgroundColor,
      Color? buttonColor,
      double? fontSize,
      FontWeight? fontWeight,
      Color? textColor}) {
    var _textTheme = Theme.of(context).textTheme;
    return ThemeData(
        canvasColor: BasePKG().color.disable.withOpacity(0),
        backgroundColor: BasePKG().color.disable,
        buttonColor: BasePKG().color.disable,
        textTheme: _textTheme.copyWith(
            button: _textTheme.button?.copyWith(
                fontSize: fontSize ?? 15,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? BasePKG().color.disableText)));
  }
}
