import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MessageDialog extends StatelessWidget {
  final String? title;
  final String? msg;
  final String? textButton;
  final bool? showIcon;
  final String? assetsImage;
  final Color? msgColor;
  final Widget? infoView;
  final Color? color;
  final double? heightAssetsImage;

  static Future showImage(State state,
      {String? msg,
      String? title,
      String? textButton,
      bool? barrierDismissible,
      String? assetsImage,
      Color? msgColor,
      double? heightAssetsImage}) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: barrierDismissible ?? true,
          context: state.context,
          builder: (context) => MessageDialog(
              title: title,
              msg: msg,
              showIcon: false,
              assetsImage: assetsImage,
              textButton: textButton,
              msgColor: msgColor,
              heightAssetsImage: heightAssetsImage));
  }

  static Future show(State state, String msg,
      [String? title, bool? barrierDismissible, String? textButton]) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: barrierDismissible ?? true,
          context: state.context,
          builder: (context) => MessageDialog(
              title: title, msg: msg, showIcon: false, textButton: textButton));
  }

  static Future showWithColor(State state,
      {required String msg,
      required Color color,
      String? title,
      bool? barrierDismissible,
      String? textButton}) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: barrierDismissible ?? true,
          context: state.context,
          builder: (context) => MessageDialog(
              title: title,
              msg: msg,
              color: color,
              showIcon: false,
              textButton: textButton));
  }

  static Future showErrors(State state, dynamic response,
      [String? title,
      bool? barrierDismissible,
      String? textButton,
      Widget? infoView]) async {
    if (state.mounted) {
      String msg = "";
      if (response is String) {
        msg = response;
      }
      if (response is List && response.isNotEmpty) {
        msg = response.first.toString();
      }
      if (response != null && response is Map) {
        msg = response.toString();
        if (response["message"] != null) msg = response["message"].toString();
        if (response["errors"] != null) {
          msg = response["errors"].toString();
          if (response["errors"] is Map &&
              (response["errors"] as Map).isNotEmpty)
            msg = (response["errors"] as Map).values.first.toString();
        }
        if (response["status"] != null) msg = response["status"].toString();
      }

      if (msg.isNotEmpty && msg.startsWith("[") && msg.endsWith("]"))
        msg = msg.substring(1, msg.length - 1);

      return await showDialog(
          barrierDismissible: barrierDismissible ?? true,
          context: state.context,
          builder: (context) => MessageDialog(
              title: title,
              msg: msg,
              showIcon: true,
              textButton: textButton,
              infoView: infoView));
    }
  }

  const MessageDialog(
      {Key? key,
      this.title,
      this.msg,
      this.showIcon = false,
      this.assetsImage,
      this.textButton,
      this.msgColor,
      this.infoView,
      this.color,
      this.heightAssetsImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.dialog,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: BasePKG().all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (assetsImage != null) ..._buildAssetsImage(),
            if (showIcon!) ..._buildIconError(),
            _buildTitle(),
            SizedBox(height: 12),
            if (infoView != null) ...[
              infoView!,
              SizedBox(height: BasePKG().convert(12)),
            ],
            if (BasePKG().boolOf(() => msg!.isNotEmpty, false)) ...[
              _buildMessage(),
              SizedBox(height: 16),
            ],
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    var theme = BasePKG()
        .button!
        .alternativeButton(context, fontWeight: FontWeight.normal);
    if (color != null)
      theme = theme.copyWith(
          canvasColor: color,
          textTheme: theme.textTheme.copyWith(
              button: theme.textTheme.button!.copyWith(color: color)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SquareButton(
          margin: BasePKG().zero,
          padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
          text: textButton ?? "OK",
          onTap: () => Navigator.of(context).pop('OK'),
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Text(
        msg ?? "",
        style: BasePKG()
            .text!
            .contentWidget()
            .copyWith(color: msgColor ?? BasePKG().color.messageDialog),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(Utils.upperCaseFirst(title ?? BaseTrans().$notification),
        textAlign: TextAlign.center,
        style: BasePKG()
            .text!
            .titleDialog()
            .copyWith(fontWeight: FontWeight.bold));
  }

  List<Widget> _buildIconError() {
    return [
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 52,
            backgroundColor: BasePKG().color.icDialogError.withOpacity(0.2),
          ),
          CircleAvatar(
            radius: 36,
            backgroundColor: BasePKG().color.icDialogError,
            child: SvgPicture.asset(
              "lib/base_citenco/asset/image/close.svg",
              color: Colors.white, //BasePKG().color.card,
              height: 24,
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
    ];
  }

  List<Widget> _buildAssetsImage() {
    return [
      Image.asset(assetsImage!, height: heightAssetsImage ?? 196),
      SizedBox(height: 12),
    ];
  }
}
