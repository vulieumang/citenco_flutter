import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_notifier.dart';

enum SearchResultType { init, hasData }

class SearchPayload {
  final String? key;
  final bool? isFirst;

  SearchPayload(this.key, {this.isFirst: false});
}

class SearchResult<T> {
  final SearchResultType? type;
  final List<T>? items;

  SearchResult({required this.type, required this.items});

  factory SearchResult.init() =>
      SearchResult(type: SearchResultType.init, items: []);

  factory SearchResult.empty() =>
      SearchResult(type: SearchResultType.hasData, items: []);

  factory SearchResult.from(List<T> data) =>
      SearchResult(type: SearchResultType.hasData, items: data);

  bool get hasData => type == SearchResultType.hasData;
}

class SearchClientNotifier<T>
    extends BaseClientNotifier<SearchPayload, SearchResult<T>> {
  final Future<SearchResult<T>> Function(SearchPayload payload)? onSearchByAPI;
  final Function()? showLoading;
  final Function()? hideLoading;
  Timer? debounceMap;

  SearchClientNotifier(
      {required this.showLoading,
      required this.hideLoading,
      required this.onSearchByAPI})
      : super(debounce: 300);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<SearchClientNotifier<T>>(
      create: (_) => this,
    );
  }

  @override
  Future<SearchResult<T>> onEmit(SearchPayload payload) async {
    Completer<SearchResult<T>> _completer = Completer();
    if (payload.isFirst!) {
      _completer.complete(onSearchByAPI!(payload));
    } else {
      if (debounceMap?.isActive ?? false) debounceMap?.cancel();
      debounceMap = Timer(const Duration(milliseconds: 700), () async {
        _completer.complete(onSearchByAPI!(payload));
      });
    }
    return await _completer.future;
  }

  @override
  SearchResult<T> onInit() => SearchResult.init();

  @override
  void onStart() => showLoading!();

  @override
  void onCompleted() => hideLoading!();
}
