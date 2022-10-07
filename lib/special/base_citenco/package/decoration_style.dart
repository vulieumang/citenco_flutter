import 'package:flutter/material.dart';

import 'package.dart';

class BaseDecoration {
  static BaseDecoration? _internal;

  BaseDecoration._();

  factory BaseDecoration() {
    if (_internal == null) {
      _internal = BaseDecoration._();
    }
    return _internal!;
  }

  BoxDecoration _decoration(Color primary, Color? start, Color? end,
      {List<BoxShadow>? shadow, BorderRadius? radius, Color? borderColor}) {
    bool isGradient = start != null && end != null;
    print(isGradient);
    if (isGradient) {
      return BoxDecoration(
          boxShadow: shadow,
          borderRadius: radius,
          gradient: LinearGradient(colors: [start, end]));
    } else {
      return BoxDecoration(
          boxShadow: shadow,
          borderRadius: radius,
          color: primary,
          border: borderColor == null ? null : Border.all(color: borderColor));
    }
  }

  BoxDecoration primaryDecoration(
      {List<BoxShadow>? shadow, BorderRadius? radius, Color? borderColor}) {
    Color primary = BasePKG().color.primaryColor;
    Color? _start = BasePKG().color.primaryStartColor;
    Color? _end = BasePKG().color.primaryEndColor;
    return _decoration(primary, _start, _end,
        shadow: shadow, radius: radius, borderColor: borderColor);
  }

  BoxDecoration accentDecoration(
      {List<BoxShadow>? shadow, BorderRadius? radius, Color? borderColor}) {
    Color primary = BasePKG().color.accentColor;
    Color? _start = BasePKG().color.accentStartColor;
    Color? _end = BasePKG().color.accentEndColor;
    return _decoration(primary, _start, _end,
        shadow: shadow, radius: radius, borderColor: borderColor);
  }
}
