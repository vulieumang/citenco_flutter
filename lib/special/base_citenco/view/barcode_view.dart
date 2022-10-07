import 'package:barcode/barcode.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BarcodeView extends StatelessWidget {
  final String code;
  final bool? enableBorder;
  final Color? color;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? letterSpacing;
  final EdgeInsetsGeometry? padding;
  final FontWeight? textFontWeight;

  const BarcodeView(
      {Key? key,
      required this.code,
      this.enableBorder,
      this.color,
      this.fontSize,
      this.height,
      this.letterSpacing,
      this.width,
      this.padding,
      this.textFontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Container(
      padding: padding ?? EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: Colors.black
                  .withOpacity((enableBorder ?? true) ? 1.0 : 0.0))),
      child: Column(
        children: [
          SvgPicture.string(
            Barcode.code128().toSvg(BasePKG().stringOf(() => code),
                fontFamily: "HelveticaNeue",
                drawText: false,
                width: this.width ?? width,
                height: height ?? 60),
          ),
          SizedBox(height: 2),
          Container(
              width: width,
              child: Text(
                code,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: color ?? BasePKG().color.primaryColor,
                    letterSpacing: letterSpacing ?? 1.4,
                    fontSize: fontSize ?? 16,
                    fontWeight: textFontWeight ?? FontWeight.w700),
              ))
        ],
      ),
    );
  }
}
