import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/bounce_tap.dart';
import 'package:cnvsoft/base_citenco/view/html_view.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? action;
  final Widget? infoView;
  final double? radius;
  final String? actionLabel;
  final bool isHtml;
  final bool? isWaring;
  final String? leftText;
  final String? rightText;
  final Function()? onTapLeft;
  final Function()? onTapRight;

  static Future show(State state,
      {String? title,
      String? message,
      Widget? action,
      Widget? infoView,
      double? radius,
      String? actionLabel,
      String? leftText = "Bỏ qua",
      String? rightText = "Xác nhận",
      bool isWaring = false,
      bool isHtml = false,
      Function()? onTapRight,
      Function()? onTapLeft
      }) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: CustomDialog(
                  title: title,
                  message: message,
                  action: action,
                  infoView: infoView,
                  radius: radius,
                  actionLabel: actionLabel,
                  isHtml: isHtml,
                  isWaring: isWaring,  
                  leftText: leftText,
                  rightText: rightText,
                  onTapLeft: onTapLeft,
                  onTapRight: onTapRight,
                )));
  }

  const CustomDialog(
      {Key? key,
      this.title,
      this.message,
      this.action,
      this.infoView,
      this.radius,
      this.actionLabel,
      this.isWaring,
      this.isHtml = false,
      this.leftText,
      this.rightText,
      this.onTapLeft,
      this.onTapRight
      })
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
              Column(
                children: [
                  infoView!,
                ],
              ),
              SizedBox(height: BasePKG().convert(49)),
            ],
            if (message != null) ..._buildMessage(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SquareButton(
            margin: BasePKG().zero,
            padding: BasePKG().all(12),
            text: "${leftText}",
            onTap: () {
              Navigator.of(context).pop();
              (onTapLeft ?? () {})();
            },
            theme: BasePKG().button!.negativeButton(context,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: SquareButton(
            margin: BasePKG().zero,
            padding: BasePKG().all(12),
            text: "${rightText}",
            onTap: () {
              Navigator.of(context).pop("OK");
              (onTapRight ?? () {})();
            },
            theme: BasePKG().button!.primaryDialogButton(
                context,
                fontWeight: FontWeight.normal)),
        )
    ]);
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
    if(isWaring!)
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: BasePKG().convert(57),
          backgroundColor: Color(0xffFBA10D).withOpacity(0.2),
        ),
        CircleAvatar(
          radius: BasePKG().convert(38),
          backgroundColor: Color(0xffFBA10D),
          child: SvgPicture.asset(
            "lib/special/base_citenco/asset/image/ic_waring.svg",
            color: Colors.white, //BasePKG().color.card,
            height: BasePKG().convert(24),
          ),
        ),
      ],
    );

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
