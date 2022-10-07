import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:cnvsoft/special/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SquareButton(
      text: "Đăng Nhập Bằng ${BaseTrans().$phonenumber}",
      theme: ModifyPKG().button?.loginButton(context),
      onTap: () => Navigator.of(context).pushNamed("login_phone"),
    );
  }
}
