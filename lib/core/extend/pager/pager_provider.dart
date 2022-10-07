import 'dart:io';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/core/extend/pager/pager_page.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class PagerProvider<T extends State> extends BaseProvider<T> {
  final PageController pageController = PageController();
  final PageNotifier _page = PageNotifier(0);
  final FirstPageNotifier _firstPage = FirstPageNotifier();
  final SecondPageNotifier _secondPage = SecondPageNotifier();
  final FirstTitleNotifier _firstTitle = FirstTitleNotifier();
  final SecondTitleNotifier _secondTitle = SecondTitleNotifier();
  final AnimationPageNotifier _animationPage = AnimationPageNotifier(0.0);

  PagerProvider(T state) : super(state) {
    pageController.addListener(() {
      animationPage = pageController.offset / (state as BaseView).size.width;
    });
    setDefaultSecondTitle().then(setSecondTitle);
    if (state is PagerPageState) {
      headerCtr = AnimationController(
          vsync: state, duration: Duration(milliseconds: 300));
      headerAni =
          CurvedAnimation(parent: headerCtr!, curve: Curves.fastOutSlowIn);
    }
    headerCtr?.forward();
  }

  List<BaseNotifier> initSubNotifiers();

  Animation<double>? headerAni;
  AnimationController? headerCtr;

  @override
  List<BaseNotifier> initNotifiers() => initSubNotifiers()
    ..addAll([
      _page,
      _firstPage,
      _secondPage,
      _firstTitle,
      _secondTitle,
      _animationPage
    ]);

  Future<String> setDefaultSecondTitle();

  int get page => _page.value!;

  set page(int value) => _page.value = value;

  PagerItem get first => _firstPage.value!;

  set first(PagerItem value) => _firstPage.value = value;

  PagerItem get second => _secondPage.value!;

  set second(PagerItem value) => _secondPage.value = value;

  String get firstTitle => _firstTitle.value!;

  set firstTitle(String value) =>
      _firstTitle.value = Utils.upperCaseFirst(value);

  String get secondTitle => _secondTitle.value!;

  set secondTitle(String value) =>
      _secondTitle.value = Utils.upperCaseFirst(value);

  double get animationPage => _animationPage.value!;

  set animationPage(double value) => _animationPage.value = value;

  @override
  void dispose() {
    headerCtr?.dispose();
    super.dispose();
  }

  void setFirst(String title, PagerItem pagerItem) {
    if (state.mounted) {
      first = PagerItem(
        child: pagerItem.child,
        onTap: pagerItem.onTap,
      );
      firstTitle = title;
    }
  }

  void setSecond(String title, PagerItem pagerItem) {
    if (state.mounted) {
      second = PagerItem(
        child: pagerItem.child,
        onTap: pagerItem.onTap,
      );
      secondTitle = title;
    }
  }

  void setFirstTitle(String text) => firstTitle = text;

  void setSecondTitle(String text) => secondTitle = text;

  void setPage(int value) {
    var _item = value == 0 ? first : second;
    if (_item.child == null) {
      (_item.onTap ?? () {})();
    } else {
      page = value;
    }
    headerCtr?.forward();
  }

  void jumpToPage(int value) {
    var _item = value == 0 ? first : second;
    if (_item.child == null) {
      (_item.onTap ?? () {})();
    } else {
      pageController.animateToPage(value,
          duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    }
  }

  bool get enablePageBar => true;

  bool scrollNotifer(ScrollUpdateNotification notification) {
    if (Platform.isIOS) {
      if (notification.dragDetails?.delta.dy != null) {
        Offset offset = notification.dragDetails!.delta;
        if (!headerCtr!.isAnimating &&
            offset.dy < notification.metrics.maxScrollExtent &&
            offset.dx == 0 &&
            notification.metrics.maxScrollExtent != 0) {
          if (offset.dy < 0) {
            headerCtr?.reverse();
          } else {
            headerCtr?.forward();
          }
        } else if (headerAni?.value == 0 &&
            !headerCtr!.isAnimating &&
            offset.dx == 0 &&
            offset.dy > 0) {
          headerCtr?.forward();
        }
      }
    }
    return true;
  }
}

class SearchLoadingNotifier extends BaseNotifier<bool> {
  SearchLoadingNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SearchLoadingNotifier>(create: (_) => this);
  }
}

class PageNotifier extends BaseNotifier<int> {
  PageNotifier(int value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<PageNotifier>(create: (_) => this);
  }
}

class AnimationPageNotifier extends BaseNotifier<double> {
  AnimationPageNotifier(double value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<AnimationPageNotifier>(create: (_) => this);
  }
}

class FirstPageNotifier extends BaseNotifier<PagerItem> {
  FirstPageNotifier() : super(PagerItem.init());

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<FirstPageNotifier>(create: (_) => this);
  }
}

class SecondPageNotifier extends BaseNotifier<PagerItem> {
  SecondPageNotifier() : super(PagerItem.init());

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SecondPageNotifier>(create: (_) => this);
  }
}

class FirstTitleNotifier extends BaseNotifier<String> {
  FirstTitleNotifier() : super("");

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<FirstTitleNotifier>(create: (_) => this);
  }
}

class SecondTitleNotifier extends BaseNotifier<String> {
  SecondTitleNotifier() : super("");

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SecondTitleNotifier>(create: (_) => this);
  }
}

class PagerItem {
  final Widget? child;
  final Function()? onTap;

  PagerItem({this.onTap, this.child});

  factory PagerItem.init() {
    return PagerItem(child: SizedBox());
  }
}
