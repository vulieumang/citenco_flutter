import 'dart:typed_data';

import 'package:cnvsoft/base_citenco/model/upload_image_respo.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:cnvsoft/base_citenco/view/linear_percent.dart';
import 'package:cnvsoft/base_citenco/view/text_field.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'temporary_car_provider.dart';

class TemporaryCarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TemporaryCarPageState();
}

class TemporaryCarPageState extends BasePage<TemporaryCarPage, TemporaryCarProvider>
    with DataMix {
  @override
  void initState() {
    // appBar = AppBarData(
    //   context,
    //   flexibleSpace: Container(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 child: Text(
    //                   "CÔNG TY TNHH MTV MÔI TRƯỜNG ĐÔ THỊ TPHCM",
    //                   style: BasePKG().text!.normalNormal().copyWith(color: Colors.white),
    //                   maxLines: 2,
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ), 
    //       ],
    //     ),
    //   )
    // );
    super.initState();
  } 

  @override
  TemporaryCarProvider initProvider() => TemporaryCarProvider(this);
  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column( 
        children: [  
          Container(
            padding: EdgeInsets.symmetric( horizontal: 20,vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Đăng ký xe vãng lai",
                  style: BasePKG().text!.largeUpperBold().copyWith(color: Color(0xff0089FF)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric( horizontal: 20),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector( 
                    child: Container(
                      child: Text(
                        "Biển số xe",
                        style: BasePKG().text!.largeUpperBold().copyWith(color: Color(0xff023C6D)),
                      )
                    ),
                  )
                ],
              ),
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TextFieldCustom(
              controller: TextEditingController(),
              nameField: "Nhập biển số xe",
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric( horizontal: 20),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector( 
                    child: Container(
                      child: Text(
                        "Khối lượng (KG)",
                        style: BasePKG().text!.largeUpperBold().copyWith(color: Color(0xff023C6D)),
                      )
                    ),
                  )
                ],
              ),
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: TextFieldCustom(
              controller: TextEditingController(),
              nameField: "Khối lượng (KG)",
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric( horizontal: 20),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector( 
                    child: Container(
                      child: Text(
                        "Hình ảnh",
                        style: BasePKG().text!.largeUpperBold().copyWith(color: Color(0xff023C6D)),
                      )
                    ),
                  )
                ],
              ),
            )
          ),
          SizedBox(height: 20,),
          Padding(
            padding: BasePKG().symmetric(horizontal: 20),
            child: Container( 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(width: 1,color: Color(0xff539EF8))
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                _addImages(),
              ]),
            )),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: BasePKG().color.primaryColor,
              borderRadius: BorderRadius.circular(50)
            ),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Ghi lại",
                style: BasePKG().text!.captionBold().copyWith(color: Colors.white)
              ),
            ),
          )
        ],
      ),
    );
  } 

  Widget _addImages() {
    return Consumer<ImagesReviewNotifier>(builder: (ctx, images, _) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Visibility(
              visible: images.value!.length < 0,
              child: _camera(5)
            )
            ],
          ),
          Visibility(
              visible: BasePKG().listOf(() => images.value).isNotEmpty,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () => provider.onImagePressed(images.value,context),
                    child: Row(
                      children: [
                        Container(
                            width: size.width - 80,
                            child: _imagesPicker(images.value)),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      );
    });
  }


  Widget _imagesPicker(List<ImageUploaded>? images) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: BasePKG().convert(16),
      spacing: BasePKG().convert(16),
      children: List.generate(BasePKG().listOf(() => images).length,
          (index) =>  
          _image(BasePKG().dataOf(() => images?[index]), index))
        ..addAll(
          [

          (BasePKG().listOf(() => images).length <5  )
              ? _camera(
                  5 - BasePKG().listOf(() => images).length)
              : SizedBox()
        ]
      ),
    );
  }


  Widget _image(ImageUploaded? imageUploaded, int index) {
    double size = 72.0;
    double heightIndicator = 3;
    double radius = 4;

    return ChangeNotifierProvider.value(
      value: imageUploaded,
      child: Consumer<ImageUploaded?>(builder: (ctx, item, _) {
        String image = stringOf(() => imageUploaded?.path);
        bool isNetWork = image.startsWith("http") || image.startsWith("https");
        bool loading = BasePKG().doubleOf(() => item?.percent) > 0 &&
            BasePKG().doubleOf(() => item?.percent) < 1;

        return ClipPath(
          clipper: BorderClipper(radius),
          child: SizedBox(
            width: size,
            child: Stack(alignment: Alignment.bottomLeft, children: [
              Opacity(
                opacity: loading ? 0.5 : 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topRight,
                  children: [
                    isNetWork
                        ? _imageNetwork(image, size, index, radius)
                        : _imageFile(image, size, index, radius),
                    _buildRemoveBtn(index)
                  ],
                ),
              ),
              Visibility(
                  visible: loading,
                  child: LinearPercent(
                    width: size,
                    height: heightIndicator,
                    percent: BasePKG().doubleOf(() => item?.percent),
                    percentColor: BasePKG().color.primaryColor,
                  ))
            ]),
          ),
        );
      }),
    );
  }

  Widget _buildRemoveBtn(int index) {
    return Visibility( 
      child: Positioned(
        top: -5,
        right: -5,
        child: InkWell(
          onTap: () => provider.removeImage(index),
          child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2))
              ]),
              child: SvgPicture.asset(
                "lib/base_citenco/asset/image/remove.svg",
                height: 20,
                width: 20,
              )),
        ),
      ),
    );
  }
  
  Widget _imageNetwork(String image, double size, int index, double radius) {
    return FadeInImageView.fromSize(
      image,
      width: BasePKG().convert(size),
      height: BasePKG().convert(size),
    );
  }

  Widget _imageFile(String image, double size, int index, double radius) {
    return FadeInImage(
        placeholder: AssetImage("lib/special/modify/asset/image/logo/logo.png"),
        image: FileImage(File(image)),
        width: BasePKG().convert(size),
        height: BasePKG().convert(size),
        fit: BoxFit.cover);
  }

  Widget _camera(int slotAvail) {
    bool emptyImage = slotAvail == 5;
    double size = emptyImage ? 48 : 72;
    double cameraW = emptyImage ? 20 : 27.17;
    double cameraH = emptyImage ? 18 : 24.45;
    double radius = 2.38;
    double space = emptyImage ? 5 : 6.79;
    return InkWell(
      onTap: provider.onSelectImage,
      child: CustomPaint(
        painter: DotBorderPainter(
            color: BasePKG().color.primaryColor, strokeWidth: 0.6, gap: 1.19),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "lib/base_citenco/asset/image/ic_camera.png",
                    width: cameraW,
                    height: cameraH,
                    color: BasePKG().color.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: space),
              Text("$slotAvail/${5}",
                  style: BasePKG()
                      .text
                      ?.smallLowerNormal()
                      .copyWith(color: BasePKG().color.primaryColor))
            ],
          ),
        ),
      ),
    );
  }
}
