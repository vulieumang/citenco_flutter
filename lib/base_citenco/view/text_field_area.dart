import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldArea extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final ThemeData theme;
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
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final bool? isExpand;
  final Widget? suffix;

  TextFieldArea(
      {Key? key,
      required this.controller,
      this.label,
      required this.theme,
      this.textInputType: TextInputType.text,
      this.onChanged,
      this.padding,
      this.enable: true,
      this.hint,
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
      this.border,
      this.hintStyle,
      this.labelStyle,
      this.isExpand = false,
      this.inputFormatters,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = this.theme;
    var style = theme.textTheme.headline6;
    var _border = border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: BasePKG().color.line),
        );
    if (fontSize != null) style = style?.copyWith(fontSize: fontSize);
    return Padding(
      padding: margin ?? BasePKG().symmetric(vertical: 4),
      child: Theme(
        data: theme,
        child: TextField(
            focusNode: focusNode,
            maxLength: maxLength,
            textAlign: textAlign ?? TextAlign.left,
            enabled: enable,
            minLines: isExpand! ? null : minLines ?? 1,
            maxLines: isExpand! ? null : maxLines ?? (minLines ?? 1),
            textAlignVertical: TextAlignVertical.top,
            cursorColor: theme.textSelectionTheme.cursorColor,
            onChanged: onChanged ?? (_) {},
            keyboardType: textInputType,
            controller: controller,
            style: style,
            expands: isExpand!,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                prefixText: prefixText ?? "",
                prefixStyle: prefixStyle,
                enabledBorder: _border,
                focusedBorder: _border,
                border: _border,
                disabledBorder: _border,
                errorBorder: _border,
                alignLabelWithHint: true,
                contentPadding:
                    this.padding ?? BasePKG().symmetric(vertical: 10),
                labelText: label,
                suffixIcon: suffix,
                labelStyle: label != null ? labelStyle ?? style : null,
                hintText: hint,
                hintStyle: hint != null ? hintStyle ?? style : null),
            textCapitalization: textCapitalization ?? TextCapitalization.none),
      ),
    );
  }
}
