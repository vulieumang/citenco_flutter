import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldLabel extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final ThemeData? theme;
  final TextInputType? textInputType;
  final Function(String value)? onChanged;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final int? minLines;
  final int? maxLines;
  final bool? enable;
  final TextAlign? textAlign;
  final double? fontSize;
  final int? maxLength;
  final String? prefixText;
  final FocusNode? focusNode;
  final TextStyle? prefixStyle;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final String? hintText;
  final TextStyle? hintStyle;

  const TextFieldLabel(
      {Key? key,
      required this.controller,
      required this.label,
      required this.theme,
      this.textInputType: TextInputType.text,
      this.onChanged,
      this.padding,
      this.enable: true,
      this.margin,
      this.minLines,
      this.maxLines,
      this.textAlign,
      this.fontSize,
      this.maxLength,
      this.prefixText,
      this.focusNode,
      this.prefixStyle,
      this.textCapitalization,
      this.inputFormatters,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.hintText,
      this.hintStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = this.theme ?? Theme.of(context);
    var style = theme.textTheme.headline6;
    if (fontSize != null) style = style!.copyWith(fontSize: fontSize);
    return Padding(
      padding: margin ?? BasePKG().symmetric(vertical: 4),
      child: Theme(
        data: theme,
        child: TextField(
            obscureText: obscureText ?? false,
            focusNode: focusNode,
            maxLength: maxLength,
            textAlign: textAlign ?? TextAlign.left,
            enabled: enable,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? (minLines ?? 1),
            textAlignVertical: TextAlignVertical.top,
            cursorColor: theme.textSelectionTheme.cursorColor,
            onChanged: onChanged ?? (_) {},
            keyboardType: textInputType,
            controller: controller,
            style: style,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              prefixText: prefixText ?? "",
              prefixStyle: prefixStyle,
              hintText: hintText,
              hintStyle: hintStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: BasePKG().color.line),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: BasePKG().color.line),
              ),
              alignLabelWithHint: true,
              contentPadding: this.padding ?? BasePKG().symmetric(vertical: 10),
              labelText: label,
              labelStyle: theme.textTheme.subtitle2,
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixIconConstraints ??
                  BoxConstraints(minHeight: 32, minWidth: 32),
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixIconConstraints ??
                  BoxConstraints(minHeight: 32, minWidth: 32),
            ),
            textCapitalization: textCapitalization ?? TextCapitalization.none),
      ),
    );
  }
}
