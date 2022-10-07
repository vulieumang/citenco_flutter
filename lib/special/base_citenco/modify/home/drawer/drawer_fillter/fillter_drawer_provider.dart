

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'fillter_drawer.dart';

class FillterDrawerProvider extends BaseProvider<FillterDrawerState> {
  FillterDrawerProvider(FillterDrawerState state) : super(state);
  final IndexTabSelectedNotifier _indexTabSelected = IndexTabSelectedNotifier();
  PageController pageController = PageController();

  final DemandNotifier _demandNotifier= DemandNotifier(0);

  var listTabBodyInfo = [
    ["${BaseTrans().$startup}", ""],
    ["${BaseTrans().$investors}", ""],
    ["${BaseTrans().$nursery}", ""],
  ];

  @override
  List<BaseNotifier> initNotifiers() {
    return [_indexTabSelected,_demandNotifier];
  }
  
  List<DrawerHome> data = [
    DrawerHome("lib/special/base_citenco/asset/image/ic_starup.png", "${BaseTrans().$startup}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/investors.png", "${BaseTrans().$investors}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_incubator.png", "${BaseTrans().$incubator_program}","nursery_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_state_program.png", "${BaseTrans().$state_program}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_info.png", "${BaseTrans().$information_communication}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_partner.png", "${BaseTrans().$partner_ecosystem}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_map.png", "${BaseTrans().$innovation_map}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_rank.png", "${BaseTrans().$popular_rank}","startup_page"),
    DrawerHome("lib/special/base_citenco/asset/image/ic_connect.png", "${BaseTrans().$connect_with}","startup_page"),
  ];

  onTabChange(int index) {
    _indexTabSelected.value = index;
    pageController.animateToPage(index,
            duration: Duration(milliseconds: 10),
            curve: Curves.slowMiddle)
        .then((value) {
    });
  }

  String getDemand(int index) {
    switch (index) {
      case 0:
        return "Có";
      case 1:
        return "Không";
      default:
        return "Không";
    }
  }
  void onStartPressed() async {
    if(_indexTabSelected.value == 0){
      Navigator.pop(context!);
      Navigator.pushReplacementNamed(context!, "startup_page", arguments: {
        "isFillter": true,
        "isShowMenu": false,
      });
    }else if(_indexTabSelected.value == 0){
      Navigator.pop(context!);
      Navigator.pushReplacementNamed(context!, "investor_page", arguments: {
        "isFillter": true
      });
    }else{
      Navigator.pop(context!);
      Navigator.pushReplacementNamed(context!, "nursery_page", arguments: {
        "isFillter": true
      });
    }
  }

  void setDemand(int index) {
    _demandNotifier.value = index;
  }

  TextStyle buttonTextStyle(int tabIndex) {
    return BasePKG().text!.normalLowerNormal().copyWith(
        color: _indexTabSelected.value == tabIndex
            ? Colors.white
            : Color(0xff53587A));
  }

  Decoration buttonDecoration(int tabIndex) {
    return BoxDecoration(
        color: _indexTabSelected.value == tabIndex
            ? BasePKG().color.primaryColor
            : Colors.white,
        border: Border.all(color: _indexTabSelected.value == tabIndex ? BasePKG().color.primaryColor : Colors.transparent),
        borderRadius: BorderRadius.circular(26));
  }
  
  Decoration buttonDecorationNew(int tabIndex) {
    return BoxDecoration(
        color: _indexTabSelected.value == tabIndex
            ? Color(0xff0D2A5C)
            : Color(0xff0D2A5C).withOpacity(.08),
        borderRadius: BorderRadius.circular(4));
  }
}

class DrawerHome{

  String? asset;
  String? name;
  String? onTapString;

  DrawerHome(this.asset,this.name,this.onTapString);
}

class DemandNotifier extends BaseNotifier<int> {
  DemandNotifier(int? value) : super(0);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<DemandNotifier>(create: (_) => this);
  }
}


class IndexTabSelectedNotifier extends BaseNotifier<int> {
  IndexTabSelectedNotifier() : super(0);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<IndexTabSelectedNotifier>(
        create: (_) => this);
  }
}