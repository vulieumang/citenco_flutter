import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler(
      {this.resume, this.inactive, this.paused, this.suspending});

  final AsyncCallback? resume;
  final AsyncCallback? inactive;
  final AsyncCallback? paused;
  final AsyncCallback? suspending;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        if (inactive != null) await inactive!();
        break;
      case AppLifecycleState.paused:
        if (paused != null) await paused!();
        break;
      // case AppLifecycleState.suspending:
      //   if (suspending != null) await suspending();
      //   break;
      case AppLifecycleState.resumed:
        if (resume != null) await resume!();
        break;
      default:
        {
          if (suspending != null) await suspending!();
          break;
        }
    }
  }
}

class LoadingHandler {
  final Function()? onShowLoading;
  final Function()? onHideLoading;

  LoadingHandler({required this.onShowLoading, required this.onHideLoading});
}
