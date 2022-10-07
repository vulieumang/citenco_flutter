import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWrapView<T> extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final List<WrapItem<T>>? children;
  final Function(WrapItem<T> item)? onItemChanged;
  final EdgeInsets? margin;
  final bool? defaultHasData;
  final int? columnNumber;
  final Color? colorBackground;
  final bool? marignTitle;
  final double? height;
  final bool? hightSelected;

  factory FormWrapView.dynamicSize(
      {String? title,
      List<WrapItem<T>>? children,
      Function(WrapItem<T> item)? onItemChanged,
      TextStyle? titleStyle,
      bool? defaultHasData,
      EdgeInsets? margin,
      bool hightSelected = true}) {
    return FormWrapView(
      title: title,
      children: children,
      onItemChanged: onItemChanged,
      defaultHasData: false,
      titleStyle: titleStyle,
      margin: margin,
      hightSelected: hightSelected,
    );
  }

  const FormWrapView(
      {Key? key,
      required this.title,
      required this.children,
      this.onItemChanged,
      this.margin,
      this.defaultHasData = true,
      this.titleStyle,
      this.columnNumber = 3,
      this.colorBackground,
      this.marignTitle = true,
      this.height,
      this.hightSelected = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? BasePKG().symmetric(vertical: 5),
        color: colorBackground ?? BasePKG().color.card,
        padding: BasePKG().symmetric(vertical: 10, horizontal: 7),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: marignTitle! ? 13 : 7, vertical: 6),
                    child: Text(
                      title!,
                      style: titleStyle ?? BasePKG().text!.normalLowerBold(),
                    ),
                  )
                ],
              ),
              if (children!.isEmpty)
                Padding(
                  padding: BasePKG().all(20),
                  child: Text(
                    BaseTrans().$noData,
                    style: BasePKG().text!.description(),
                  ),
                )
              else
                defaultHasData!
                    ? _buildHasData(context)
                    : _buildHasDataDynamicSize(context)
            ]));
  }

  _buildHasData(BuildContext context) {
    return height != null
        ? Container(
            height: height,
            child: _buildData(context),
          )
        : Flexible(child: _buildData(context));
  }

  _buildData(BuildContext context) {
    var _width = (MediaQuery.of(context).size.width - 16.0) / columnNumber!;
    return SingleChildScrollView(
        padding: BasePKG().zero,
        child: Row(children: <Widget>[
          Flexible(
              child: Wrap(
                  children: children!.map((f) {
            return ChangeNotifierProvider.value(
                value: f,
                child: Consumer<WrapItem<T>>(builder: (context, value, child) {
                  return Container(
                      width: _width,
                      child: GestureDetector(
                          child: _buildCell(
                              value.text,
                              BasePKG().stringOf(() => value.subRightText!),
                              value.background,
                              value.textStyle),
                          onTap: () {
                            if (!value.isHidden) {
                              (onItemChanged ?? (item) {})(value);
                              if (hightSelected!) value.setSelected(true);
                            }
                          }));
                }));
          }).toList()))
        ]));
  }

  _buildHasDataDynamicSize(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: List.generate(
            children!.length,
            (index) => ChangeNotifierProvider.value(
                value: children?[index],
                child: Consumer<WrapItem<T>>(builder: (context, value, child) {
                  return Container(
                      child: GestureDetector(
                          child: Container(
                            margin: BasePKG()
                                .symmetric(vertical: 10, horizontal: 7),
                            padding: BasePKG()
                                .symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: value.background,
                                border: Border.all(color: BasePKG().color.line),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              value.text,
                              textAlign: TextAlign.center,
                              style: value.textStyle,
                            ),
                          ),
                          onTap: () {
                            if (!value.isHidden) {
                              (onItemChanged ?? (item) {})(value);
                              if (hightSelected!) value.setSelected(true);
                            }
                          }));
                }))),
      ),
    );
  }

  _buildCell(String text, String? subRightText, Color background,
      TextStyle textStyle) {
    return Stack(
      children: <Widget>[
        Container(
          margin: BasePKG().symmetric(vertical: 10, horizontal: 7),
          padding: BasePKG().symmetric(vertical: 10, horizontal: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: background,
              border: Border.all(color: BasePKG().color.line),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
        Container(
          margin: BasePKG().symmetric(vertical: 14, horizontal: 12),
          alignment: Alignment.topRight,
          child: Opacity(
              opacity: subRightText == null ? 0.0 : 1.0,
              child: Text(
                subRightText ?? "",
                style: textStyle.copyWith(fontSize: 9),
              )),
        )
      ],
    );
  }
}

class WrapItem<T> extends ChangeNotifier {
  final T? data;
  final String text;
  final String? subRightText;
  bool selected = false;
  bool isHidden = false;

  WrapItem(
      {required this.text,
      this.selected = false,
      this.isHidden = false,
      this.subRightText,
      this.data});

  void setSelected(bool value) {
    this.selected = value;
    notifyListeners();
  }

  TextStyle get textStyle => selected
      ? BasePKG().text!.smallBold().copyWith(color: BasePKG().color.card)
      : (this.isHidden
          ? BasePKG().text!.smallNormal().copyWith(color: BasePKG().color.card)
          : BasePKG().text!.smallNormal());

  Color get background => selected
      ? BasePKG().color.primaryColor
      : (this.isHidden ? Colors.grey : BasePKG().color.card);
}
