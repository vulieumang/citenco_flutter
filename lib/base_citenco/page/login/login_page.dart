import 'dart:typed_data';

import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePage<LoginPage, LoginProvider> with DataMix {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context,
        height: 50,
        title: Text(
          "Quản lý xe ra vào trạm",
          style: BasePKG().text!.normalNormal().copyWith(color: Colors.white),
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }

  @override
  LoginProvider initProvider() => LoginProvider(this);
  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Consumer3<ChangeShowPassNotifier, CheckPassNotifier,
                CheckPhoneNotifier>(
            builder: (context, showPass, checkPass, checkPhone, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                  child: Image.asset('lib/base_citenco/asset/image/logo.png'),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    controller: provider.phoneController,
                    onChanged: ((value) {
                      provider.onChangePhone();
                    }),
                    decoration: InputDecoration(
                      errorText: checkPhone.value! ? provider.phoneError : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'SĐT',
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextField(
                        controller: provider.passwordController,
                        focusNode: provider.textFieldFocusNode,
                        obscureText: showPass.value! ? true : false,
                        onChanged: ((value) {
                          provider.onChangePass();
                        }),
                        decoration: InputDecoration(
                          errorText:
                              checkPass.value! ? provider.passwordError : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: 'Mật khẩu',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                      child: GestureDetector(
                          onTap: provider.showPassword,
                          child: Icon(
                            showPass.value!
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 24,
                          )),
                    ),
                  ],
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Đăng nhập'),
                      onPressed: provider.onClickSignIn,
                    )),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Quên mật khẩu?',
                //     style: TextStyle(color: Colors.grey[600]),
                //   ),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
