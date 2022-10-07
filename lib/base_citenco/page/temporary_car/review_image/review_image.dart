import 'dart:io';
import 'dart:math'; 
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'review_image_provider.dart';

class ReviewImage extends StatefulWidget {
  List? images;
  ReviewImage({Key? key, this.images}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReviewImageState();
  }
}

class ReviewImageState
    extends BasePage<ReviewImage, ReviewImageProvider> {
  @override
  ReviewImageProvider initProvider() {
    return ReviewImageProvider(this);
  }

  @override
  Widget buildBackground() {
    return Container(color: BasePKG().color.card);
  }

  @override
  Widget body() {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [close(), Expanded(child: zoom()), list()],
    ));
  }

  Widget close() {
    return CloseButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget zoom() {
    return InteractiveViewer(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size.width,
              height: size.width,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: provider.pageController,
                onPageChanged: provider.onPageChanged,
                children: List.generate(
                  max(provider.images.length, 1),
                  (index) => image(
                      url: BasePKG()
                          .stringOf(() => provider.images[index]!.url),
                      size: size.width,
                      forceQuantity: size.height),
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget list() {
    return Container(
      padding: BasePKG().symmetric(horizontal: provider.paddingList),
      child: SingleChildScrollView(
        controller: provider.scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              max(provider.images.length, 1),
              (index) => Consumer<CurrentNotifier>(builder: (ctx, value, _) {

                    bool isSelected = provider.images[index]!.id == value.value?.id;
                    return Opacity(
                      opacity: isSelected ? 1 : 0.3,
                      child: Container(
                          margin:
                              BasePKG().only(right: provider.paddingList),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: isSelected
                                    ? BasePKG().color.primaryColor
                                    : Colors.transparent,
                                width: 2),
                          ),
                          child: InkWell(
                              onTap: () => provider.onImagePressed(index),
                              child: ClipPath(
                                  clipper: BorderClipper(4),
                                  child: image(
                                      url: BasePKG()
                                          .stringOf(() => provider.images[index]!.url))))),
                    );
                  })),
        ),
      ),
    );
  }

  Widget image({String url = "", double? size, double? forceQuantity}) {
    bool isNetWork = url.startsWith("http") || url.startsWith("https");
    if(!isNetWork)
    return FadeInImage(
        placeholder: AssetImage("lib/special/modify/asset/image/logo/logo.png"),
        image: FileImage(File(url)),
        width: size ?? provider.miniSize,
        height: size ?? provider.miniSize,
        fit: BoxFit.cover);
        
    return FadeInImageView.fromSize(
      BasePKG().stringOf(() => url),
      width: size ?? provider.miniSize,
      height: size ?? provider.miniSize,
      fit: BoxFit.contain,
      forceQuantity: forceQuantity,
    );
  }
}
