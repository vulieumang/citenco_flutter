import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/html_view.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/base_core/data_mix.dart';

class ConfirmDialog extends StatelessWidget with DataMix {
  final String? title;
  final String? msg;
  final Function()? onPositive;
  final Function()? onNegative;
  final bool? showCloseButton;
  final bool? isNegativeMsg;
  final bool? ispositiveMsg;
  final String? negativeMsg;
  final String? positiveMsg;
  final String? image;
  final double? heightAssetsImage;
  final Widget? msgWidget;
  final bool isHtml;
  final double? radius;

  static Future show(State state,
      {required String msg,
      Function()? onPositive,
      Function()? onNegative,
      String? negativeMsg,
      String? positiveMsg,
      String? title,
      bool barrierDismissible = true,
      bool? isNegativeMsg =true,
      bool? ispositiveMsg =true,
      String? image,
      double? heightAssetsImage,
      bool? showCloseButton,
      Widget? msgWidget,
      bool isHtml = false,
      double? radius}) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: barrierDismissible,
          context: state.context,
          builder: (context) => WillPopScope(
                onWillPop: () async => barrierDismissible,
                child: ConfirmDialog(
                    title: title,
                    msg: msg,
                    onPositive: onPositive,
                    onNegative: onNegative,
                    negativeMsg: negativeMsg,
                    positiveMsg: positiveMsg,
                    image: image,
                    heightAssetsImage: heightAssetsImage,
                    showCloseButton: showCloseButton,
                    isNegativeMsg: isNegativeMsg,
                    ispositiveMsg: ispositiveMsg,
                    msgWidget: msgWidget,
                    isHtml: isHtml,
                    radius: radius),
              ));
  }

  const ConfirmDialog(
      {Key? key,
      this.title,
      this.msg,
      this.onPositive,
      this.onNegative,
      this.negativeMsg,
      this.positiveMsg,
      this.image,
      this.heightAssetsImage,
      this.showCloseButton = false,
      this.isNegativeMsg = true,
      this.ispositiveMsg = true,
      this.msgWidget,
      this.isHtml = false,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: BasePKG().color.dialog,
                    borderRadius:
                        BorderRadius.all(Radius.circular(radius ?? 8))),
                padding: BasePKG().all(20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (image != null) ..._buildAssetsImage(),
                      Visibility(
                        visible: (title == null ||
                            (title != null && title!.isNotEmpty)),
                        child: BasePKG().boolOf(() => isHtml)
                            ? HtmlView(data: BasePKG().stringOf(() => title))
                            : Text(
                                Utils.upperCaseFirst(
                                    title ?? BaseTrans().$notification),
                                textAlign: TextAlign.center,
                                style: BasePKG()
                                    .text!
                                    .titleDialog()
                                    .copyWith(fontWeight: FontWeight.bold,color: BasePKG().color.text)),
                      ),
                      SizedBox(height: 12),
                      if (msgWidget != null)
                        msgWidget!
                      else
                        BasePKG().boolOf(() => isHtml)
                            ? HtmlView(data: BasePKG().stringOf(() => msg))
                            : Text(
                                BasePKG().stringOf(() => msg),
                                textAlign: TextAlign.center,
                                style: BasePKG().text!.messageDialog(),
                              ),
                      SizedBox(height: 24),
                      Row(children: <Widget>[
                        Visibility(
                          visible: BasePKG().boolOf(() => isNegativeMsg!),
                          child: Expanded(
                            child: SquareButton(
                              margin: BasePKG().zero,
                              padding: BasePKG().all(12),
                              text: stringOf(() => negativeMsg!,
                                  Utils.upperCaseFirst(BaseTrans().$no)),
                              onTap: () {
                                Navigator.of(context).pop();
                                (onNegative ?? () {})();
                              },
                              theme: BasePKG().button!.negativeButton(context,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                       SizedBox(width: 16),
                      Visibility(
                          visible: BasePKG().boolOf(() => ispositiveMsg!),
                          child: Expanded(
                              child: SquareButton(
                                  margin: BasePKG().zero,
                                  padding: BasePKG().all(12),
                                  text: stringOf(() => positiveMsg!,
                                      Utils.upperCaseFirst(BaseTrans().$yes)),
                                  onTap: () {
                                    Navigator.of(context).pop("OK");
                                    (onPositive ?? () {})();
                                  },
                                  theme: BasePKG().button!.primaryDialogButton(
                                      context,
                                      fontWeight: FontWeight.normal))),
                        )
                      ])
                    ])),
            Visibility(
              visible: BasePKG().boolOf(() => showCloseButton!),
              child: Positioned(
                top: -7.5,
                right: -7.5,
                child: IconButton(
                    icon: Icon(Icons.close,color: BasePKG().color.iconColor,),
                    onPressed: Navigator.of(context).pop),
              ),
            ),
          ],
        ));
  }

  List<Widget> _buildAssetsImage() {
    return [
      image!.endsWith(".svg")
          ? SvgPicture.asset(image!)
          : Image.asset(image!, height: heightAssetsImage ?? 120),
      SizedBox(height: 12),
    ];
  }
}
