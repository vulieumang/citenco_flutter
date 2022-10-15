import 'dart:io';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/camera.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/image_reviews_provider..dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';

import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ImageReviews extends StatefulWidget {
  final String? imagePath;
  final CameraScreenType? type;
  final Color? color;

  const ImageReviews({Key? key, this.imagePath, this.type, this.color})
      : super(key: key);

  @override
  ImageReviewsState createState() => ImageReviewsState();
}

class ImageReviewsState extends BasePage<ImageReviews, ImageReviewsProvider> {
  @override
  void initState() {
    appBar = AppBarData.backArrow(
      context,
      backgroundColor: widget.color,
      radius: 0,
      text: "${BaseTrans().$editImage}",
      actions: <Widget>[
        // IconButton(
        //   icon: SvgPicture.asset("lib/base_citenco/asset/image/crop_image.svg",
        //       height: 20, width: 20, color: BasePKG().color.appBarTitle),
        //   onPressed: () {
        //     provider.cropImageFunc();
        //   },
        // )
      ],
    );
    super.initState();
    provider.cropImageNotifier.value = File(widget.imagePath!);
  }

  @override
  ImageReviewsProvider initProvider() => ImageReviewsProvider(this);

  @override
  Widget body() {
    return Container(
      margin: BasePKG().only(bottom: 20),
      child: Material(
        color: BasePKG().color.card,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Consumer<CropImageNotifier>(
                    builder: (context, value, _) {
                      return Image.file(
                        File(value.value!.path),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                Container(
                  margin: BasePKG().all(10),
                  decoration: new BoxDecoration(color: BasePKG().color.card),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SquareButton(
                          margin: BasePKG().zero,
                          padding: BasePKG().all(12),
                          text: Utils.upperCaseFirst(BaseTrans().$cancel),
                          onTap: Navigator.of(context).pop,
                          theme: BasePKG().button!.negativeButton(context,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Consumer<CropImageNotifier>(
                          builder: (context, value, _) {
                            return SquareButton(
                              margin: BasePKG().zero,
                              padding: BasePKG().all(12),
                              text: Utils.upperCaseFirst(BaseTrans().$agree),
                              onTap: provider.comfirmImage,
                              theme: widget.color == null
                                  ? BasePKG().button!.primaryButton(context,
                                      fontWeight: FontWeight.normal)
                                  : BasePKG()
                                      .button!
                                      .primaryButton(context,
                                          fontWeight: FontWeight.normal)
                                      .copyWith(
                                          buttonColor: widget.color,
                                          canvasColor: widget.color),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
