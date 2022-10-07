import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SpecialInformDialog extends StatelessWidget {
  final String? svgIconPath;
  final String? title;
  final Widget? contentWidget;
  final String? buttonText;
  final Function? buttonFunc;
  final Color? iconColor;

  static Future showSuccessDialog(
      {required State state,
      String? title,
      Widget? contentWidget,
      String? buttonContent}) async {
    String iconPath = "lib/special/base_citenco/asset/image/check.svg";
    if (state.mounted)
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => SpecialInformDialog(
                svgIconPath: iconPath,
                iconColor: BasePKG().color.icDialogSuccess,
                title: title ?? BaseTrans().$finished,
                buttonText: buttonContent ?? 'OK',
                contentWidget: contentWidget,
              ));
  }

  static Future showFailedDialog(
      {required State state,
      String? title,
      Widget? contentWidget,
      String? buttonContent}) async {
    String iconPath = "lib/special/base_citenco/asset/image/close.svg";
    if (state.mounted)
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => SpecialInformDialog(
                svgIconPath: iconPath,
                iconColor: BasePKG().color.icDialogError,
                title: title ?? BaseTrans().$hasError,
                buttonText: buttonContent ?? 'OK',
                contentWidget: contentWidget,
              ));
  }

  const SpecialInformDialog({
    Key? key,
    this.svgIconPath,
    this.title,
    this.contentWidget,
    this.buttonText = 'OK',
    this.buttonFunc,
    this.iconColor,
  }) : super(key: key);

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
            _buildIcon(),
            SizedBox(height: 12),
            _buildTitle(),
            SizedBox(height: 12),
            contentWidget ?? Container(),
            contentWidget != null ? SizedBox(height: 24) : Container(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SquareButton(
          margin: BasePKG().zero,
          padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
          text: buttonText!,
          onTap: () {
            Navigator.of(context).pop();
          },
          theme: BasePKG()
              .button!
              .alternativeButton(context, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(Utils.upperCaseFirst(title!),
        style: BasePKG()
            .text!
            .titleDialog()
            .copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildIcon() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 52,
          backgroundColor: iconColor!.withOpacity(0.2),
        ),
        CircleAvatar(
          radius: 36,
          backgroundColor: iconColor,
          child: SvgPicture.asset(
            svgIconPath!,
            color: Colors.white, //BasePKG().color.card,
            height: 24,
          ),
        ),
      ],
    );
  }
}
