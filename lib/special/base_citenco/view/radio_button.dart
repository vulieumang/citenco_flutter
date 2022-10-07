import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String? radioChecked;
  final bool? isSelected;
  final double? width;
  final double? height;
  final Widget? unCheck;

  const RadioButton(
      {Key? key,
      this.radioChecked,
      this.isSelected,
      this.width,
      this.height,
      this.unCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;
    double _width = width ?? 20;
    double _height = height ?? 30;
    return Container(
        height: _width,
        width: _height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            (unCheck ?? _buildUncheck(_width, _height)),
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                width: _isSelected ? _width : 0,
                height: _isSelected ? _height : 0,
                alignment: Alignment.center,
                child: Image.asset(
                    radioChecked ?? "lib/special/base_citenco/asset/image/ic_radio.png",
                    color: BasePKG().color.primaryColor)),
          ],
        ));
  }

  Widget _buildUncheck(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(border: Border.all(width: 1), shape: BoxShape.circle),
    );
  }
}
