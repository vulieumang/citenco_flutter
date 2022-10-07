import 'dart:math'; 
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'review_image.dart';

class ReviewImageProvider extends BaseProvider<ReviewImageState> {
  ReviewImageProvider(ReviewImageState? state) : super(state);

  late final CurrentNotifier _current =
      CurrentNotifier(BasePKG().dataOf(() => images.first));

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  double get miniSize => 58;
  double get paddingList => 16;

  List get images => BasePKG().listOf(() => state.widget.images);
  
  @override
  List<BaseNotifier>? initNotifiers() {
    return [_current];
  }

  void onImagePressed(int index) {
    if (index < images.length) {
      pageController
          .animateTo(index * state.size.width,
              duration: Duration(milliseconds: 300), curve: Curves.ease)
          .then((value) => _current.value = images[index]);
    }
  }

  void onPageChanged(int index) {
    if (index < images.length) {
      _current.value = images[index];
      scrollController.animateTo(
          max(
              scrollController.position.minScrollExtent,
              min(
                  scrollController.position.maxScrollExtent,
                  ((index * (miniSize + paddingList) -
                      ((state.size.width - 2 * paddingList) / 2 -
                          ((miniSize) / 2) -
                          paddingList))))),
          duration: Duration(milliseconds: 300),
          curve: Curves.ease);
    }
  }
}

class CurrentNotifier extends BaseNotifier {
  CurrentNotifier(value) : super(value);

  @override
  ListenableProvider<Listenable?> provider() {
    return ChangeNotifierProvider<CurrentNotifier>(create: (_) => this);
  }
}
