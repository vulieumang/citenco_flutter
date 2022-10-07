import 'dart:async';

import 'package:connectivity/connectivity.dart';

class Connection {
  static Connection? _internal;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;
  bool _hasConnection = true;

  Connection._();

  factory Connection() {
    if (_internal == null) _internal = Connection._();
    return _internal!;
  }

  void init() {
    _connectivity.checkConnectivity().then(_connectivityChanged);
    _subscription =
        _connectivity.onConnectivityChanged.listen(_connectivityChanged);
  }

  _connectivityChanged(ConnectivityResult result) {
    _hasConnection = result != ConnectivityResult.none;
  }

  bool get hasConnection => _hasConnection;

  void dispose() {
    _subscription?.cancel();
  }
}
