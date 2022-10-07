
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/page/home/drawer/drawer.dart'; 
import 'package:cnvsoft/base_citenco/page/home/home_lazy.dart'; 
import 'package:cnvsoft/base_citenco/page/home/home_provider.dart'; 
import 'package:cnvsoft/base_citenco/package/package.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cnvsoft/core/base_core/base_page.dart'; 

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePage<HomePage, HomeProvider> with DataMix {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context);
  }

  @override
  HomeProvider initProvider() => HomeProvider(this);
  

  @override
  Widget buildBackground() {
    return Container(color: Colors.white);
  }

  @override
  Widget body() {
    return HomePage1(); 
  }

  RefreshIndicator HomePage1() {
    return RefreshIndicator(
      key: provider.refreshIndicator,
      onRefresh: provider.onRefresh,
      color: BasePKG().color.primaryColor,
      child: SingleChildScrollView(
        child: Column(children: [ 
           
        ]),
      ));
  }

  @override
  Widget lazyLoad(bool visible) {
    return HomeLazy(
        this,
        visible,
      );
  }
}
