import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'confirm_dialog.dart';

class RequestLoginDialog {
  static show(State state, {bool requiredBack = true}) async {
    return ConfirmDialog.show(state,
        msg: BaseTrans().$mustLogin, barrierDismissible: false, onNegative: () {
      if (requiredBack) Navigator.of(state.context).pop();
    }, onPositive: () async {
      BasePKG().bus!.fire<DashboardData>(
          DashboardData("request_login", data: state.context));
    });
  }
}
