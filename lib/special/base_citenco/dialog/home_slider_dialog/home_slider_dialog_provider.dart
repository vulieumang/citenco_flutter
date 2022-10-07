import 'dart:async';

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/special/base_citenco/dialog/home_slider_dialog/home_slider_dialog.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSliderDialogProvider extends BaseProvider<HomeSliderDialogState> {
  HomeSliderDialogProvider(HomeSliderDialogState state) : super(state) {
    addItemSlider(state.widget.items!);
  }

  final SliderNotifier _slider = SliderNotifier([]);

  PageController slideCtrl = PageController();
  Timer? _timer;

  @override
  BusProvider<SliderDialogData> initBus() =>
      BusProvider<SliderDialogData>.fromPackage(
          package: BasePKG(),
          listeners: {"on_item": (data) => addItemSlider(data.data)});

  @override
  List<BaseNotifier> initNotifiers() {
    return [_slider];
  }

  void slideChanged(int index) {}

  void onItemPressed(SliderDialogModel item) {
    return item.onTap!();
  }

  void addItemSlider(List<SliderDialogModel> items) {
    _slider.value = items;
    // if (item.isFlashsale) {
    //   startTimer(item.expiredTime);
    // }
    // List<SliderDialogModel> temp = List<SliderDialogModel>.from(_slider.value);
    // temp.add(item);
    // _slider.value = temp;
  }

  void removeFlashSale() {
    List<SliderDialogModel> temp = List<SliderDialogModel>.from(_slider.value!);
    temp.removeWhere((element) => element.isFlashsale!);
    _slider.value = temp;
    if (_slider.value!.length <= 0) onClose();
  }

  void startTimer(DateTime expired) {
    Duration duration = expired.difference(DateTime.now());
    if (duration.inSeconds <= 0) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      duration = Duration(seconds: duration.inSeconds - 1);
      if (duration.inSeconds <= 0) {
        stopTimer();
        removeFlashSale();
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  void onClose() {
    stopTimer();
    Navigator.of(context!).pop();
  }
}

class SliderDialogModel {
  String? imageUrl;
  Function? onTap;
  bool? isFlashsale = false;
  bool? allowToShow = false;

  SliderDialogModel({this.imageUrl, this.onTap, this.allowToShow});
}

class SliderNotifier extends BaseListNotifier<SliderDialogModel> {
  SliderNotifier(List<SliderDialogModel> value) : super(value);

  @override
  ListenableProvider<Listenable> provider() {
    return ChangeNotifierProvider<SliderNotifier>(create: (_) => this);
  }
}
