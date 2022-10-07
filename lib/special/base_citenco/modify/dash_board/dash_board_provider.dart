 
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart'; 
import 'package:cnvsoft/special/base_citenco/extend/dashboard_extend/dashboard_extend_provider.dart'; 
import 'package:cnvsoft/special/base_citenco/modify/home/home_page.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/page/blank/blank_page.dart';  
import 'package:flutter/material.dart'; 

class DashBoardProvider extends DashboardExtendProvider with DataMix {
  DashBoardProvider(State<StatefulWidget> state) : super(state);

  @override
  List<BaseNotifier> initDashboardNotifiers() => [];

  @override
  List<DashboardTabItem> initPages() {
    return <DashboardTabItem>[
      DashboardTabItem(text: "${BaseTrans().$home}", page: HomePage()),
      DashboardTabItem(text: "${BaseTrans().$favourite}", page: BlankPage()), 
    ];
  }
}
