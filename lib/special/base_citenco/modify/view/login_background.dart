import 'package:cnvsoft/special/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final bool? value;

  const LoginBackground({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              ModifyPKG().color.loginStart,
              ModifyPKG().color.loginStart,
              ModifyPKG().color.loginStart,
            ])),
      ),
    );
  }
}
