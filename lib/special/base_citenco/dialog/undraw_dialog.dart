import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ms_undraw/ms_undraw.dart';

class UndrawDialog extends StatelessWidget {
  final UnDrawIllustration? undraw;
  final String? title;
  final String? message;
  final Function()? onPositive;
  final String? positive;
  final Function()? onNegative;
  final String? negative;
  final String? close;

  const UndrawDialog(
      {Key? key,
      this.undraw,
      this.title,
      this.message,
      this.onPositive,
      this.positive,
      this.close,
      this.onNegative,
      this.negative})
      : super(key: key);

  static Future show({
    required State state,
    String? title,
    UnDrawIllustration? undraw,
    String? message,
    Function()? onPositive,
    String? positive,
    Function()? onNegative,
    String? negative,
    String? close,
  }) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => UndrawDialog(
                undraw: undraw,
                title: title ?? BaseTrans().$notification,
                message: message ?? "",
                onPositive: onPositive,
                positive: positive ?? BaseTrans().$agree,
                onNegative: onNegative,
                negative: negative,
                close: close,
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.dialog,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: BasePKG().symmetric(horizontal: 12, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildUndraw(),
            SizedBox(height: 12),
            _buildTitle(),
            SizedBox(height: 4),
            _buildMessage(),
            SizedBox(height: 32),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  _buildUndraw() {
    return UnDraw(
        placeholder: SpinKitFadingCircle(
          color: BasePKG().color.primaryColor,
          size: 52,
        ),
        height: 80,
        illustration: undraw!,
        color: BasePKG().color.primaryColor);
  }

  Widget _buildButton(BuildContext context) {
    bool _hasNegative = onNegative != null && negative != null;
    bool _hasPositive = onPositive != null && positive != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (!_hasNegative && !_hasPositive)
          SquareButton(
            margin: BasePKG().zero,
            padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
            text: close ?? BaseTrans().$close,
            onTap: () {
              Navigator.of(context).pop();
            },
            theme: BasePKG().button!.alternativeButton(context),
          )
        else ...[
          SquareButton(
            margin: BasePKG().zero,
            padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
            text: positive!,
            onTap: () {
              if (onPositive != null) onPositive!();
              Navigator.of(context).pop();
            },
            theme: BasePKG().button!.primaryButton(context),
          ),
          if (onNegative != null && negative != null) ...[
            SizedBox(width: 12),
            SquareButton(
              margin: BasePKG().zero,
              padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
              text: negative!,
              onTap: () {
                onNegative!();
                Navigator.of(context).pop();
              },
              theme: BasePKG().button!.negativeButton(context),
            ),
          ]
        ]
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title!,
      style:
          BasePKG().text!.titleDialog().copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage() {
    return Text(
      message!,
      style: BasePKG().text!.messageDialog(),
      textAlign: TextAlign.center,
    );
  }
}
