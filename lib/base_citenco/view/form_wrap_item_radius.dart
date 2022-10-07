import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWrapViewRadius extends StatelessWidget {
  final List<WrapItemWithRadius>? children;
  final Function(WrapItemWithRadius item)? onItemChanged;
  final EdgeInsets? margin;

  const FormWrapViewRadius(
      {Key? key, required this.children, this.onItemChanged, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? BasePKG().symmetric(vertical: 5),
        color: BasePKG().color.card,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (children!.isEmpty)
                Padding(
                  padding: BasePKG().all(20),
                  child: Text(
                    BaseTrans().$noData,
                    style: BasePKG().text!.description(),
                  ),
                )
              else
                _buildHasData()
            ]));
  }

  _buildHasData() {
    return Flexible(
        child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Wrap(
                          children: children!.map((f) {
                    return ChangeNotifierProvider.value(
                        value: f,
                        child: Consumer<WrapItemWithRadius>(
                            builder: (context, value, child) {
                          return Container(
                              child: GestureDetector(
                            child: _buildCell(
                                value.text!, value.background, value.textStyle),
                            onTap: () {
                              if (!value.isHidden) {
                                (onItemChanged ?? (item) {})(value);
                                value.setSelected();
                              }
                            },
                          ));
                        }));
                  }).toList()))
                ])));
  }

  _buildCell(String text, Color background, TextStyle textStyle) {
    return Container(
      margin: BasePKG().symmetric(vertical: 10, horizontal: 7),
      padding: BasePKG().symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: background,
          border: Border.all(color: BasePKG().color.line),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class WrapItemWithRadius<T> extends ChangeNotifier {
  final T? data;
  final String? text;
  bool selected = false;
  bool isHidden = false;

  WrapItemWithRadius(
      {required this.text,
      this.selected = false,
      this.isHidden = false,
      this.data});

  void setSelected() {
    this.selected = !this.selected;
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
