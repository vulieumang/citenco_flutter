import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final bool? selected;
  final Function(bool selected)? onChanged;
  final Color? bgColor;
  final EdgeInsets? margin;

  const CheckBox(
      {Key? key, this.selected, this.onChanged, this.bgColor, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = (bgColor ?? BasePKG().color.primaryColor);
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!selected!) : () {},
      child: Container(
          width: 20,
          height: 20,
          margin: margin ?? EdgeInsets.zero,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected! ? color : Colors.white,
              border: Border.all(
                  color: selected! ? color : Color(0xff979797), width: 1)),
          child: BasePKG().boolOf(() => selected!)
              ? Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                )
              : SizedBox()),
    );
  }
}
