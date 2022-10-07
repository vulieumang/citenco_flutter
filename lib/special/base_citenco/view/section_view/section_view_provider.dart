import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/section_view/section_view.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../util.dart';

class SectionChild {
  final SectionTypeRetail type;
  final dynamic sectionData;

  final String? imageUrl;
  final String? title;
  final dynamic id;

  //product
  final String? price;
  final String? priceCompare;
  final int? percentPrice;
  final bool? showCompare;

  //reward
  final int? rewardPercent;
  final int? rewardPoint;
  final DateTime? expiredAt;
  final String? rewardBrand;
  final String? rewardBrandLogo;
  final dynamic rewardCampaignId;

  //blog
  final DateTime? blogDate;

  /// Option to show compare price for Product
  // final bool showComparePriceProduct;

  SectionChild({
    required this.type,
    required this.sectionData,
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
    this.priceCompare,
    this.rewardPercent,
    this.rewardPoint,
    this.expiredAt,
    this.percentPrice,
    this.blogDate,
    this.rewardBrand,
    this.rewardBrandLogo,
    this.rewardCampaignId,
    this.showCompare,
  });

  factory SectionChild.product({
    required SectionTypeRetail type,
    required dynamic sectionData,
    required dynamic id,
    required String title,
    required String imageUrl,
    required String price,
    required String priceCompare,
    required bool showCompare,
    required int percentPrice,
  }) =>
      SectionChild(
          type: type,
          sectionData: sectionData,
          id: id,
          title: title,
          imageUrl: imageUrl,
          price: price,
          priceCompare: priceCompare,
          percentPrice: percentPrice,
          showCompare: showCompare);

  factory SectionChild.blog(
          {required SectionTypeRetail type,
          required dynamic sectionData,
          required dynamic id,
          required String title,
          required String imageUrl,
          required DateTime blogDate}) =>
      SectionChild(
          type: type,
          sectionData: sectionData,
          id: id,
          title: title,
          imageUrl: imageUrl,
          blogDate: blogDate);

  factory SectionChild.reward({
    required SectionTypeRetail type,
    required dynamic sectionData,
    required dynamic id,
    required String title,
    required String imageUrl,
    required int rewardPercent,
    required int rewardPoint,
    required DateTime expiredAt,
    required String rewardBrand,
    required String rewardBrandLogo,
    required dynamic rewardCampaignId,
  }) =>
      SectionChild(
        type: type,
        sectionData: sectionData,
        id: id,
        title: title,
        imageUrl: imageUrl,
        rewardPercent: rewardPercent,
        rewardPoint: rewardPoint,
        expiredAt: expiredAt,
        rewardBrand: rewardBrand,
        rewardBrandLogo: rewardBrandLogo,
        rewardCampaignId: rewardCampaignId,
      );

  // factory SectionChild.blog() {
  //   return SectionChild();
  // }

  bool get isBlog => type == SectionTypeRetail.BLOG;

  bool get isReward => type == SectionTypeRetail.REWARD;

  bool get hasRewardBrand => BasePKG().boolOf(
      () => isReward && BasePKG().stringOf(() => rewardBrand!).isNotEmpty);

  bool get hasRewardPoint => BasePKG()
      .boolOf(() => isReward && BasePKG().intOf(() => rewardPoint!) > 0);
}

