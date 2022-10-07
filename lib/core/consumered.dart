import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class FadeConsumer extends SingleChildStatelessWidget {
  final List<Type>? listen;
  final Widget Function(
      BuildContext? context, FadeConsumer? snapshot, Widget? child)? builder;

  FadeConsumer({required this.listen, required this.builder});

  T notifierOf<T>(BuildContext context) => Provider.of<T>(context);

  @override
  Widget buildWithChild(BuildContext? context, Widget? child) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 400),
      child: builder!(context, this, child),
    );
  }
}
