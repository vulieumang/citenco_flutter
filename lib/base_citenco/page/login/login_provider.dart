import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/base_citenco/package/level_asset.dart';
import 'package:cnvsoft/core/multiasync.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class LoginProvider extends BaseProvider<LoginPageState> {
  LoginProvider(LoginPageState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() => [
        _changeShowPassNotifier,
        _checkPassNotifier,
        _checkPhoneNotifier,
      ];

  bool hidePassword = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var phoneError = 'Số điện thoại không hợp lệ';
  var usernameError = 'Tên đăng nhập không hợp lệ';
  var passwordError = 'Mật khẩu không hợp lệ';
  var phoneInvalid = false;
  var passInvalid = false;
  final textFieldFocusNode = FocusNode();

  CheckPassNotifier _checkPassNotifier = CheckPassNotifier();
  CheckPhoneNotifier _checkPhoneNotifier = CheckPhoneNotifier();
  ChangeShowPassNotifier _changeShowPassNotifier = ChangeShowPassNotifier();

  @override
  Future<void> onReady(callback) async {
    LevelAsset().initialize();
    Future.delayed(Duration(seconds: 1), () {
      loginBySaved();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showPassword() {
    _changeShowPassNotifier.value = !_changeShowPassNotifier.value!;
    if (textFieldFocusNode.hasPrimaryFocus)
      return; // If focus is on text field, dont unfocus
    textFieldFocusNode.canRequestFocus = false;
  }

  onChangePhone() {
    _checkPhoneNotifier.value = false;
  }

  onChangePass() {
    _checkPassNotifier.value = false;
  }

  Future<void> onClickSignIn() async {
    //validate phone
    super.hideKeyboard();
    if (passwordController.text.isNotEmpty && phoneController.text.isNotEmpty) {
      showLoading();
      var res = await BasePKG.of(state)
          .loginApi(phoneController.text, passwordController.text);
      hideLoading();
      if (res.data.code == 200) {
        await StorageCNV().setString("AUTH_TOKEN", res.data.data.token);
        await StorageCNV().setString("PHONE_NUMBER", res.data.data.token);
        await StorageCNV().setString("FULL_NAME", res.data.data.fullName);
        Navigator.of(state.context).pushReplacementNamed("dash_board");
      }
      _checkPassNotifier.value = true;
      _checkPhoneNotifier.value = true;
    } else {
      _checkPassNotifier.value = true;
      _checkPhoneNotifier.value = true;
    }
  }

  void loginBySaved() async {}
}

class CheckPassNotifier extends BaseNotifier<bool> {
  CheckPassNotifier() : super(false);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<CheckPassNotifier>(create: (_) => this);
  }
}

class CheckPhoneNotifier extends BaseNotifier<bool> {
  CheckPhoneNotifier() : super(false);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<CheckPhoneNotifier>(create: (_) => this);
  }
}

class ChangeShowPassNotifier extends BaseNotifier<bool> {
  ChangeShowPassNotifier() : super(false);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<ChangeShowPassNotifier>(create: (_) => this);
  }
}
