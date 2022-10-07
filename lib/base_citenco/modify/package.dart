import 'package:cnvsoft/base_citenco/page/home/home_page.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/scan_car_page.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/temporary_car_page.dart';
import 'package:cnvsoft/core/bus.dart';
import 'package:cnvsoft/core/http.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/package/color_style.dart';
import 'package:cnvsoft/base_citenco/package/package.dart'; 
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:flutter/material.dart';

import 'dash_board/dash_board_page.dart';

class ModifyPKG extends BasePackage {
  static ModifyPKG? _internal;
  static Map<State, ModifyContext> _context = Map();
  ModifyPKG._();

  factory ModifyPKG() {
    if (_internal == null) {
      _internal = ModifyPKG._()..bus = Bus([]);
      _internal?.initStyle();
    }
    return _internal!;
  }

  static ModifyContext of(State state) {
    if (_context[state] == null) {
      _context[state] = ModifyContext.of(state);
    }
    return _context[state]!;
  }

  @override
  Map<String, Function(dynamic arg)> getPages() {
    return {
      // "dash_board": (arg) => DashBoardPage(), 
      "dash_board": (arg) => HomePage(), 
      // "dash_board": (arg) => ScanCarPage(), 
      // "dash_board": (arg) => TemporaryCarPage(), 
    };
  }

  @override
  ModifyColor get color => ModifyColor();
}

class ModifyContext extends Context {
  ModifyContext();

  factory ModifyContext.of(State state) {
    return ModifyContext()..http = Http(state: state, factories: {});
  }
}

class ModifyColor extends ColorStyle {
  @override
  Color get textPrimaryButton => Colors.white;

  @override
  Color get backgroundPrimaryButton => primaryColor;

  @override
  Color get textNegativeButton => Colors.black;

  @override
  Color get backgroundNegativeButton => Color(0xffE3E3E3);

  @override
  Color get textAlternaiveButton => primaryColor;

  @override
  Color get backgroundAlternativeButton => Colors.white;

  @override
  Color get pagerTitleBackground => accentColor;

  @override
  Color get pagerTitleSelected => Color(0xFFFFD714);

  @override
  Color get pagerTitleUnselected => Color(0xFFFFFFFF);
  Color mainTextColor = Color(0xFF616773);
  Color primaryColor = Color(0xff2D9CEC);
  Color primaryColor1 = Color(0xff2D9CEC);
  Color iconColor = Color(0xff0D2A5C);
  Color accentColor = Color(0xff0D2A5C);
  Color colorHeader = Color(0xff011029);
  Color colorIconAppBar = Color(0xffffffff); 

  Color darkPrimaryColor = Color(0xff000000);
  Color hightLight = Color(0xfffffff);

  //tab
  Color tabSelected = Color(0xff2D9CEC);

  Color get warning => Color(0xffF4BC06);
  Color get applied => Color(0xff3BB54A);

  //login
  Color loginStart = Color(0xffFFFFFF);
  Color loginMiddle = Color(0xffFFFFFF);
  Color loginEnd = Color(0xffFFFFFF);

  Color backgroundLoginButton = Color(0xff2D9CEC);

  //home
  Color homeHeaderStart = Color(0xff307DC0);
  Color homeHeaderMiddle = Color(0xff10B79D);
  Color homeHeaderEnd = Color(0xff307DC0);

  //tab bar
  Color tabBarMainIn = Color(0xff2D9CEC);
  Color tabBarMainOut = Color(0xff2D9CEC);

  Color arrowReward = Color(0xff2D9CEC);
}
