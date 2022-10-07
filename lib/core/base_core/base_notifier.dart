import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoadingNotifier extends BaseNotifier<bool> {
  LoadingNotifier(bool value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<LoadingNotifier>(create: (_) => this);
  }
}

class IgnoringNotifier extends BaseNotifier<bool> {
  IgnoringNotifier(bool value) : super(value);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<IgnoringNotifier>(create: (_) => this);
  }
}

abstract class BaseNotifier<T> extends ChangeNotifier {
  BaseNotifier(T? value) {
    this._value = value;
  }

  T? _value;

  T? get value => _value;

  set value(T? value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }

  ListenableProvider provider();
}

abstract class BaseClientNotifier<T, S> extends BaseNotifier<S> {
  StreamController<T>? _ctrl;
  T? payload;

  BaseClientNotifier({int? debounce}) : super(null) {
    _ctrl = new StreamController<T>();
    Stream? _stream = _ctrl?.stream
        .switchMap<S?>(_switchMapper)
        .debounceTime(Duration(milliseconds: debounce ?? 0))
        .startWith(onInit())
        .doOnData(_onData)
        .asBroadcastStream();
    _stream?.listen((data) {});
  }

  Stream<S?> _switchMapper(T payload) {
    return new Stream.fromFuture(onEmit(payload)).onErrorReturn(null);
  }

  void _onData(S? result) {
    if (result != value) {
      _value = result;
      notifyListeners();
    }
    onCompleted();
  }

  void setData(S result) {
    _onData(result);
  }

  void send(T value) {
    if (value != null) {
      payload = value;
      onStart();
      _ctrl?.add(value);
    }
  }

  void refresh() {
    if (payload != null) {
      onStart();
      _ctrl?.add(payload!);
    }
  }

  ListenableProvider provider();

  Future<S?> onEmit(T payload);

  // Future<void> onReady(T payload) async {
  //   onStart();
  //   value = await onEmit(payload);
  //   onCompleted();
  // }

  void onStart() {}

  void onCompleted() {}

  S onInit();
}

abstract class BaseListNotifier<T> extends BaseNotifier<List<T>> {
  BaseListNotifier(List<T>? value) : super(value);

  T getItem(int index) => this.value![index];

  setItem(int index, T value) => this.value![index] = value;
}
