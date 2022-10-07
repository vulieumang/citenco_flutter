import 'package:cnvsoft/core/base_core/base_notifier.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

abstract class BaseLazyLoad extends StatelessWidget {
  BaseLazyLoad(this.state, this.visible, {this.durationToHide = false}) {
    if (durationToHide && !visible) {
      //delay 200 milisecond
      //để các item ở màn hình home animation xong
      //rồi mới ẩn lazy load
      Future.delayed(Duration(milliseconds: duration))
          .then((value) => _visibleNotifier.value = visible);
    } else {
      _visibleNotifier.value = visible;
    }
  }

  late final State state;

  final int duration = 200;
  final bool visible, durationToHide;

  final VisibleNotifier _visibleNotifier = VisibleNotifier(false);

  BuildContext get context => state.context;

  Color get background => Color(0xffF3F4F7);
  Color get grey => Color(0xffEAEBEF);
  Color get thinGrey => Color(0xffF4F6FA);

  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VisibleNotifier>.value(
      value: _visibleNotifier,
      child: Consumer<VisibleNotifier>(builder: (ctx, value, _) {
        return Visibility(
          visible: value.value ?? false,
          child: lazyLoad(),
          // child: AnimatedOpacity(
          //   opacity: this.visible ? 1.0 : 0.0,
          //   duration: Duration(milliseconds: duration),
          //   child: lazyLoad(),
          // ),
        );
      }),
    );
  }

  Widget lazyLoad();

  Widget lineDis(){
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          line( width: size.width, height: 10),
          line( width: size.width, height: 10),
          line( width: size.width, height: 10),
          line( width: size.width, height: 10),
          line( width: size.width, height: 10),
          line( width: 100, height: 10),
        ],
      ),
    );
  }

  Widget line(
      {double width = double.infinity,
      double height = double.infinity,
      double radius = 2,
      Color? color ,
      double top = 10
      }) {
    color = color ?? grey;
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: ShimmerCnv(height: height, width: width, radius: radius,),
    );
  }
}

class ShimmerCnv extends StatelessWidget {
  ShimmerCnv({
    Key? key,
    required this.height,
    required this.width,
    this.child,
    this.radius
  }) : super(key: key);

  final double width;
  final double height;
  final double? radius;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius??0),
            color: Colors.grey,
          ),
          child: child,
        ),
      ),
    );
  }
}

class VisibleNotifier extends BaseNotifier<bool> {
  VisibleNotifier(bool? value) : super(value);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<VisibleNotifier>(create: (_) => this);
  }
}
