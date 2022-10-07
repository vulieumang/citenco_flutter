import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? child;
  final bool? isExtend;
  final String? header;
  final TextStyle? headerStyle;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final EdgeInsets? headerPadding;
  final Function? onTap;
  final String? textTap;
  const FormView(
      {Key? key,
      this.title,
      this.child,
      this.isExtend = false,
      this.header,
      this.padding,
      this.margin,
      this.titleStyle,
      this.headerStyle,
      this.headerPadding,
      this.onTap,
      this.textTap
      })
      : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  widget.margin ??
          ( widget.isExtend!
              ? BasePKG().only(top: 0)
              : BasePKG().symmetric(vertical: 5)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if ( widget.header != null)
              Padding(
                padding:  widget.headerPadding ??
                    BasePKG().symmetric(vertical: 10, horizontal: 20),
                child: Text(
                   widget.header!,
                  style:  widget.headerStyle ?? BasePKG().text!.normalLowerBold().copyWith(color: BasePKG().color.text),
                ),
              ),
            Container(
                alignment: Alignment.centerLeft,
                color: BasePKG().color.card,
                padding:  widget.padding ??
                    ( widget.isExtend!
                        ? BasePKG().only(top: 10, left: 16, right: 16)
                        : BasePKG().only(top: 15, left: 16, right: 16,bottom: 15)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      if ( widget.title != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                   widget.title!,
                                  style:  widget.titleStyle ?? BasePKG().text!.normalLowerBold().copyWith(color: BasePKG().color.text),
                                ),
                            ),
                            if( widget.textTap != null)
                            GestureDetector(
                              onTap: (){widget.onTap!();},
                              child: Container(
                                child: Text(
                                  "${ widget.textTap}",
                                  style: BasePKG().text!.smallNormal().copyWith(color: BasePKG().color.primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      widget.child ?? SizedBox(),
                    ]))
          ]),
    );
  }
}
