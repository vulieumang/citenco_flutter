import 'dart:io';

import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';

class LockAppDialog extends StatelessWidget with DataMix {
  final String? message;
  const LockAppDialog({Key? key, this.message}) : super(key: key);

  static Future show(State state, {dynamic response}) async {
    if (state.mounted) {
      String message = "";
      if (response is String) {
        message = response;
      }
      if (response is List && response.isNotEmpty) {
        message = response.first.toString();
      }
      if (response != null && response is Map) {
        if (response["message"] != null)
          message = response["message"].toString();
        if (response["errors"] != null) {
          message = response["errors"].toString();
          if (response["errors"] is Map &&
              (response["errors"] as Map).isNotEmpty)
            message = (response["errors"] as Map).values.first.toString();
        }
        if (response["status"] != null) message = response["status"].toString();
      }

      if (message.isNotEmpty &&
          message.startsWith("[") &&
          message.endsWith("]"))
        message = message.substring(1, message.length - 2);
      return await showDialog(
          barrierDismissible: false,
          context: state.context,
          builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: LockAppDialog(message: message),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child:
                    Image.asset("lib/special/base_citenco/asset/image/ic_lockapp.png")),
            SizedBox(height: 10),
            Text(
                stringOf(() => message!).isNotEmpty
                    ? message!
                    : BaseTrans().$exitAppMess,
                textAlign: TextAlign.center,
                style: BasePKG().text!.smallLowerBold()),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareButton(
                  margin: BasePKG().zero,
                  padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
                  text: BaseTrans().$exitApp,
                  onTap: () => exit(0),
                  theme: BasePKG().button!.primaryButton(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