class SectionHomeViewProvider extends BaseProvider<SectionHomeViewState>
    with DataMix {
  final SectionChildrenNotifier _children = SectionChildrenNotifier();
  AnimationController? _sizeFactor;

  SectionHomeViewProvider(SectionHomeViewState state) : super(state) {
    _sizeFactor = AnimationController(
        vsync: state, duration: Duration(milliseconds: 200));
  }

  List<SectionChild> get children => _children.value!;

  Animation<double> get sizeFactor => _sizeFactor!.view;

  // var _showComparePrice = true;

  @override
  BusProvider<SectionHomeViewData> initBus() =>
      BusProvider<SectionHomeViewData>.fromPackage(
          package: BasePKG(),
          key: state.widget.type.toString(),
          listeners: {"refresh": (arg) => (){initData();}});

  @override
  List<BaseNotifier> initNotifiers() => [_children];

  @override
  Future<void> onReady(_) async {
    initData();
  }

  void initData() async {
    // switch (state.widget.type) {
    //   case SectionTypeRetail.REWARD:
    //     initReward();
    //     break;
    //   // case SectionTypeRetail.BLOG:
    //   //   await initBlog();
    //   //   break;
    //   case SectionTypeRetail.PRODUCT:
    //     initProduct();
    //     break;
    // }
    animation();
  }

  String priceText(bool allow, double price) {
    String billionUnit = "Tỷ";
    bool _allowsToBuy = boolOf(() => allow);
    if (_allowsToBuy) {
      if (price > 999999999) {
        return "${(price / 1000000000).toStringAsFixed(1)} $billionUnit";
      } else {
        return Utils.numberToCurrency(
            source: price.toInt(), currencySymbol: " ₫");
      }
    }  else {
      return BaseTrans().$contact;
    }
  }

  bool allowBuy(Map json) {
    bool? isChangePriceByContact = boolOf(() => json['isChangePriceByContact']);
    return !(boolOf(() => isChangePriceByContact));
  }

  void initProduct() {
    // _children.value = BasePKG().listOf(() => List<SectionChild>.from(
    //     state.widget.data!.map((e) => SectionChild.product(
    //         showCompare: BasePKG().doubleOf(() => e["price"]) < BasePKG().doubleOf(() => e["comparePrice"]),
    //         type: state.widget.type,
    //         sectionData: ProductNET.fromJson(e),
    //         id: e["id"],
    //         percentPrice: e["comparePrice"] == null || (e["price"] == 0 && e["comparePrice"] == 0) ? 0:int.parse((100-((e["price"]*100/(e["comparePrice"]! == 0.0 ? 1 : e["comparePrice"])))).toStringAsFixed(0)),
    //         imageUrl:
    //             BasePKG().stringOf(() => e["image_url"] ?? e["image"]["url"]),
    //         title: BasePKG().stringOf(() => e["title"]),
    //         price: priceText(allowBuy(e), BasePKG().doubleOf(() => e["price"])),
    //         priceCompare: allowBuy(e)
    //             ? Utils.numberToCurrency(
    //                 source: BasePKG().doubleOf(() => e["comparePrice"]).toInt(),
    //                 currencySymbol: " ₫")
    //             : ""))));
  }

  void initReward() {
    _children.value = BasePKG().listOf(() => List<SectionChild>.from(
        state.widget.data!.map((e) => SectionChild.reward(
              type: state.widget.type,
              sectionData: e,
              id: e["id"],
              imageUrl:
                  BasePKG().stringOf(() => e["image_url"] ?? e["image"]["url"]),
              title: BasePKG().stringOf(() => e["title"]),
              expiredAt: BasePKG().dataOf(() => DateTime.parse(BasePKG().intOf(
                              () => e["reward_campaign"]["redeem_points"]) >
                          0
                      ? BasePKG()
                          .stringOf(() => e["reward_campaign"]["expired_at"])
                      : BasePKG().stringOf(() =>
                          e["expired_at"] ??
                          e["reward_campaign"]["expired_at"]))
                  .toLocal())!,
              rewardBrand: BasePKG().stringOf(() => e["reward_brand"]["title"]),
              rewardBrandLogo:
                  BasePKG().stringOf(() => e["reward_brand"]["logo_url"]),
              rewardCampaignId:
                   e["reward_campaign"]["id"],
              rewardPercent: BasePKG().boolOf(() =>
                      e["discount"]["discount_meta"]["type"]
                          .toString()
                          .toLowerCase() ==
                      "percent")
                  ? BasePKG().intOf(
                      () => e["discount"]["discount_meta"]["type"]["value"])
                  : 0,
              rewardPoint:
                  BasePKG().intOf(() => e["reward_campaign"]["redeem_points"]),
            ))));
  }

  // Future<void> initBlog() async {
  //   var response = await BasePKG.of(state).getListBlog(
  //       params: {'blogId': state.widget.categoryId, "isHighlights": true});
  //   if (response.isSuccess) {
  //     List<dynamic> data = BasePKG().listOf(() => response.data!["data"]["data"]);
  //     _children.value = BasePKG().listOf(
  //         () => List<SectionChild>.from(data.map((e) => SectionChild.blog(
  //               type: state.widget.type,
  //               sectionData: e,
  //               id: BasePKG().dataOf(() => e["id"]),
  //               title: BasePKG().stringOf(() => e["title"]),
  //               imageUrl: BasePKG().stringOf(() => e["image"]["url"]),
  //               blogDate: BasePKG().dataOf(
  //                   () => DateTime.parse(e["publishedDate"]).toLocal())!,
  //             ))));
  //   }
  // }

  void animation() {
    if (state.mounted) {
      if (children.isEmpty) {
        _sizeFactor?.reverse();
      } else {
        _sizeFactor?.forward();
      }
    }
  }

  void onReadMore() {
    if (state.widget.type == SectionTypeRetail.REWARD) {
      Navigator.of(context!).pushNamed("reward",arguments: {
        "title":"Ưu đãi"
      });
    } else if (state.widget.type == SectionTypeRetail.BLOG) {
      Navigator.of(context!).pushNamed("blog", arguments: {
        "article_category_id":  state.widget.categoryId!,
        "tag": BasePKG().stringOf(() => state.widget.title!),
        "reference_view": state.widget.referenceView
      });
    } else if (state.widget.type == SectionTypeRetail.PRODUCT) {
      Navigator.of(context!)
              .pushNamed("product-home", arguments: {
                // "is_featured": true,
                "showCategory":false,
                "dataProduct":dataOf(() => {"data":{"data":state.widget.data}}),
                "product_collection_id": state.widget.categoryId,
                "title":state.widget.title!
              }).then((value) => BasePKG().bus!.fire<HomeExtendData>(HomeExtendData("load_product")));
    }
  }

  void onItemTapped(int index) {
    if (state.widget.type == SectionTypeRetail.REWARD) {
      var item = children[index];
      Navigator.of(context!).pushNamed("reward_detail",
          arguments: {'id': item.rewardCampaignId.toString()});
    } else if (state.widget.type == SectionTypeRetail.BLOG) {
      var item = children[index];
      Navigator.of(context!).pushNamed("blog_detail", arguments: {
        "id": BasePKG().stringOf(() => item.id.toString()),
        "tag": BasePKG().stringOf(() => state.widget.title!),
        "article_category_id": state.widget.categoryId!,
        "reference_view": state.widget.referenceView,
        "detail_json": item.sectionData
      });
    } else if (state.widget.type == SectionTypeRetail.PRODUCT) {
      var item = children[index];
      Navigator.of(context!).pushNamed("ecommerce_product", arguments: {
        "product_id": item.id,
        "lost_product_list": true,
        "is_hot": true
      });
    }
  }

  String rewardValidUntil(String rewardEndDate) {
    if (rewardEndDate.isEmpty) {
      return BaseTrans().$noTimeLimit;
    } else {
      return "${BaseTrans().$validUntil} $rewardEndDate";
    }
  }

  @override
  void dispose() {
    this._sizeFactor?.dispose();
    super.dispose();
  }
}

class SectionChildrenNotifier extends BaseNotifier<List<SectionChild>> {
  SectionChildrenNotifier() : super([]);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<SectionChildrenNotifier>(create: (_) => this);
  }
}
