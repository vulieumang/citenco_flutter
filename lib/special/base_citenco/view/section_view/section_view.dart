import 'dart:math';

import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
import 'package:cnvsoft/special/base_citenco/view/item_product/item_product.dart';
import 'package:cnvsoft/special/base_citenco/view/section_view/section_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum SectionTypeRetail { REWARD, PRODUCT, BLOG }

class SectionHomeView extends StatefulWidget {
  final List<dynamic>? data;
  final String? title;
  final Widget? referenceView;
  final SectionTypeRetail type;
  var categoryId;

  SectionHomeView(
      {Key? key,
      this.title,
      this.referenceView,
      required this.type,
      this.data,
      this.categoryId})
      : super(key: key);

  factory SectionHomeView.reward({required List<dynamic> data,String? title}) {
    return SectionHomeView(
      type: SectionTypeRetail.REWARD,
      // title: BaseTrans().$hotRewards,
      title: title,
      data: data,
    );
  }

  factory SectionHomeView.blog(
      {required String title, required int categoryId, Widget? referenceView}) {
    return SectionHomeView(
        type: SectionTypeRetail.BLOG,
        title: title,
        referenceView: referenceView,
        categoryId: categoryId);
  }

  factory SectionHomeView.product({
    required List<dynamic> data,
    required String title,
    required var id,
  }) {
    return SectionHomeView(type: SectionTypeRetail.PRODUCT, data: data, title: title, categoryId: id,);
  }

  @override
  State<StatefulWidget> createState() {
    return SectionHomeViewState();
  }
}

double _width = 284;
double _height = (_width * 9.0 / 16 )+24;
double _heightList = _height + 86;
double _bottomMargin = 12;

