import 'dart:async';

import 'package:cnvsoft/core/log.dart';

typedef AsyncFunction = Future<dynamic> Function();

class MultiAsync {
  static MultiAsync? _internal;

  MultiAsync._();

  factory MultiAsync() {
    if (_internal == null) _internal = MultiAsync._();
    return _internal!;
  }

  Future<dynamic> process(Map<String, AsyncFunction> tasks) {
    Completer completer = Completer();
    int length = tasks.length;

    var complete = () {
      length--;
      if (length <= 0 && !completer.isCompleted) completer.complete();
    };

    var error = (t, e) {
      Log().severe({"task": t, "err": e});
      complete();
    };

    var done = (t, m) {
      // var trace = Trace.from(StackTrace.current);
      Log().finest({"task": t, "msg": m});
      complete();
    };

    for (int i = 0; i < length; i++) {
      String tag = tasks.keys.toList()[i];
      if (tasks[tag] != null) {
        tasks[tag]!()
            .then((r) => done(tag, r))
            .catchError((e) => error(tag, e));
      }
    }

    return completer.future;
  }
}
