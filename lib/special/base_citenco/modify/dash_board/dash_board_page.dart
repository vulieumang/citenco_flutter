import 'package:cnvsoft/special/base_citenco/extend/dashboard_extend/bottom_menu_view.dart';
import 'package:cnvsoft/special/base_citenco/extend/dashboard_extend/dashboard_extend_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dash_board_provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashBoardPageState();
}

class DashBoardPageState
    extends DashboardExtendPageState<DashBoardPage, DashBoardProvider> {
  // @override
  // BottomMenuStyle get menuStyle =>
  //     kDebugMode ? BottomMenuStyle.Bar : BottomMenuStyle.Standard;

  @override
  DashBoardProvider initProvider() => DashBoardProvider(this);
}
