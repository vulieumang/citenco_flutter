import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom({
    Key? key,
    this.controller,
    this.assetSvg,
    this.nameField,
    this.focusNode,
    this.textInputType,
    this.enable = false,
    this.onTap,
    this.onSubmit,
    this.isSuffixIcon = false,
    this.enablePass = false,
  }) : super(key: key);

  String? assetSvg;
  String? nameField;
  TextEditingController? controller;
  FocusNode? focusNode;
  TextInputType? textInputType;
  bool? enable;
  bool? enablePass;
  bool? isSuffixIcon;
  Function()? onTap;
  Function(String data)? onSubmit;
  @override
  State<TextFieldCustom> createState() => _TextdileState();
}

class _TextdileState extends State<TextFieldCustom> {
  bool? obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = widget.enablePass! ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: BasePKG().symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(width: 1, color: Color(0xff539EF8))),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.assetSvg != null)
                  Container(
                    height: 35,
                    child: SvgPicture.asset(
                      widget.assetSvg!,
                      width: 25,
                      height: 25,
                    ),
                  ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    child: TextField(
                      // focusNode: widget.focusNode ?? FocusNode(),
                      minLines: 1,
                      maxLines: 1,
                      cursorColor: BasePKG().color.primaryColor,
                      controller: widget.controller,
                      readOnly: widget.enable ?? false,
                      onTap: widget.onTap,
                      onSubmitted: widget.onSubmit ?? null,
                      style:
                          BasePKG().text!.normalNormal().copyWith(height: 1.2),
                      keyboardType: widget.textInputType ?? TextInputType.text,
                      obscureText: obscureText!,
                      obscuringCharacter: "•",
                      decoration: InputDecoration(
                          prefixStyle: BasePKG().text!.normalNormal(),
                          labelText: widget.nameField,
                          suffixStyle: BasePKG().text!.normalNormal(),
                          suffix: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: widget.enablePass!
                                ? GestureDetector(
                                    onTap: () {
                                      obscureText = !obscureText!;
                                      setState(() {});
                                    },
                                    child: Container(
                                        child: Text(
                                            obscureText!
                                                ? "${BaseTrans().$presently}"
                                                : "${BaseTrans().$hide}",
                                            style: BasePKG()
                                                .text!
                                                .smallNormal()
                                                .copyWith(
                                                    color: BasePKG()
                                                        .color
                                                        .primaryColor))),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      widget.controller!.text = "";
                                      if (widget.onTap != null) widget.onTap!();
                                    },
                                    child: SvgPicture.asset(
                                      "lib/base_citenco/asset/image/ic_close_circle.svg",
                                      width: 25,
                                      height: 25,
                                      color: Color(0xff0D2A5C),
                                    ),
                                  ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          contentPadding: EdgeInsets.only(left: 10, right: 0),
                          labelStyle: BasePKG().text!.normalNormal().copyWith(
                              color: BasePKG().color.text.withOpacity(0.6),
                              height: 0.8)),
                    ),
                  ),
                )
              ]),
        ));
  }
}
