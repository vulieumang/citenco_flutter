import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'square_button.dart';

enum BottomButtonViewType { Default, FullWidth }

class BottomButtonView extends StatelessWidget {
  final String text;
  final Function() onTap;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final BottomButtonViewType? type;
  final Color? color;
  final ThemeData? theme;
  final bool? isSafeArea;

  const BottomButtonView(
      {Key? key,
      required this.text,
      required this.onTap,
      this.padding,
      this.type = BottomButtonViewType.Default,
      this.color,
      this.theme,
      this.isSafeArea = true,
      this.contentPadding})
      : super(key: key);

  factory BottomButtonView.fullWidth(
      {required String text,
      required Function() onTap,
      BottomButtonViewType type = BottomButtonViewType.FullWidth,
      ThemeData? theme,
      EdgeInsets? contentPadding,
      EdgeInsets? padding}) {
    return BottomButtonView(
      text: text,
      onTap: onTap,
      type: type,
      theme: theme,
      contentPadding: contentPadding,
      padding: padding,
    );
  }

  factory BottomButtonView.normal(
      {required String text,
      required Function() onTap,
      BottomButtonViewType? type = BottomButtonViewType.Default,
      EdgeInsets? padding}) {
    return BottomButtonView(
      text: text,
      onTap: onTap,
      type: type,
      padding: padding,
      isSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isDefault = type == BottomButtonViewType.Default;
    EdgeInsets _padding = padding ??
        (_isDefault
            ? BasePKG().symmetric(vertical: 12, horizontal: 16)
            : BasePKG().zero);
    EdgeInsets _contentPadding = contentPadding ??
        (_isDefault
            ? BasePKG().symmetric(vertical: 14)
            : BasePKG().symmetric(horizontal: 4, vertical: 18));
    return Container(
        color: color ?? BasePKG().color.card,
        padding: _padding,
        child: isSafeArea!
            ? SquareButton.safeArea(
                padding: _contentPadding,
                margin: BasePKG().zero,
                theme: theme ?? BasePKG().button!.primaryButton(context),
                text: text,
                radius: _isDefault ? 4 : 0,
                onTap: onTap)
            : SquareButton(
                padding: _contentPadding,
                margin: BasePKG().zero,
                theme: theme ?? BasePKG().button!.primaryButton(context),
                text: text,
                radius: _isDefault ? 4 : 0,
                onTap: onTap));
  }
}
