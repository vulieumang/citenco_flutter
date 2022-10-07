import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/base_search.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class SearchProvider<R extends State, T> extends BaseProvider<R> {
  final TextEditingController searchController = TextEditingController();
  final SearchLoadingNotifier _searchLoading = SearchLoadingNotifier();
  SearchClientNotifier<T>? client;
  bool isFirst = true;
  final isNeedFirstLoad = true;

  // List<T> _list = [];
  Color cardColor = BasePKG().color.card;

  SearchProvider(R state) : super(state) {
    client = SearchClientNotifier<T>(
        onSearchByAPI: onSearchByAPI,
        hideLoading: onSearchCompleted,
        showLoading: onSearchStarted);
  }

  List<BaseNotifier> initSubNotifiers();

  Future<SearchResult<T>> onSearchByAPI(SearchPayload payload);

  bool get searchLoading => _searchLoading.value!;

  set searchLoading(bool value) => _searchLoading.value = value;

  @override
  void onReady(callback) async {
    super.onReady(callback);
    if (isNeedFirstLoad) {
      await Future.delayed(Duration(milliseconds: 100));
      client?.send(SearchPayload("", isFirst: true));
    }
  }

  @override
  List<BaseNotifier> initNotifiers() =>
      initSubNotifiers()..addAll([client!, _searchLoading]);

  SearchPayload? get payload => client?.payload;

  void onSearchStarted() => searchLoading = true;

  void onSearchCompleted() => searchLoading = false;

  void clear() {
    searchController.clear();
    onSearch("");
  }

  int getCount() => client!.value!.items!.length;

  List<T> getList() => client!.value!.items!;

  Future<void> onRefresh() async => client!.refresh();

  void onSearch(String key) => client?.send(SearchPayload(key));

  void onWillPop() {}
}

class SearchLoadingNotifier extends BaseNotifier<bool> {
  SearchLoadingNotifier() : super(true);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SearchLoadingNotifier>(create: (_) => this);
  }
}
