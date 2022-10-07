import 'dart:async';

import 'package:cnvsoft/core/bus.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/special/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/modify/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'base_handler.dart';
import 'base_model.dart';
import 'base_notifier.dart';
import 'base_page.dart';

abstract class BaseProvider<T extends State> {
  final T? _state;

  BusProvider? _bus, _exBus;

  //default notifiers
  final LoadingNotifier _loadingNotifier = LoadingNotifier(false);
  final IgnoringNotifier _ignoringNotifier = IgnoringNotifier(false);
  final NetWorkNotifier _netWork = NetWorkNotifier(true);
  final AppbarNotifier _appbar = AppbarNotifier(true);
  final LazyLoadNotifier _lazyLoad = LazyLoadNotifier();
  final EndDrawerNotifier _endDrawer = EndDrawerNotifier(null);

  //network checker
  final Connectivity connectivityResult = Connectivity();
  StreamSubscription<ConnectivityResult>? subscription;

  bool get allowNetwork => true;

  bool? get hasNetwork => _netWork.value;

  bool get hasDrawer => _endDrawer.value != null;

  BaseProvider(this._state) {
    _bus = initBus();
    _bus?.init();

    _exBus = initExBus();
    _exBus?.init();
  }

  void dispose() {
    _bus?.dispose();
    _exBus?.dispose();
  }

  BuildContext? get context => _state?.context;

  bool get mounted => _state?.mounted ?? false;

  T get state => _state!;

  //defaul methods
  void hideKeyboard() => FocusScope.of(context!).requestFocus(FocusNode());

  void showLoading() {
    if (mounted) _loadingNotifier.value = true;
  }

  void hideLoading() {
    if (mounted) _loadingNotifier.value = false;
  }

  void startIgnoring() {
    if (mounted) _ignoringNotifier.value = true;
  }

  void endIgnoring() {
    if (mounted) _ignoringNotifier.value = false;
  }

  void onReady(callback) {
    var _route = ModalRoute.of(context!);
    if (state is RouteAware && _route is PageRoute) {
      Config.routeObserver.subscribe(state as RouteAware, _route);
    }
  }

  void hiddenSnack() =>
      ScaffoldMessenger.of(state.context).hideCurrentSnackBar();

