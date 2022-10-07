import 'dart:async';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'load_more_animation.dart';
import 'load_more_page.dart';

enum LoadingStatus { None, Refreshing, LoadingMore, Fetching }

abstract class LoadMoreProvider<R extends State, T> extends BaseProvider<R> {
  LoadMoreAnimation? loadMore;
  AnimationController? _loginCtrl;
  CurvedAnimation? _loginAni;
  final LoadingStatusNotifier _loadingStatus = LoadingStatusNotifier();
  final EmptyNotifier _empty = EmptyNotifier();
  final ShowScrollToTop _showScrollToTop = ShowScrollToTop();
  final ISScrollToTop _iSScrollToTop = ISScrollToTop();
  final GlobalKey<RefreshIndicatorState> refreshIndicator =
      GlobalKey<RefreshIndicatorState>();

  bool enableRefresh = true;
  bool showEmpty = true;
  bool showButtonScrollTop = false;
  bool _isScroll = true;

  List<T> _list = [];

  LoadMoreProvider(R state) : super(state) {
    loadMore = LoadMoreAnimation(state as TickerProviderStateMixin,
        onLoadMore: onLoadMore,
        onRemoveItem: onRemoveItem,
        onMounted: () => state.mounted,
        onScroll: onScroll);
    _loginCtrl = AnimationController(
        vsync: state as LoadMoreViewState,
        duration: Duration(milliseconds: 200));
    _loginAni =
        CurvedAnimation(curve: Curves.easeInOutCirc, parent: _loginCtrl!);
  }

  Future<List<T>> onFetchByAPI();
  // Future<dynamic> onScroll();

  Future<List<T>> onRefreshByAPI();

  Future<List<T>> onLoadMoreByAPI();

  CurvedAnimation get loginAnimation => _loginAni!;

  int get count => _list.length;

  List<T> get list => _list;

  bool get isScroll => _iSScrollToTop.value!;

  set setIsScroll(bool isScroll) => _iSScrollToTop.value = isScroll;

  LoadingStatus get loadingStatus => _loadingStatus.value!;

  set loadingStatus(LoadingStatus value) => _loadingStatus.value = value;

  bool get empty => _empty.value!;

  set empty(bool value) => _empty.value = value;

  @override
  void dispose() {
    _loginCtrl?.dispose();
    super.dispose();
  }

  @override
  List<BaseNotifier> initNotifiers() => initSubNotifiers()
    ..addAll([_loadingStatus, _empty, _showScrollToTop, _iSScrollToTop]);

  List<BaseNotifier> initSubNotifiers();

  bool get isRefreshingStatus => loadingStatus == LoadingStatus.Refreshing;

  bool get isNoneStatus => loadingStatus == LoadingStatus.None;

  bool get isLoadingMoreStatus => loadingStatus == LoadingStatus.LoadingMore;

  void onRemoveItem(int index) => _list.removeAt(index);

  void onListChanged(List<T> list) => print("Total: ${list.length}");

  Future<void> onFetch({bool? hideLoading = false}) async {
    return await loading(() async {
      //clear old data
      loadingStatus = LoadingStatus.Fetching;
      var _items = await onFetchByAPI();

      onListChanged(_items);

      if (state.mounted) loadMore?.clear(getCount());

      for (int i = 0; i < _items.length; i++) {
        var _item = _items[i];
        _list.add(_item);
        if (state.mounted)
          loadMore!.key.currentState!.insertItem(_list.length - 1,
              duration: Duration(milliseconds: 100 * (i + 1)));
      }

      if (mounted) {
        loadMore?.lockLoadMore = false;
        // loadMore.lockLoadMore = !showNewest;
        empty = _items.length == 0;
        loadingStatus = LoadingStatus.None;

        if (MyProfile().isGuest) _loginCtrl?.forward();
      }

      onCompleted();
    }, hide: hideLoading ?? false);
  }

