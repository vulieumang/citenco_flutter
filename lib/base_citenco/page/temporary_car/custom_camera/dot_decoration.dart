import 'dart:ui';

import 'package:flutter/material.dart';

class DotDecoration extends Decoration {
  final BorderRadius? radius;
  final double strokeWidth;
  final Color color;

  DotDecoration({this.radius, this.strokeWidth = 1, this.color = Colors.black})
      : assert(strokeWidth > 0),
        super();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotDecorationPainter(
        radius: radius!, strokeWidth: strokeWidth, color: color);
  }
}

class _DotDecorationPainter extends BoxPainter {
  BorderRadius? radius;
  double? strokeWidth;
  Color? color;

  _DotDecorationPainter(
      {this.radius, this.strokeWidth = 1, this.color = Colors.black})
      : assert(strokeWidth! > 0),
        super() {
    radius = radius ?? BorderRadius.circular(0);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Path outPath = Path();

    RRect rect = RRect.fromLTRBAndCorners(
      offset.dx,
      offset.dy,
      offset.dx + configuration.size!.width,
      offset.dy + configuration.size!.height,
      bottomLeft: (radius?.bottomLeft ?? Radius.zero),
      bottomRight: (radius?.bottomRight ?? Radius.zero),
      topLeft: (radius?.topLeft ?? Radius.zero),
      topRight: (radius?.topRight ?? Radius.zero),
    );

    outPath.addRRect(rect);

    PathMetrics metrics = outPath.computeMetrics(forceClosed: false);
    Path drawPath = Path();

    for (PathMetric me in metrics) {
      double totalLength = me.length;
      int index = -1;
      for (double start = 0; start < totalLength;) {
        double to = start + 5;
        to = to > totalLength ? totalLength : to;
        index += 1;
        bool isEven = index % 2 == 0;
        if (isEven)
          drawPath.addPath(
              me.extractPath(start, to, startWithMoveTo: true), Offset.zero);
        start = to;
      }
    }

    canvas.drawPath(
        drawPath,
        Paint()
          ..color = color!
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth!);
  }
}