class SectionHomeViewState
    extends BaseView<SectionHomeView, SectionHomeViewProvider>
    with TickerProviderStateMixin {
  // @override
  // void didUpdateWidget(SectionHomeView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.type == SectionTypeRetail.BLOG ||
  //       oldWidget.data != widget.data ||
  //       oldWidget.categoryId != widget.categoryId) {
  //     provider.initData();
  //   }
  // }

  @override
  Widget body() {
    return SizeTransition(
        sizeFactor: provider.sizeFactor,
        child: Padding(
            padding: BasePKG().symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10,),
                  child: _buildHeader()),
                widget.type == SectionTypeRetail.PRODUCT
                    ? Consumer<SectionChildrenNotifier>(
                        builder: (context, list, _) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                          child: IntrinsicHeight(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                  children: List.generate(list.value!.length,
                                      (index) => _buildItemProduct(context, index))),
                            ),
                          ),
                        );
                      })
                    : SizedBox(
                        height: _heightList ,
                        child: Consumer<SectionChildrenNotifier>(
                          builder: (context, list, _) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: BasePKG().symmetric(horizontal: 16,vertical: 12),
                              scrollDirection: Axis.horizontal,
                              itemCount: list.value!.length,
                              itemBuilder: _buildItem,
                            );
                          },
                        ),
                      )
              ],
            )));
  }

  Widget _buildHeader() {
    return Padding(
      padding: BasePKG().symmetric(horizontal: BasePKG().convert(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                BasePKG().stringOf(() => widget.title),
                style: BasePKG()
                    .text!
                    .largeUpperNormal(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 30.0),
              color: Colors.transparent,
              child: Text(BaseTrans().$viewMore,
                  style: BasePKG().text!.homeReadmore().copyWith(
                      color: BasePKG().headerSectionTextColor ??
                          BasePKG().color.primaryColor)),
            ),
            onTap: provider.onReadMore,
          )
        ],
      ),
    );
  }
  Widget _buildItemProduct(BuildContext context, int index) {
    var item = provider.children[index];
    double width = size.width / 2.5;
    return Container(
      width: width,
      child: Column(
        children: [
          CNVItemProduct(
            imageUrl: item.imageUrl,
            percent: item.percentPrice,
            // f: ProductCart(value: item.sectionData),
            allowBuyProduct: item.sectionData.allowToBuy,
            // priceText: Utils().priceText(ProductCart(value: item.sectionData)),
            onshowAddToCart: () => provider.onItemTapped(index),
            isPlus: false,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var item = provider.children[index];
    List<BoxShadow> shadow = [
      BoxShadow(
        color: Color(0xff000000).withOpacity(0.07),
        offset: Offset(0, 2),
        blurRadius: 20,
        spreadRadius: -2
      )
    ];
    return GestureDetector(
      child: Container(
        width: widget.type == SectionTypeRetail.PRODUCT ? _height : _width,
        margin: BasePKG().only(right: 20),
        decoration: BoxDecoration(
            color: BasePKG().color.card,
            boxShadow: shadow,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildImage(item),
            _buildInfo(item),
          ],
        ),
      ),
      onTap: () => provider.onItemTapped(index),
    );
  }

  _buildProductImage(SectionChild item) {
    return ClipPath(
        clipper: BorderClipper(8, topLeft: true, topRight: true),
        child: Stack(
          children: [
          AspectRatio(
            aspectRatio: 1,
            child:  FadeInImageView(
              imageUrl:BasePKG().stringOf(() => item.imageUrl!),
              errorImage: "lib/special/ecommerce/asset/image/img_product_err.png",
              fit: BoxFit.contain,
              forceQuantity: 300,
            ),
          ),            
          // giảm giá ecom
          Opacity(
            opacity: item.percentPrice! > 0 ? 1 : 0,
            child: Container(
              width: 42,
              height: 25,
              decoration: BoxDecoration(
                color: BasePKG().color.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomRight: Radius.circular(8))
              ),
              alignment: Alignment.center,
              child: Text(
                "-${item.percentPrice}%",
                style: BasePKG().text!.smallLowerMedium().copyWith(color: Colors.white),
              ),
            ) 
          ),
            // _buildPercent(item)
          ],
        ));
  }

  Widget _buildPercent(SectionChild item) {
    double _iconSize = 42;
    return Visibility(
      visible: BasePKG().boolOf(() =>
          // item.showComparePriceProduct &&
          item.percentPrice! > 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: _iconSize,
          height: _iconSize,
          margin: BasePKG().only(right: 7, top: 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE7262B),
          ),
          alignment: Alignment.center,
          child: Text(
            BasePKG().stringOf(() => item.percentPrice.toString() + "%"),
            style:
                BasePKG().text!.smallUpperBold().copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _buildProductInfo(SectionChild item) {
    return Padding(
      padding: BasePKG().only(left: 8, right: 8, bottom: 8, top: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                BasePKG().stringOf(() => item.title!),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: BasePKG().text!.smallNormal(),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              BasePKG().stringOf(() => item.price),
              style: BasePKG()
                  .text!
                  .normalBold()
                  .copyWith(color: BasePKG().color.primaryColor),
            ),
          ),
          if(BasePKG().boolOf(() => item.showCompare))...[
          Visibility(
            visible: BasePKG().boolOf(() =>
                item.showCompare),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                BasePKG().stringOf(() => item.priceCompare!),
                style: BasePKG().text!.smallUpperNormal().copyWith(
                    color: BasePKG().color.text.withOpacity(.6),
                    decoration: TextDecoration.lineThrough),
              ),
            ),
          )]else...[
            Container()
          ]
        ],
      ),
    );
  }

  _buildInfo(SectionChild item) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (item.isBlog)
                Padding(
                  padding: BasePKG().symmetric(vertical: 0),
                  child: Text(
                    BasePKG().stringOf(
                        () => Utils.dateToString(source: item.blogDate!)),
                    overflow: TextOverflow.ellipsis,
                    style: BasePKG().text!.description(),
                  ),
                ),
              Container(
                height: BasePKG().convert(50),
                margin: BasePKG().only(top: 0),
                child: Text(
                  BasePKG().stringOf(() => item.title!),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: BasePKG().text!.normalMedium(),
                ),
              ),
              if (item.isReward)
                Padding(
                  padding: BasePKG().symmetric(vertical: 0),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        "lib/special/reward/asset/image/schedule.svg",
                        color: BasePKG().color.primaryColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        provider.rewardValidUntil(BasePKG().stringOf(
                            () => Utils.dateToString(source: item.expiredAt!))),
                        overflow: TextOverflow.ellipsis,
                        style: BasePKG().text!.description(),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
        if (item.isReward) _buildArrow()
      ],
    );
  }

  _buildArrow() {
    return ClipPath(
      clipper: ReadmoreClipper(),
      child: Container(
          padding: BasePKG().all(12),
          decoration: BoxDecoration(
              color: BasePKG().color.arrowReward,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    2,
                    (index) => Padding(
                          padding: BasePKG()
                              .only(top: 4, right: index.isEven ? 4 : 0),
                          child: SvgPicture.asset(
                            BasePKG().backArrowLink,
                            color: Colors.transparent,
                            width: 15,
                            height: 12,
                          ),
                        )),
              ),
              Transform.rotate(
                child: SvgPicture.asset(
                  BasePKG().backArrowLink,
                  color: BasePKG().color.iconColorPr,
                  width: 15,
                  height: 12,
                ),
                angle: pi,
              ),
            ],
          )),
    );
  }

  _buildImage(SectionChild item) {
    return Flexible(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: _height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ClipPath(
                  child: Stack(
                    children: [
                      FadeInImageView.fromSize(
                        BasePKG().stringOf(() => item.imageUrl!),
                        width: _width,
                        height: _height,
                        fit: BoxFit.contain,
                      ),
                      _buildDiscount(item),
                    ],
                  ),
                  clipper: BorderClipper(12, topLeft: true, topRight: true),
                ),
                _buildBottom(item)
              ],
            ),
          );
        },
      ),
    );
  }

  _buildDiscount(SectionChild item) {
    return Visibility(
      visible: BasePKG().boolOf(() => item.rewardPercent! > 0),
      child: Positioned(
        child: Align(
          alignment: Alignment.topLeft,
          child: ClipPath(
            clipper: DiscountClipper(),
            child: Container(
              // padding: BasePKG().only(top: 13, bottom: 19, left: 6, right: 4),
              color: BasePKG().color.primaryColor,
              child: Text(
                  BasePKG().intOf(() => item.rewardPercent!).toString() + "%",
                  style: BasePKG()
                      .text!
                      .normalLowerBold()
                      .copyWith(color: BasePKG().color.colorTextHeader )),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottom(SectionChild item) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color(0xff000000).withOpacity(.65),
              Color(0xff000000).withOpacity(.65),
              Color(0xff505050).withOpacity(0),
            ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (item.hasRewardBrand) Expanded(child: _buildBrand(item)),
            _buildPoint(item)
          ],
        ),
      ),
    );
  }

  Widget _buildBrand(SectionChild item) {
    double _size = 37;
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: AspectRatio(
              aspectRatio: 1,
              child: FadeInImageView(
                imageUrl: BasePKG().stringOf(() => item.rewardBrandLogo!),
                fit: BoxFit.contain,
                // width: _size,
                // height: _size
                forceQuantity: 300,
                ),
            ) 
            
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              BasePKG().stringOf(() => item.rewardBrand!),
              overflow: TextOverflow.ellipsis,
              style: BasePKG()
                  .text!
                  .normalBold()
                  .copyWith(color: BasePKG().color.titleItem),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoint(SectionChild item) {
    return Visibility(
      visible: item.hasRewardPoint,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.accentColor.withOpacity(0.9),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
        padding: BasePKG().symmetric(horizontal: 12, vertical: 8),
        child: RichText(
          text: TextSpan(
            text: "${item.rewardPoint}",
            children: [
              TextSpan(
                  text: " ${BaseTrans().$point}",
                  style: BasePKG().text!.point())
            ],
            style:
                BasePKG().text!.point().copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  SectionHomeViewProvider initProvider() {
    return SectionHomeViewProvider(this);
  }

  @override
  bool get wantKeepAlive => false;
}

class DiscountClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.lineTo(size.width, 0);
    _path.lineTo(size.width, size.height);
    _path.lineTo(size.width * 0.5, size.height * 0.8);
    _path.lineTo(0, size.height);
    return _path;
  }

  @override
  bool shouldReclip(DiscountClipper oldClipper) => true;
}

class ReadmoreClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.moveTo(size.width, 0);
    _path.lineTo(size.width, size.height);
    _path.lineTo(0, size.height);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(ReadmoreClipper oldClipper) => true;
}
