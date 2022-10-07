import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../util.dart';
import 'agree_dialog_provider.dart';

class AgreeDialog extends StatefulWidget {
  final String? title;
  final String? msg;
  final Function()? onPositive;
  final Function()? onNegative;
  final String? negativeMsg;
  final String? positiveMsg;
  final Widget? msgAgree;

  const AgreeDialog(
      {Key? key,
      this.title,
      this.msg,
      this.onPositive,
      this.onNegative,
      this.negativeMsg,
      this.positiveMsg,
      required this.msgAgree})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AgreeDialogState();
  }

  static Future show(State state,
      {required String msg,
      Function()? onPositive,
      Function()? onNegative,
      String? negativeMsg,
      String? positiveMsg,
      String? title,
      bool barrierDismissible = true,
      required Widget msgAgree}) async {
    if (state.mounted)
      return await showDialog(
          barrierDismissible: barrierDismissible,
          context: state.context,
          builder: (context) => AgreeDialog(
              title: title,
              msg: msg,
              onPositive: onPositive,
              onNegative: onNegative,
              negativeMsg: negativeMsg,
              positiveMsg: positiveMsg,
              msgAgree: msgAgree));
  }
}

class AgreeDialogState extends BaseView<AgreeDialog, AgreeDialogProvider> {
  @override
  Widget body() {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: BasePKG().color.dialog,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: BasePKG().all(20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(widget.title ?? BaseTrans().$notification,
                      style: BasePKG()
                          .text!
                          .titleDialog()
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text(
                    widget.msg!,
                    textAlign: TextAlign.center,
                    style: BasePKG().text!.messageDialog(),
                  ),
                  SizedBox(height: 24),
                  _itemCheck(),
                  SizedBox(height: 24),
                  Row(children: <Widget>[
                    Expanded(
                      child: SquareButton(
                        margin: BasePKG().zero,
                        padding: BasePKG().all(12),
                        text: BasePKG().stringOf(() => widget.negativeMsg!,
                            Utils.upperCaseFirst(BaseTrans().$no)),
                        onTap: () {
                          Navigator.of(context).pop();
                          (widget.onNegative ?? () {})();
                        },
                        theme: BasePKG().button!.negativeButton(context,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(child: Consumer<EnableConfirmNotifier>(
                        builder: (ctx, enable, _) {
                      return SquareButton(
                          margin: BasePKG().zero,
                          padding: BasePKG().all(12),
                          text: BasePKG().stringOf(() => widget.positiveMsg!,
                              Utils.upperCaseFirst(BaseTrans().$yes)),
                          onTap: enable.value!
                              ? () {
                                  Navigator.of(context).pop("OK");
                                  (widget.onPositive ?? () {})();
                                }
                              : () {},
                          theme: enable.value!
                              ? BasePKG().button!.primaryDialogButton(context,
                                  fontWeight: FontWeight.normal)
                              : BasePKG().button!.negativeButton(context,
                                  fontWeight: FontWeight.normal));
                    }))
                  ])
                ])));
  }

  Widget _itemCheck() {
    return InkWell(
      onTap: provider.onCheckPressed,
      child: Row(children: [
        Consumer<EnableConfirmNotifier>(builder: (ctx, enable, _) {
          return Container(
              width: 20,
              height: 20,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black))),
                if (enable.value!) ...[
                  SvgPicture.asset("lib/special/modify/asset/image/tick.svg",
                      color: BasePKG().color.primaryColor)
                ]
              ]));
        }),
        SizedBox(width: 5),
        Expanded(child: widget.msgAgree ?? SizedBox())
      ]),
    );
  }

  @override
  AgreeDialogProvider initProvider() {
    return AgreeDialogProvider(this);
  }
}
