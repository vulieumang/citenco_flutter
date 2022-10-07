import 'dart:async'; 

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/fcm/fcm.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/storage.dart'; 
import 'package:cnvsoft/special/base_citenco/dialog/bottom_dialog.dart';
import 'package:cnvsoft/special/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/special/base_citenco/dialog/undraw_dialog.dart'; 
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart'; 
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:cnvsoft/special/base_citenco/view/menu_list.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart'; 
import 'package:ms_undraw/ms_undraw.dart'; 
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

import 'bottom_menu_icon.dart';
import 'dashboard_extend_page.dart';

abstract class DashboardExtendProvider<T extends State>
    extends BaseProvider<T> {
  //notify
  final SizeTabBarNotifier _sizeTab = SizeTabBarNotifier();
  final IndexTabNotifier _indexTab = IndexTabNotifier();
  final LoadingAllNotifier _loadingAll = LoadingAllNotifier();
  final BottomMenuIconsNotifier _bottomMenuIcons = BottomMenuIconsNotifier();

  final PageController pageController = PageController();
  final GlobalKey tabKey = GlobalKey();
  final GlobalKey pageViewKey = GlobalKey();

  ShakeDetector? _shake;
  bool isShaked = false;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<DashboardTabItem>? dashboardItems;

  DateTime? backButtonPressTime;

  DashboardExtendProvider(T state) : super(state) {
    // _shake = ShakeDetector.autoStart(
    //     shakeThresholdGravity: 3.5,
    //     onPhoneShake: () {
    //       var userBarcode = MyProfile().userBarcode;
    //       if (userBarcode != null) Vibrate.vibrate();
    //       onShake();
    //     });
    dashboardItems = initPages();
    _bottomMenuIcons.value = initBottomMenu();
    FCM().init();
  }

  List<BottomMenuIcon> initBottomMenu() {
    DashboardExtendPageState state = this.state as DashboardExtendPageState;
    return List.generate(dashboardItems!.length, (index) {
      String image = dashboardItems?[index].image ??
          "lib/special/base_citenco/asset/image/tab_${1 + index}.svg";
      String imageActive = dashboardItems?[index].image ??
          "lib/special/base_citenco/asset/image/tab_${1 + index}_a.svg";
      return BottomMenuIcon(
          index, 
          onTap: () {
            if (dashboardItems?[index].onTap == null) {
              if (dashboardItems?[index].action == "contact" ) {
                showDialogSocialList();
              }else{
                navigate(index);
              }
            } else {
              dashboardItems![index].onTap!();
            }
          },
          name: dashboardItems![index].text,
          fillColor: true,
          hidden:  false,
          assetActive: imageActive,
          asset: image);
    });
  }

  void onScanHomePressed() {
    MyProfile().loginAuthentic(state, onShake);
  }

  int get indexTab => _indexTab.value!;

  int get lengthTab => _bottomMenuIcons.value!.length;

  Size get sizeTab => _sizeTab.value!;

  String get splashImage => "lib/special/modify/asset/image/splash.jpg";

  String get centerImage => this._bottomMenuIcons.value!.length > 0 ? this._bottomMenuIcons.value!.length == 3 ? this._bottomMenuIcons.value![1].asset! :  this._bottomMenuIcons.value!.length == 2 ? this._bottomMenuIcons.value![1].asset! :this._bottomMenuIcons.value!.length == 1? this._bottomMenuIcons.value![0].asset! :this._bottomMenuIcons.value![2].asset!:"";

  @override
  bool get allowNetwork => false;

  @override
  void dispose() async {
    // _shake!.stopListening();
    // hiện tại dùng để destroy giỏ hàng
    await PackageManager().serviceDestory(state);
    super.dispose();
  }

  List<DashboardTabItem> initPages() => [];

  @override
  BusProvider<DashboardData> initBus() =>
      BusProvider<DashboardData>.fromPackage(package: BasePKG(), listeners: {
        'navigate': (v) => navigate(v.data),
        'reward': (v) {
          navigate(1);
          Navigator.of(context!).pushNamed("reward_mine");
        },
        'profile': (v) => navigate(4),
        'showBarcode': (v) => onShake(),
        'getBottomBar': (v) => v.data(sizeTab),
        'showLoading': (v) => showLoading(),
        'hideLoading': (v) => hideLoading(),
        'hideLoadingAll': (v) => hideLoadingAll(),
        'hideSnack': (v) => hiddenSnack(),
        "dashboard_action": (v) => onActionDashboard(v),
        "request_login": (v) => requestLogin(v.data),
        "drawer": (v) => setEndDrawer(v.data),
        "openDrawer": (v) => checkDrawer(),
        "loadProfile": (v){ MyProfile().load(state);},
      });

  @override
  List<BaseNotifier> initNotifiers() => [
        _sizeTab,
        _indexTab,
        _loadingAll,
        _bottomMenuIcons,
      ]..addAll(initDashboardNotifiers());

  @override
  void onReady(callback) async {
    super.onReady(callback);
    updateSizeTab();
    preLoad();
    if (BaseScope().enableCommitDialog &&
        PackageManager().onlyInReviewVersion(state))
      UndrawDialog.show(
          state: state,
          message: BaseScope().commitMessage,
          undraw: UnDrawIllustration.reminder,
          title: BaseScope().commitTitle,
          close: BaseTrans().$iUnderstand);
    _loadBottomMenuItems();
    // hiện tại dùng để init giỏ hàng
    // await PackageManager().serviceInit(state);
    
  }
  
  hideLoadingAll() {
    _loadingAll.value = false;
  }

  onShake() async {
    if (!isShaked) {
      isShaked = true;
      await (state as DashboardExtendPageState).showBarcode();
      isShaked = false;
    }
  }

  requestLogin(context) async {
    if (context != null && context is BuildContext) {
      String current =
          BasePKG().stringOf(() => ModalRoute.of(context)?.settings.name);
      if (current.isNotEmpty) {
        if (current == "dash_board") {
          await MyProfile().logOut(state);
        } else {
          await StorageCNV().setBool("REQUEST_LOGIN", true);
          Navigator.of(context)
              .popUntil((t) => t.settings.name == "dash_board");
        }
      }
    }
  }

  Future<void> preLoad() async { 

    Future.delayed(Duration(milliseconds: 100))
        .then((value) => hideLoadingAll()); 
  }

  Future<void> sendUserDataCollection(int? customerId, String type, String os,
      String ip, String version, List<String> data) async {
    //TODO: ecommerce comment code PHP
    // await BasePKG.of(state).userDataCollection(
    //   customerId: customerId,
    //   type: type,
    //   os: os,
    //   ip: ip,
    //   version: version,
    //   data: [],
    // );
  }

  Future<bool> doubleBackPress() async {
    if (MyProfile().isGuest) {
      requestLogin(context);
    } else {
      DateTime now = DateTime.now();
      if (backButtonPressTime == null ||
          now.difference(backButtonPressTime!) > Duration(seconds: 2)) {
        backButtonPressTime = now;
        showSnack(BaseTrans().$backApp, seconds: 2);
        return Future.value(false);
      }
      await SystemNavigator.pop();
      return true;
    }
    return false;
  }

  _loadBottomMenuItems() {
    List<BottomMenuIcon> _icons = _bottomMenuIcons.value!;
    List<BottomMenuIcon> _items =
        BasePKG().listFrom(BaseScope().footerIcons, []);
    if (_items.isNotEmpty) {
      _items.forEach((element) {
        if (element.index != -1) {
          _icons[element.index!] = element;
        }
      });
    }

    _bottomMenuIcons.value = _icons + [];
  }

  onActionDashboard(DashboardData v) {
    String navigate = BasePKG().stringOf(() => v.data["navigate"]);
    String action = BasePKG().stringOf(() => v.data["action"]);
    dynamic payload = BasePKG().dataOf(() => v.data["payload"]);
    bool authenLogin = BasePKG().boolOf(() => v.data["authenLogin"]);
    bool authenPhone = BasePKG().boolOf(() => v.data["authenPhone"]);
    int scrollTo = BasePKG().intOf(() => v.data["index"], 2);

    Function() onTap = () {
      if (navigate.isNotEmpty) {
        if (navigate.startsWith('#')) {
          this.navigate(
              BasePKG().intOf(() => int.parse(navigate.replaceAll("#", ""))));
        } else {
          Navigator.of(context!).pushNamed(navigate, arguments: payload);
        }
      } else if (scrollTo != 2) {
        this.navigate(scrollTo);
      } else {
        if (action == "contact") showDialogSocialList();
        if (action == "show_barcode") onShake();
        if (action == "popup")
          showPopupMessage(
              BasePKG().stringOf(() => payload, BaseTrans().$blankPage, ['']));
      }
    };

    bool requiredLogin =
        (authenLogin) && PackageManager().onlyInReviewVersion(state);
    bool requiredPhone =
        (authenPhone) && PackageManager().onlyInReviewVersion(state);
    //execute
    if (requiredLogin) {
      MyProfile().loginAuthentic(state, onTap);
    } else if (requiredPhone) {
      MyProfile().phoneAuthentic(state, () {
        Navigator.popUntil(
            context!, (route) => route.settings.name == "dash_board");
        if (navigate.isNotEmpty) {
          if (PackageManager().existRoute(navigate)) {
            Navigator.of(context!).pushNamed(navigate, arguments: payload);
          } else if (navigate.startsWith('#')) {
            this.navigate(
                BasePKG().intOf(() => int.parse(navigate.replaceAll("#", ""))));
          }
        }
      });
    } else
      onTap();
  }

  //methods``
  void updateSizeTab() {
    if (tabKey.currentContext != null) {
      RenderStack? _render =
          tabKey.currentContext?.findRenderObject() as RenderStack;
      _sizeTab.value = _render.size;
    }
  }

  void navigate(int value) {
    _indexTab.value = value;
    pageController.jumpToPage(value);
  }

  Future<void> showPopupMessage(String msg) async {
    await MessageDialog.show(
        state, BasePKG().stringOf(() => msg, BaseTrans().$blankPage, ['']));
  }

  Future<void> showDialogSocialList() async {
    String hotLine = BasePKG().stringOf(() => StorageCNV().getString("HOT_LINE"));
    String linkFanpage =
        BasePKG().stringOf(() => StorageCNV().getString("LINK_FANPAGE"));
    String linkZalo =
        BasePKG().stringOf(() => StorageCNV().getString("LINK_ZALO"));
    String linkMessenger =
        BasePKG().stringOf(() => StorageCNV().getString("LINK_MESSENGER"));
    bool enableLinkFanPage =
        BasePKG().boolOf(() => StorageCNV().getBool("ENABLE_LINK_FANPAGE")) &&
            linkFanpage.isNotEmpty;
    bool enableLinkZalo = linkZalo.isNotEmpty;
    bool enableLinkMessenger = linkMessenger.isNotEmpty;
    bool enableHotLine;
    List<String> listHotline = [];
    if (hotLine.isNotEmpty && hotLine == "null") {
      enableHotLine = false;
    } else {
      enableHotLine = hotLine.isNotEmpty;
      listHotline = hotLine.split(",");
    }

    List<MenuItemCNV> menu = [];
    if (enableHotLine && listHotline.length > 0) {
      listHotline.forEach((hotline) => menu.add(MenuItemCNV(
          fillColor: true,
          imageType: ImageType.SVG,
          text: "Call: ${hotline.replaceAll(" ", "")}",
          image: "lib/special/base_citenco/asset/image/phone.svg",
          onTap: () {
            Navigator.of(context!).pop();
            Utils.launchURL("tel:$hotline");
          })));
    }
    if (enableLinkFanPage) {
      menu.add(MenuItemCNV(
          fillColor: false,
          imageType: ImageType.SVG,
          text: "Fanpage",
          image: "lib/special/base_citenco/asset/image/fbIcon.svg",
          onTap: () {
            Navigator.of(context!).pop();
            Utils.launchURL(linkFanpage);
          }));
    }
    if (enableLinkMessenger) {
      menu.add(MenuItemCNV(
          fillColor: false,
          imageType: ImageType.SVG,
          text: "Messenger",
          image: "lib/special/base_citenco/asset/image/ic_Messenger.svg",
          onTap: () {
            Navigator.of(context!).pop();
            Utils.launchURL(linkMessenger);
          }));
    }
    if (enableLinkZalo) {
      menu.add(MenuItemCNV(
          fillColor: false,
          imageType: ImageType.SVG,
          text: "Zalo",
          image: "lib/special/base_citenco/asset/image/zalo.svg",
          onTap: () {
            Navigator.of(context!).pop();
            Utils.launchURL(linkZalo);
          }));
    }

    if (menu.isEmpty)
      return MessageDialog.show(state, BaseTrans().$onlineConsultationError);
    else
      await BottomDialog.show(
          state,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[MenuListView(items: menu, hasTopline: false)],
          ));
  }

  void onTapFloatingAction() {
    BasePKG().dataOf(() {
      this._bottomMenuIcons.value![(this._bottomMenuIcons.value!.length == 3 ? 1 : this._bottomMenuIcons.value!.length == 5 ? 2 : 1)].onTap!();
    });
  }

  List<BaseNotifier> initDashboardNotifiers();

  void checkDrawer() {
    openDrawer();
  }
}

class SizeTabBarNotifier extends BaseNotifier<Size> {
  SizeTabBarNotifier() : super(Size.zero);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SizeTabBarNotifier>(create: (_) => this);
  }
}

class IndexTabNotifier extends BaseNotifier<int> {
  IndexTabNotifier() : super(0);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<IndexTabNotifier>(create: (_) => this);
  }
}

class LoadingAllNotifier extends BaseNotifier<bool> {
  LoadingAllNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<LoadingAllNotifier>(create: (_) => this);
  }
}

class BottomMenuIconsNotifier extends BaseNotifier<List<BottomMenuIcon>> {
  BottomMenuIconsNotifier() : super([]);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<BottomMenuIconsNotifier>(create: (_) => this);
  }
}

class DashboardTabItem {
  final String text;
  final Widget? page;
  final bool secureLogin;
  final String? image;
  final String? action;
  final String? navigate;
  final Function()? onTap;

  DashboardTabItem(
      {required String text,
      this.onTap,
      this.image,
      this.page,
      this.action,
      this.navigate,
      this.secureLogin: false})
      : this.text = Utils.upperCaseFullFirst(text);
}
