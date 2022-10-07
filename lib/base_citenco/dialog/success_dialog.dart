import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/bounce_tap.dart';
import 'package:cnvsoft/base_citenco/view/html_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? action;
  final Widget? infoView;
  final double? radius;
  final String? actionLabel;
  final bool isHtml;

  static Future show(State state,
      {String? title,
      String? message,
      Widget? action,
      Widget? infoView,
      double? radius,
      String? actionLabel,
      bool isHtml = false}) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: SuccessDialog(
                  title: title,
                  message: message,
                  action: action,
                  infoView: infoView,
                  radius: radius,
                  actionLabel: actionLabel,
                  isHtml: isHtml)));
  }

  const SuccessDialog(
      {Key? key,
      this.title,
      this.message,
      this.action,
      this.infoView,
      this.radius,
      this.actionLabel,
      this.isHtml = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.dialog,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8))),
        padding: BasePKG().all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildIconSucc(),
            SizedBox(height: BasePKG().convert(20)),
            if (title != null) ..._buildTitle(),
            if (infoView != null) ...[
              infoView!,
              SizedBox(height: BasePKG().convert(12)),
            ],
            if (message != null) ..._buildMessage(),
            action ?? _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BounceTap(
      child: Container(
        width: BasePKG().convert(173),
        height: BasePKG().convert(40),
        padding: BasePKG().all(8),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: BasePKG().color.primaryColor)),
        child: Center(
          child: Text(
            actionLabel ?? BaseTrans().$close,
            style: BasePKG()
                .text!
                .normalLowerMedium()
                .copyWith(color: BasePKG().color.primaryColor),
          ),
        ),
      ),
      onTap: Navigator.of(context).pop,
    );
  }

  List<Widget> _buildMessage() {
    return [
      BasePKG().boolOf(() => isHtml)
          ? HtmlView(data: BasePKG().stringOf(() => message))
          : Text(
              BasePKG().stringOf(() => message),
              style: BasePKG().text!.messageDialog(),
              textAlign: TextAlign.center,
            ),
      SizedBox(height: BasePKG().convert(12)),
    ];
  }

  List<Widget> _buildTitle() {
    return [
      BasePKG().boolOf(() => isHtml)
          ? HtmlView(data: BasePKG().stringOf(() => title))
          : Text(
              BasePKG().stringOf(() => Utils.upperCaseFirst(title)),
              style: BasePKG().text!.titleDialog(),
              textAlign: TextAlign.center,
            ),
      SizedBox(height: BasePKG().convert(12)),
    ];
  }

  Widget _buildIconSucc() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: BasePKG().convert(57),
          backgroundColor: BasePKG().color.icDialogSuccess.withOpacity(0.2),
        ),
        CircleAvatar(
          radius: BasePKG().convert(38),
          backgroundColor: BasePKG().color.icDialogSuccess,
          child: SvgPicture.asset(
            "lib/special/base_citenco/asset/image/check.svg",
            color: Colors.white, //BasePKG().color.card,
            height: BasePKG().convert(24),
          ),
        ),
      ],
    );
  }
}
