import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/view/bounce_tap.dart';
import 'package:flutter/material.dart';

class SearchBoxView extends StatelessWidget {
  final Function(String text)? onChanged;
  final Function(String text)? onSubmited;
  final Function() onClear;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hint;
  final Color? background;
  final Color? backgroundSearch;
  final bool rounded;
  final EdgeInsets? margin;

  const SearchBoxView(
      {Key? key,
      this.onChanged,
      required this.onClear,
      required this.controller,
      this.focusNode,
      this.background,
      required this.hint,
      this.onSubmited,
      this.rounded: false,
      this.margin,
      this.backgroundSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BasePKG().decoration!.accentDecoration();
    if (background != null) decoration = decoration.copyWith(color: background);
    return Container(
      decoration: decoration,
      padding: margin ?? BasePKG().symmetric(vertical: 12, horizontal: 20),
      child: rounded
          ? Material(
              color: backgroundSearch ?? BasePKG().color.background,
              shape: StadiumBorder(),
              child: Padding(
                padding: BasePKG().symmetric(horizontal: 16, vertical: 8),
                child: _buildChild(),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: backgroundSearch ?? BasePKG().color.background,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: BasePKG().symmetric(horizontal: 12, vertical: 8),
              child: _buildChild(),
            ),
    );
  }

  _buildChild() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            onChanged: onChanged ?? (t) => {},
            onSubmitted: onSubmited ?? (t) => {},
            controller: controller,
            focusNode: focusNode,
            cursorColor: BasePKG().color.primaryColor,
            style: BasePKG().text!.smallNormal().copyWith(),
            decoration: InputDecoration(
                // fillColor:  BasePKG().color.background,
                // filled: true,
                isDense: true,
                hintText: hint,
                border: InputBorder.none,
                hintStyle: BasePKG().text!.labelSmall(),
                contentPadding: BasePKG().zero),
          ),
        ),
        BounceTap(
          child: Icon(Icons.clear, color: Colors.black),
          onTap: onClear,
        )
      ],
    );
  }
}
