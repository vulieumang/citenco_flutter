import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class LinearPercent extends StatelessWidget with DataMix {
  final double? percent;
  final Color? backgroundColor;
  final Color? percentColor;
  final double width;
  final double height;

  const LinearPercent(
      {Key? key,
      this.percent,
      this.backgroundColor,
      this.percentColor,
      this.width = 50,
      this.height = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: backgroundColor,
          ),
          Container(
            width: width * doubleOf(() => percent),
            height: height,
            color: percentColor ?? BasePKG().color.primaryColor,
          )
        ],
      ),
    );
  }
}
