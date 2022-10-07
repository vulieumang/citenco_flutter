import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingMoreView extends StatelessWidget {
  final Color? color;
  const LoadingMoreView({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitThreeBounce(color: this.color, size: 24));
  }
}
