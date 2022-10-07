import 'dart:async';

import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';

enum MemberCardStyle { Loyalty, Ecommerce, OrderStatus }

class LevelAsset {
  static LevelAsset? _internal;
  List<String> memberCards = [];
  List<String> primaryCards = []; // chỉ còn sử dụng mỗi primaryCards
  List<String> accumulateCards = [];
  List<String> icons = [];
  List<String> lockIcons = [];

  LevelAsset._();

  String get defaultMemberCard => BasePKG().stringOf(() => memberCards.first);

  // String get defaultAccumulateCard =>
  //     BasePKG().stringOf(() => accumulateCards.first);

  String get defaultIcon => BasePKG().stringOf(() => icons.first);

  String get defaultLockIcon => BasePKG().stringOf(() => lockIcons.first);

  String getMemberCardByIndex(int index) {
    return BasePKG().stringOf(() => memberCards[index % memberCards.length]);
  }

  String getPrimaryCardByIndex(int index) {
    return BasePKG().stringOf(() => primaryCards[index % primaryCards.length]);
  }

  String getAccumulateCardByIndex(int index) {
    return BasePKG()
        .stringOf(() => accumulateCards[index % accumulateCards.length]);
  }

  // String getLockIconsByIndex(int index) {
  //   return BasePKG().stringOf(() => lockIcons[index % lockIcons.length]);
  // }

  // String getIconByIndex(int? index) {
  //   if (index == null) return "";
  //   return BasePKG().stringOf(() => icons[index % icons.length]);
  // }

  factory LevelAsset() {
    if (_internal == null) _internal = LevelAsset._();
    return _internal!;
  }

  Future<void> initialize() async {
    bool exist;
    int count = 0;
    String baseFolder = "lib/special/base_citenco/asset/image";
    String modifyFolder = "lib/special/modify/asset/image/member_card";
    Completer completer = Completer();
    do {
      count++;
      String path = modifyFolder + "/member_card_$count.png";
      exist = await StorageCNV().checkFileExist(path);
      if (exist) memberCards.add(path);
    } while (exist);

    // homeCards = List.from(memberCards);

    var levelCount = count - 1;

    List<String> patterns = [
      "accumulate_point_",
      "level_icon_",
      "lock_level_icon_",
      "primary_card_"
    ];
    List<String> extentions = [".png", ".svg", ".svg", ".png"];
    List<bool> exists = List.generate(count, (index) => false).toList();
    List<Function(String path)> adds = [
      (path) => accumulateCards.add(path),
      (path) => icons.add(path),
      (path) => lockIcons.add(path),
      (path) => primaryCards.add(path)
    ];
    int _completed = 0;
    for (int j = 0; j < patterns.length; j++) {
      String pattern = patterns[j];
      String extention = extentions[j];
      Function(String path) add = adds[j];
      for (int i = 0; i < levelCount; i++) {
        String _modify = modifyFolder + "/$pattern${i + 1}$extention";
        String _base = j == 3
            ? memberCards[i]
            : baseFolder + "/$pattern${i + 1}$extention";
        var exist = await StorageCNV().checkFileExist(_modify);
        if (j == 2 && !exist && exists[i]) {
          add(icons[i]);
        } else {
          add(exist ? _modify : _base);
        }
        exists[i] = exist;
        _completed++;
        if (_completed == patterns.length * levelCount) completer.complete();
      }
    }
    await completer.future;
  }
}
