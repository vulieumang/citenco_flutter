import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class BoxScale extends StatelessWidget {
  final double width;
  final double height;
  final Widget Function(Size size) builder;

  const BoxScale(
      {Key? key,
      required this.width,
      required this.height,
      required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _ratio = height / width;
    var _size =
        Size(BasePKG().convert(width), BasePKG().convert(width) * _ratio);
    return SizedBox(
        child: builder(_size), width: _size.width, height: _size.height);
  }
}
