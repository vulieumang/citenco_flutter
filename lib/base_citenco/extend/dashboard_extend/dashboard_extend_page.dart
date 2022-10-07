import 'dart:math';

import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'bottom_menu_view.dart';
import 'dashboard_extend_provider.dart';

abstract class DashboardExtendPageState<T extends StatefulWidget,
        S extends DashboardExtendProvider> extends BasePage<T, S>
    with TickerProviderStateMixin {
  @override
  FloatingActionButtonLocation get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked; 
  
  @override
  Widget get bottomNavigationBar => _buildBottomTabBar();

  @override
  bool get extendBody => true;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  double? get drawerEdgeDragWidth => 0.0;

  @override
  Widget buildBackground() => Container(color: BasePKG().color.background);

  @override
  void didPopNext() async {
    super.didPopNext();
    bool requestLogin = StorageCNV().getBool("REQUEST_LOGIN") ?? false;
    if (requestLogin) {
      StorageCNV().remove("REQUEST_LOGIN");
      await Future.delayed(Duration(milliseconds: 300));
      await MyProfile().logOut(this);
    } else {
      // PackageManager().checkScopeInfo(this,
      //     onShowUpdate: () => UpdateVersionDialog.show(this),
      //     onContinue: () async {
      //     });
    }
  }

  @override
  Widget body() {
    return Center(
      child: WillPopScope(
        child: _buildMain(),
        onWillPop: provider.doubleBackPress,
      ),
    );
  }

  _buildMain() {
    return Stack(
      children: <Widget>[_buildContent(), _buildLoadingAll()],
    );
  }
 
  _buildBottomTabBar() {
    return Consumer3<IndexTabNotifier, LoadingAllNotifier,
        BottomMenuIconsNotifier>(
      builder: (context, indextab, loadingAll, icons, child) {
        return Opacity(
          opacity: loadingAll.value! ? 0 : 1,
          child: BottomMenuView(
            items: icons.value,
            selected: indextab.value,
            count: provider.dashboardItems!.length,
            color: BasePKG().color.primaryColor,
            selectedColor: BasePKG().color.primaryColor,
            backgroundColor: BasePKG().color.tabBarMain,
            style: 1,
          ),
        );
      },
    );
  }

  _buildLoadingAll() {
    return Consumer<LoadingAllNotifier>(
      builder: (context, value, _) {
        return Visibility(
            visible: value.value!,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                  color: BasePKG().color.card,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(provider.splashImage))),
            ));
      },
    );
  }

  Future<void> showBarcode() async {
    // var userBarcode = MyProfile().userBarcode;
    // if (userBarcode == null) return;
    await Navigator.of(context).pushNamed("accumulate_points");
  }

  _buildContent() {
    return Consumer<SizeTabBarNotifier>(
      builder: (context, value, child) {
        return Padding(
            padding: EdgeInsets.only(bottom:0),
            child: provider.pageViewKey.currentWidget ??
                PageView.builder(
                  key: provider.pageViewKey,
                  controller: provider.pageController,
                  itemCount: provider.dashboardItems!.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return provider.dashboardItems![index].page!;
                  },
                ));
      },
    );
  }


  Widget _buildNetworkIcon(String asset, double size, Color color) {
    return asset.endsWith(".svg")
        ? _buildSVGIcon(asset, size, color, network: true)
        : _buildPNGIcon(asset, size, color, network: true);
  }

  Widget _buildAssetIcon(String asset, double size, Color color) {
    return asset.endsWith(".svg")
        ? _buildSVGIcon(asset, size, color)
        : _buildPNGIcon(asset, size, color);
  }

  Widget _buildSVGIcon(String asset, double size, Color color,
      {bool network: false}) {
    return network
        ? FadeInImageView.fromSize(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: color,
          )
        : SvgPicture.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: color,
          );
  }

  Widget _buildPNGIcon(String asset, double size, Color color,
      {bool network: false}) {
    return network
        ? FadeInImageView.fromSize(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            // color: color,
          )
        : Image.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            // color: color,
          );
  }
}