  Future<void> onRefresh() async {
    if (isNoneStatus) {
      loadingStatus = LoadingStatus.Refreshing;
      var _items = await onRefreshByAPI();

      onListChanged(_items);

      if (state.mounted) loadMore?.clear(getCount());

      for (int i = 0; i < _items.length; i++) {
        var _item = _items[i];
        _list.add(_item);
        if (state.mounted)
          loadMore?.key.currentState?.insertItem(_list.length - 1,
              duration: Duration(milliseconds: 100 * (i + 1)));
      }

      if (mounted) {
        loadMore?.lockLoadMore = false;
        // loadMore.lockLoadMore = !showNewest;
        empty = _items.length == 0;
        loadingStatus = LoadingStatus.None;

        if (MyProfile().isGuest) _loginCtrl?.forward();
      }

      onCompleted();
    }
  }

  void onReplaceItem(T item, bool Function(T t1, T t2) isEquals) async {
    if (state.mounted)
      for (int i = 0; i < _list.length; i++) {
        if (isEquals(item, _list[i])) {
          _list[i] = item;
          loadMore?.key.currentState
              ?.removeItem(i, (_, __) => Container(height: 1));
          loadMore?.key.currentState?.insertItem(i);
        }
      }
  }

  T? findItem(T item, bool Function(T t1, T t2) isEquals) {
    for (int i = 0; i < _list.length; i++) {
      if (isEquals(item, _list[i])) return _list[i];
    }
    return null;
  }

  void onLoadMore(GlobalKey<AnimatedListState> key) async {
    if (isNoneStatus && !loadMore!.lockLoadMore) {
      loadingStatus = LoadingStatus.LoadingMore;
      var _items = await onLoadMoreByAPI();
      int _lenghDataAPI = _items.length;
      _items = onLoadMoreDataChanged(_list, _items);
      onListChanged(_items + _list);

      for (int i = 0; i < _items.length; i++) {
        var _item = _items[i];
        _list.add(_item);
        if (state.mounted)
          key.currentState?.insertItem(_list.length - 1,
              duration: Duration(milliseconds: 100 * (i + 1)));
      }

      if (mounted) {
        if (_lenghDataAPI == 0) loadMore?.lockLoadMore = true;
        empty = _lenghDataAPI == 0 && _list.length == 0;
        loadingStatus = LoadingStatus.None;
      }

      onCompleted();
    }
  }

  void onScroll() {
    if (state.mounted &&
        showButtonScrollTop &&
        loadMore!.controller.offset >
            MediaQuery.of(state.context).size.height * 1.5) {
      _showScrollToTop.value = true;
    } else {
      _showScrollToTop.value = false;
    }
  }

  void scrollToTop() {
    loadMore!.controller.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  List<T> onLoadMoreDataChanged(List<T> orginal, List<T> thenext) => thenext;

  setOriginData(List<T> original) => this._list = original;

  int getCount() => _list.length;

  List<T> getList() => _list;

  void onCompleted() {}
}

class LoadingStatusNotifier extends BaseNotifier<LoadingStatus> {
  LoadingStatusNotifier() : super(LoadingStatus.None);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<LoadingStatusNotifier>(create: (_) => this);
  }
}

class EmptyNotifier extends BaseNotifier<bool> {
  EmptyNotifier() : super(false);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<EmptyNotifier>(create: (_) => this);
  }
}

class ShowScrollToTop extends BaseNotifier<bool> {
  ShowScrollToTop() : super(false);

  @override
  ListenableProvider<ShowScrollToTop> provider() {
    return ChangeNotifierProvider<ShowScrollToTop>(create: (_) => this);
  }
}

class ISScrollToTop extends BaseNotifier<bool> {
  ISScrollToTop() : super(true);

  @override
  ListenableProvider<ISScrollToTop> provider() {
    return ChangeNotifierProvider<ISScrollToTop>(create: (_) => this);
  }
}
