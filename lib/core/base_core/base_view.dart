import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';

import 'base_handler.dart';
import 'base_notifier.dart';
import 'base_provider.dart';

abstract class BaseView<S extends StatefulWidget, T extends BaseProvider>
    extends State<S> with AutomaticKeepAliveClientMixin<S> {
  late T _provider;

  T initProvider();

  T get provider => _provider;

  @override
  void initState() {
    super.initState();
    this._provider = initProvider();
    WidgetsBinding.instance.addPostFrameCallback(provider.onReady);
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        inactive: inactive,
        resume: resume,
        paused: paused,
        suspending: suspending));
  }

  Future inactive() async {}

  Future resume() async {
    if (mounted) provider.hideKeyboard();
  }

  Future paused() async {}

  Future suspending() async {}

  Widget body();

  Size get size => MediaQuery.of(context).size;

  //tỉ lệ chiều cao của view
  final double? heightFactor = null;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return heightFactor != null
        ? FractionallySizedBox(
            heightFactor: heightFactor,
            child: _build(),
          )
        : _build();
  }

  Widget _build() {
    return MultiProvider(
        providers: _provider.providers,
        child: Stack(clipBehavior: Clip.antiAlias, children: [
          Consumer<IgnoringNotifier>(builder: (context, ignoring, _) {
            return IgnorePointer(child: body(), ignoring: ignoring.value!);
          }),
          buildLoading(),
          buildLazyLoad()
        ]));
  }

  Widget buildLoading() {
    return Consumer<LoadingNotifier>(builder: (context, notifier, _) {
      return notifier.value! ? buildLoadingSpin() : SizedBox();
    });
  }

  Widget buildLoadingSpin({Color? background}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        color: background ?? Colors.black.withOpacity(0.2),
        // child: SvgPicture.asset("lib/core/asset/image/loading.svg")˝
        // child:
        //     SpinKitCircle(size: 52, color: ModifyPKG().color.primaryColor)
        child: ClipPath(
          clipper: BorderClipper(7),
          child: Container(
            color: BasePKG().color.card,
            padding: BasePKG().all(7),
            child: Image.asset(
              "lib/core/asset/image/loading_moon.gif",
              width: 52,
              height: 52,
              color: BasePKG().color.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildIgnoring() {
  //   return Consumer<IgnoringNotifier>(builder: (context, notifier, _) {
  //     return notifier.value ? buildIgnorePointer() : SizedBox();
  //   });
  // }

  // Widget buildIgnorePointer() {
  //   return Material(
  //     color: Colors.transparent,
  //     child: Container(
  //         alignment: Alignment.center,
  //         color: Colors.transparent,
  //         child: IgnorePointer(ignoring: true)),
  //   );
  // }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildLazyLoad() {
    return Consumer<LazyLoadNotifier>(builder: (ctx, lazy, _) {
      return Container(
          color: BasePKG().color.background,
          child: lazyLoad(BasePKG().boolOf(() => lazy.value)));
    });
  }

  Widget lazyLoad(bool visible) => SizedBox();
}
