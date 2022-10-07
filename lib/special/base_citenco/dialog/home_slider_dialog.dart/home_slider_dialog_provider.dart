// import 'package:cnvsoft/core/base_core/base_notifier.dart';
// import 'package:cnvsoft/core/base_core/base_provider.dart';
// import 'package:cnvsoft/special/base_citenco/dialog/home_slider_dialog/home_slider_dialog_provider.dart';
// import 'package:cnvsoft/special/base_citenco/package/package.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'home_slider_dialog.dart';

// class HomeSliderDialogProvider extends BaseProvider<HomeSliderDialogState> {
//   HomeSliderDialogProvider(HomeSliderDialogState state) : super(state) {
//     addItemSlider(state.widget.item);
//   }

//   final SliderNotifier _slider = SliderNotifier([]);

//   PageController slideCtrl = PageController();

//   @override
//   BusProvider<SliderDialogData> initBus() =>
//       BusProvider<SliderDialogData>.fromPackage(
//           package: BasePKG(),
//           listeners: {"on_item": (data) => addItemSlider(data.data)});

//   @override
//   List<BaseNotifier> initNotifiers() {
//     return [_slider];
//   }

//   void slideChanged(int index) {}

//   void onItemPressed(SliderDialogModel item) {
//     return item.onTap();
//   }

//   void addItemSlider(SliderDialogModel item) {
//     List<SliderDialogModel> temp = List<SliderDialogModel>.from(_slider.value);
//     temp.add(item);
//     _slider.value = temp;
//   }
// }

// class SliderNotifier extends BaseListNotifier<SliderDialogModel> {
//   SliderNotifier(List<SliderDialogModel> value) : super(value);

//   @override
//   ListenableProvider<Listenable> provider() {
//     return ChangeNotifierProvider<SliderNotifier>(create: (_) => this);
//   }
// }