  void showSnack(String? message,
      {SnackBarAction? action,
      String? label,
      dynamic route,
      int? seconds,
      Color? background}) {
    if (_state is BasePage) {
      ScaffoldMessenger.of(state.context).showSnackBar(new SnackBar(
        content: new Text(message ?? "",
            textAlign: label == null ? TextAlign.center : TextAlign.left,
            style: TextStyle(color: ModifyPKG().color.snackBarText)),
        backgroundColor: background ?? ModifyPKG().color.accentColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds ?? 4),
        action: action ??
            (label == null
                ? null
                : SnackBarAction(
                    textColor: ModifyPKG().color.snackBarText,
                    label: label,
                    onPressed: () {
                      Navigator.of(state.context).pushNamed(route);
                    })),
      ));
      Future.delayed(Duration(seconds: seconds ?? 4), () {
        ScaffoldMessenger.of(state.context).hideCurrentSnackBar();
      });
    }
  }

  void showSnackError(String message, {arguments}) {
    if (_state is BasePage) {
      ScaffoldMessenger.of(state.context).showSnackBar(new SnackBar(
        content: new Text(message,
            textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),
        backgroundColor: ModifyPKG().color.error,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            textColor: Colors.white,
            label: "${BaseTrans().$viewMore}",
            onPressed: () async {
              await Navigator.of(context!)
                  .pushNamed("error", arguments: arguments);
              hiddenSnack();
            }),
      ));
    }
  }

  Future loading(Function function,
      {bool hide: false, LoadingHandler? handler}) async {
    try {
      hideKeyboard();
      if (!hide) {
        if (state.mounted) {
          if (handler != null)
            handler.onShowLoading!();
          else
            showLoading();
        }
      }
      var result = await function();
      if (state.mounted && !hide) {
        if (handler != null)
          handler.onHideLoading!();
        else
          hideLoading();
      }
      return result;
    } catch (e) {
      if (handler != null) handler.onHideLoading!();
      hideLoading();
    }
  }

  Future ignoring(Function function) async {
    try {
      startIgnoring();
      var result = await function();
      if (state.mounted) {
        endIgnoring();
      }
      return result;
    } catch (e) {
      endIgnoring();
    }
  }

  List<ListenableProvider> get providers => ((initNotifiers() ?? [])
        ..addAll([
          _loadingNotifier,
          _ignoringNotifier,
          _netWork,
          _appbar,
          _lazyLoad,
          _endDrawer
        ]))
      .map<ListenableProvider>((n) => n.provider())
      .toList();

  BusProvider initBus() => BusProvider.empty();

  BusProvider initExBus() => BusProvider.empty();

  //abstract methods
  List<BaseNotifier>? initNotifiers();

  Future<void> handleError(BaseModel? response) async {
    if (response != null && response.error != null)
      return MessageDialog.showErrors(state, response.error);
  }

  void initNetwork() async {
    if (BaseScope().allowNetwork) {
      _initConnectivity();
    }
  }

  void disposeNetwork() {
    if (subscription != null) subscription?.cancel();
  }

  void _updateConnectionStatus(ConnectivityResult? result) {
    bool _hasNetwork = true;
    switch (result) {
      case ConnectivityResult.wifi:
        _hasNetwork = true;
        break;
      case ConnectivityResult.mobile:
        _hasNetwork = true;
        break;
      case ConnectivityResult.none:
        _hasNetwork = false;
        break;
      default:
        _hasNetwork = false;
        break;
    }
    _netWork.value = _hasNetwork;
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    subscription = connectivityResult.onConnectivityChanged
        .listen(_updateConnectionStatus);
    try {
      result = await connectivityResult.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  void openDrawer() {
    (_state as BasePage).scaffoldKey.currentState?.openDrawer();
  }

  void openEndDrawer() {
    (_state as BasePage).scaffoldKey.currentState?.openEndDrawer();
  }

  void showAppBar() {
    _appbar.value = true;
  }

  void hideAppBar() {
    _appbar.value = false;
  }

  void showLazyLoad() {
    _lazyLoad.value = true;
  }

  Future<void> hideLazyLoad({int? second = 0}) async {
    await Future.delayed(Duration(milliseconds: second!)).then((value) {
      _lazyLoad.value = false;
    });
  }

  void setEndDrawer(Widget? child) {
    _endDrawer.value = child;
  }
}

class BusProvider<T extends BusData> {
  final Bus? _bus;
  final String? key;

  Map<String, Function(T)>? listeners = {};

  BusProvider(this._bus, {this.key, this.listeners});

  factory BusProvider.empty() => BusProvider(null);

  factory BusProvider.fromPackage(
          {required BasePackage? package,
          String? key,
          required Map<String, Function(T)>? listeners}) =>
      BusProvider(package?.bus, listeners: listeners, key: key);

  bool get available => _bus != null;

  void dispose() {
    if (available) _bus?.destroy<T>(key: key);
  }

  void init() {
    if (available) _bus?.listen(listen: listeners, key: key);
  }
}

class NetWorkNotifier extends BaseNotifier<bool> {
  NetWorkNotifier(bool value) : super(value);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<NetWorkNotifier>(create: (_) => this);
  }
}

class AppbarNotifier extends BaseNotifier<bool> {
  AppbarNotifier(bool value) : super(value);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<AppbarNotifier>(create: (_) => this);
  }
}

class LazyLoadNotifier extends BaseNotifier<bool> {
  LazyLoadNotifier() : super(false);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<LazyLoadNotifier>(create: (_) => this);
  }
}

class EndDrawerNotifier extends BaseNotifier<Widget?> {
  EndDrawerNotifier(Widget? value) : super(value);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<EndDrawerNotifier>(create: (_) => this);
  }
}
