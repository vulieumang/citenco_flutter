import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:flutter/material.dart';

class BottomDialog extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final Function()? onDismiss;
  final Color? background;
  final bool? isBottomSafe;
  final double? borderTop;
  final double? marginTop;

  static Future show(State state, Widget child,
      {EdgeInsets? padding,
      bool tapToDismiss = true,
      Color? background,
      bool isBottomSafe = true,
      double? borderTop,
      bool isScrollControlled = true,
      bool enableDrag = true,
      double? marginTop}) async {
    if (state.mounted)
      return await showModalBottomSheet(
          // barrierDismissible: false,
          // transitionDuration: Duration(milliseconds: 10),
          // pageBuilder: (context, animation, secondaryAnimation) {
          //   return BottomDialog(
          //       child: child,
          //       padding: padding,
          //       onDismiss: tapToDismiss ? Navigator.of(context).pop : () {},
          //       background: background);
          // },
          isScrollControlled: isScrollControlled,
          isDismissible: tapToDismiss,
          context: state.context,
          enableDrag: enableDrag,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => BottomDialog(
              child: child,
              padding: padding,
              onDismiss: tapToDismiss ? Navigator.of(context).pop : () {},
              background: background,
              borderTop: borderTop,
              marginTop: marginTop,
              isBottomSafe: isBottomSafe));
  }

  const BottomDialog(
      {Key? key,
      this.child,
      this.padding,
      this.onDismiss,
      this.background,
      this.isBottomSafe = true,
      this.marginTop,
      this.borderTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Material(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          GestureDetector(
            // child: Container(
            //   color: Colors.black54,
            //   height: double.infinity,
            //   width: double.infinity,
            // ),
            onTap: onDismiss ?? () {},
          ),
          SafeArea(
              bottom: false,
              child: Container(
                  width: double.infinity,
                  margin: BasePKG().only(top: marginTop ?? 70),
                  padding: padding ??
                      BasePKG().symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderTop ?? 10),
                          topRight: Radius.circular(borderTop ?? 10)),
                      color: background ?? BasePKG().color.card),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                        padding: mediaQuery
                            .viewInsets, // set view with textfeild above keyboard
                        child: SafeArea(
                            top: false,
                            bottom: isBottomSafe!,
                            child:
                                child!)), // fill color into unsafe area if background is transparent
                  ])))
        ]));
  }
}
