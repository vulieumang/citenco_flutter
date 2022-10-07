import 'package:flutter/material.dart';

class ReloadMix {
  final GlobalKey<RefreshIndicatorState> reloadKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> reload(State state, Function() func) async {
    await func();
    if (state.mounted) {
      state.setState(() {});
    }
  }
}
