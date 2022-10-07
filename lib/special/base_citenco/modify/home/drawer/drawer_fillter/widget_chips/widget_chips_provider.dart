

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';  
import 'widget_chips.dart';

class WidgetChipsProvider extends BaseProvider<WidgetChipsState> {
  WidgetChipsProvider(WidgetChipsState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() {
    return [];
  }
 
  List<ItemInput> get mockResults => state.widget.listData!;

  @override
  void onReady(callback) {
    // TODO: implement onReady
    // mockResults = state.widget.listData ?? [];
    super.onReady(callback);
  }

}
 

// class IndexTabSelectedNotifier extends BaseNotifier<int> {
//   IndexTabSelectedNotifier() : super(0);

//   @override
//   ListenableProvider provider() {
//     return ChangeNotifierProvider<IndexTabSelectedNotifier>(
//         create: (_) => this);
//   }
// }

class ItemInput {
  final String name;
  // final String email;?
  ItemInput(
    this.name, 
    // this.email, this.imageUrl
    );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemInput &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}