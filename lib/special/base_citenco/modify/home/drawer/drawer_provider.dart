

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class HomeDrawerProvider extends BaseProvider<HomeDrawerState> {
  HomeDrawerProvider(HomeDrawerState state) : super(state){
     
  }

  @override
  List<BaseNotifier> initNotifiers() {
    return [];
  }

  late List<DrawerHome> data  = [
    DrawerHome("lib/special/base_citenco/asset/image/ic_starup.png", "${BaseTrans().$startup}",
    (){
      Navigator.pop(state.context);
      BasePKG().bus!.fire<DashboardChangeHome>( DashboardChangeHome("startup"));
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/investors.png", "${BaseTrans().$investors}",
    (){
      Navigator.pop(state.context);
      BasePKG().bus!.fire<DashboardChangeHome>( DashboardChangeHome("investor"));
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_slibar_investor.png", "${BaseTrans().$experts}",
    (){
      Navigator.pop(state.context);
      BasePKG().bus!.fire<DashboardChangeHome>( DashboardChangeHome("expert"));
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_incubator.png", "${BaseTrans().$incubator_program}",
    (){
      Navigator.pop(state.context);
      BasePKG().bus!.fire<DashboardChangeHome>( DashboardChangeHome("nursery"));
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_state_program.png", "${BaseTrans().$state_program}",
    (){
      Navigator.of(context!).pushNamed("blog", arguments: {
        "tag": "${BaseTrans().$state_program}",
        "article_category_id": "1215"
      });
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_conect_silbar.png", "${BaseTrans().$foreign_program}",
    (){
      Navigator.of(context!).pushNamed("blog", arguments: {
        "tag": "${BaseTrans().$foreign_program}",
        "article_category_id": "1216"
      });
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_info.png", "${BaseTrans().$information_communication}",
    (){
      Navigator.of(context!).pushNamed("blog", arguments: {
        "tag": "${BaseTrans().$information_communication}",
        "article_category_id": "1221"
      });
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_partner.png", "${BaseTrans().$partner_ecosystem}",
    (){
      Navigator.of(state.context).pushNamed("b");
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_map.png", "${BaseTrans().$innovation_map}",
    (){
      Navigator.of(state.context).pushNamed("b");
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_rank.png", "${BaseTrans().$popular_rank}",
    (){
      Navigator.of(state.context).pushNamed("b");
    }
    ),
    DrawerHome("lib/special/base_citenco/asset/image/ic_connect.png", "${BaseTrans().$connect_with}",
    (){
      Navigator.of(state.context).pushNamed("b");
    }
    ),
  ];

  List<DrawerHome> get dataCell => data;

  @override
  void onReady(callback) {
    // TODO: implement onReady
    super.onReady(callback);
    
  }

}

class DrawerHome{

  String? asset;
  String? name;
  Function()? onTapString;

  DrawerHome(this.asset,this.name,this.onTapString);
}