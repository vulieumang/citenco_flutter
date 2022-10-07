import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
// import 'package:cnvsoft/special/ecommerce/ecommerce_product/ecommerce_product_popup.dart';
// import 'package:cnvsoft/special/ecommerce/model/ecommerce_product_cart.dart';
// import 'package:cnvsoft/special/ecommerce/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CNVItemProduct extends StatefulWidget {
  String? imageUrl;
  dynamic percent;
  // ProductCart? f;
  bool? isPlus;
  Function()? onshowAddToCart;
  String? priceText;
  bool? allowBuyProduct;
  Function()? onPlusPressed;
  CNVItemProduct(
      {Key? key,
      this.imageUrl,
      this.percent,
      // this.f,
      this.isPlus = true,
      this.onshowAddToCart,
      this.priceText,
      this.allowBuyProduct,
      this.onPlusPressed})
      : super(key: key);

  @override
  State<CNVItemProduct> createState() => _CNVItemProductState();
}

class _CNVItemProductState extends State<CNVItemProduct> with DataMix {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            child: Padding(
              padding: BasePKG().all(10),
              child: Container(
                decoration: BoxDecoration(
                    // color: BasePKG().color.bgProduct,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 20,
                        spreadRadius: -2,
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: ClipPath(
                  clipper: BorderClipper(8),
                  child: Container(
                      color: BasePKG().color.card,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          _buildProductImage(widget.imageUrl!, widget.percent!),
                          // _buildDetailProductGrid(widget.f!)
                        ],
                      )),
                ),
              ),
            ),
            onTap: widget.onshowAddToCart));
  }

  // Widget _buildDetailProductGrid(ProductCart item) {
  //   return Container(
  //     padding: BasePKG()
  //         .symmetric(vertical: 10, horizontal: 13)
  //         .copyWith(bottom: 15),
  //     constraints: BoxConstraints(minHeight: 65),
  //     alignment: Alignment.center,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Container(
  //           child: Text(stringOf(() => item.titleDetail),
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               textAlign: TextAlign.left,
  //               style: BasePKG()
  //                   .text!
  //                   .smallMedium()
  //                   .copyWith(height: BasePKG().text!.small / 10)),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Expanded(child: _buildPrice(item)),
  //             SizedBox(width: 5),
  //             Opacity(
  //                 opacity: widget.allowBuyProduct! && widget.isPlus! ? 1 : 0,
  //                 child: InkWell(
  //                   customBorder: CircleBorder(),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: BasePKG().color.iconColorPr,
  //                           borderRadius: BorderRadius.circular(16)),
  //                       child: SvgPicture.asset(
  //                         "lib/special/ecommerce/asset/image/plus.svg",
  //                         color: BasePKG().color.primaryColor,
  //                         height: 18,
  //                         width: 18,
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: widget.onPlusPressed,
  //                 )
  //                 // InkWell(
  //                 //   onTap: () => provider.onPlusPressed(item),
  //                 //   child: Container(
  //                 //     padding: BasePKG().all(5),
  //                 //     child: SvgPicture.asset(
  //                 //       "lib/special/ecommerce/asset/image/plus_product.svg",
  //                 //       color: BasePKG().color.primaryColor,
  //                 //     ),
  //                 //   ),
  //                 // ),
  //                 ),
  //           ],
  //         ),
  //         _buildComparePrice(item)
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProductImage(String imageUrl, dynamic percent) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
            child: AspectRatio(
          aspectRatio: 1,
          child: FadeInImageView(
            imageUrl: BasePKG().stringOf(() => imageUrl),
            errorImage: "lib/special/ecommerce/asset/image/img_product_err.png",
            fit: BoxFit.contain,
            width: 100,
            height: 100,
          ),
        )),
        // Visibility(
        //     visible: (widget.f!.value!.availableQuantity! <= 0) &&
        //         !widget.f!.value!.allowPurchaseWhenSoldOut!,
        //     child: AspectRatio(aspectRatio: 1, child: isOutOfStock())),
        Opacity(
            opacity: percent > 0 ? 1 : 0,
            child: Container(
              width: 42,
              height: 25,
              decoration: BoxDecoration(
                  color: BasePKG().color.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(8))),
              alignment: Alignment.center,
              child: Text(
                "-${percent.toStringAsFixed(0)}%",
                style: BasePKG()
                    .text!
                    .smallLowerMedium()
                    .copyWith(color: Colors.white),
              ),
            )),
        // _buildPercent(percent),
      ],
    );
  }

  // Widget _buildComparePrice(ProductCart item) {
  //   return Visibility(
  //       visible: boolOf(() =>
  //           (item.value?.comparePrice != null) &&
  //           (item.value?.comparePrice ?? 0) > (item.value?.price ?? 0)),
  //       child: boolOf(() =>
  //               (item.value?.comparePrice != null) &&
  //               (item.value?.comparePrice ?? 0) > (item.value?.price ?? 0))
  //           ? Text(
  //               stringOf(() => Utils.numberToCurrency(
  //                   source: item.value?.comparePrice?.toInt() ?? 0)),
  //               maxLines: 1,
  //               overflow: TextOverflow.clip,
  //               style: BasePKG().text!.smallLowerBold().copyWith(
  //                   color: BasePKG().color.description,
  //                   decoration: TextDecoration.lineThrough),
  //             )
  //           : Opacity(
  //               opacity: 0,
  //               child: Text(
  //                 "0",
  //                 maxLines: 1,
  //                 overflow: TextOverflow.clip,
  //                 style: BasePKG().text!.normalUpperBold(),
  //               ),
  //             ));
  // }

  // Widget _buildPrice(ProductCart item) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Text(
  //       "${widget.priceText!}",
  //       style: BasePKG()
  //           .text!
  //           .smallUpperBold()
  //           .copyWith(color: BasePKG().color.primaryColor),
  //     ),
  //   );
  // }
}
