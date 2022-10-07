import 'package:flutter/material.dart';

class BounceTap extends StatefulWidget {
  final Widget? child;
  final Function? onTap;

  const BounceTap({Key? key, this.child, this.onTap}) : super(key: key);
  @override
  _BounceTapState createState() => _BounceTapState();
}

class _BounceTapState extends State<BounceTap>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapDown,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, _) {
            return widget.child!;
            // Transform.scale(
            //     scale: 1 - _controller.value, child: widget.child);
          }),
    );
  }

  void _onTapDown() {
    if (widget.onTap != null) {
      widget.onTap!.call();
      // _controller.forward().then((value) {
      //   _controller.reverse();
      // }
      // );
    }
  }
}
