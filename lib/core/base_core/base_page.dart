import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_appbar.dart';
import 'base_provider.dart';
import 'base_view.dart';

abstract class BasePage<S extends StatefulWidget, T extends BaseProvider>
    extends BaseView<S, T> with RouteAware {
  Widget body();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  PreferredSizeWidget get netWorkAppBar => AppBarData(context).netWork();
  AppBarData? appBar;
  Widget? floatingActionButton;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  FloatingActionButtonAnimator? floatingActionButtonAnimator;
  List<Widget>? persistentFooterButtons;
  Widget? drawer;
  Widget? bottomNavigationBar;
  Widget? bottomSheet;

  // bool? resizeToAvoidBottomPadding;
  bool? resizeToAvoidBottomInset;
  bool isPrimary = true;
  DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start;
  bool extendBody = false;
  bool extendBodyBehindAppBar = false;
  Color? drawerScrimColor;
  double? drawerEdgeDragWidth;

  PreferredSizeWidget? buildAppbar() => null;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: provider.providers,
      child: Stack(children: [
        buildBackground(),
        // Container(color: BasePKG().color.background),
        GestureDetector(
          child: _buildScaffold(),
          onTap: provider.hideKeyboard,
        ),
        buildFrontground(),
        buildLoading()
      ]),
    );
  }

  _buildScaffold() {
    return Consumer3<NetWorkNotifier, AppbarNotifier, EndDrawerNotifier>(
        builder: (ctx, netWork, showAppBar, endDrawer, _) {
      return Scaffold(
          key: scaffoldKey,
          appBar: ((netWork.value! || !provider.allowNetwork)
              ? buildAppbar() ??
                  ((!showAppBar.value! || appBar == null)
                      ? null
                      : appBar?.parse())
              : netWorkAppBar),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer:  SizedBox(
            width: size.width,
            child: Drawer(child: endDrawer.value,)),
          endDrawer: endDrawer.value,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: isPrimary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          body: DefaultTextStyle(
            style: TextStyle(color: BasePKG().color.text,fontFamily: BasePKG().text!.fontFamily),
            child: lazyBody()
          ));
    });
  }

  Widget buildFrontground() => SizedBox();

  Widget buildBackground() => Container(color: Colors.white);

  Widget lazyBody() => Stack(
        children: [body(), buildLazyLoad()],
      );

  @override
  void dispose() {
    Config.routeObserver.unsubscribe(this);
    provider.disposeNetwork();
    super.dispose();
  }

  @override
  void didPop() {
    super.didPop();
    print("${this.runtimeType} didPop");
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print("${this.runtimeType} didPushNext");
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print("${this.runtimeType} didPopNext");
  }

  @override
  void didPush() {
    super.didPush();
    print("${this.runtimeType} didPush");
  }

  @override
  void initState() {
    super.initState();
    provider.initNetwork();
  }
}
