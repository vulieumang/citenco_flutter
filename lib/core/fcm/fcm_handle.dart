import 'package:cnvsoft/core/base_core/data_mix.dart';

class RemoteHandle with DataMix {
  final String? route;
  final String? secondary;
  final dynamic argument;
  final String? announcementID;

  RemoteHandle(this.route, this.secondary, this.argument, this.announcementID);

  factory RemoteHandle.announcement(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "announcement_detail" : "announcement",
        "announcement", id, announce);
  }

  factory RemoteHandle.announcements() {
    return RemoteHandle("announcement", "announcement", null, null);
  }

  factory RemoteHandle.blog(dynamic id, String? announce) {
    return RemoteHandle(
        id.isNotEmpty ? "blog_detail" : "blog", "blog", {"id": id}, announce);
  }

  factory RemoteHandle.reward(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "reward_detail" : "reward", "reward",
        id.isNotEmpty ? {"id": id} : {"allow_back": true}, announce);
  }

  factory RemoteHandle.warranty(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "warranty_report" : "warranty",
        "warranty", int.tryParse(id), announce);
  }

  factory RemoteHandle.gym(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "gym_detail" : "gym", "gym",
        int.tryParse(id), announce);
  }

  factory RemoteHandle.product(dynamic id, String? announce) {
    return RemoteHandle(
        id.isNotEmpty ? "ecommerce_product" : "product",
        "product",
        id.isNotEmpty
            ? {"product_id": int.tryParse(id), "lost_product_list": true}
            : null,
        announce);
  }

  factory RemoteHandle.wine(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "wine_take" : "wine", "wine",
        {"id": int.tryParse(id)}, announce);
  }

  factory RemoteHandle.review(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "review" : "history", "history",
        {"reviewID": id}, announce);
  }

  factory RemoteHandle.quote(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "quote_detail" : "quote", "quote",
        {'id': id}, announce);
  }

  factory RemoteHandle.booking(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "booking_detail" : "booking", "booking",
        {"id": int.tryParse(id)}, announce);
  }

  factory RemoteHandle.productAdmin(dynamic id, String? announce) {
    return RemoteHandle("product_admin_detail", "announcement", id, announce);
  }

  factory RemoteHandle.luckyNumberGame(dynamic id, String? announce) {
    return RemoteHandle("lucky_number", "lucky_number", null, announce);
  }

  factory RemoteHandle.topUpHistory(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "topup_detail" : "history_topup",
        "history_topup", {"transaction_id": id}, announce);
  }

  factory RemoteHandle.productCollection(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "product" : "product", "product",
        {"product_type_id": int.tryParse(id)}, announce);
  }

  factory RemoteHandle.wheelWeb(dynamic id, String? announce) {
    return RemoteHandle("lucky_wheel_web", "lucky_wheel_web", null, announce);
  }
  factory RemoteHandle.orderDetail(dynamic id, String? announce) {
    return RemoteHandle(id.isNotEmpty ? "review" : "order_history",
        "order_history", {"order_id": int.tryParse(id)}, announce);
  }
}
