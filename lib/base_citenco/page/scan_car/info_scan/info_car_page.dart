import 'dart:typed_data';

import 'package:cnvsoft/base_citenco/model/upload_image_respo.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/qr_flutter/qr_flutter_page.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../../../model/scand_model.dart';
import 'info_car_provider.dart';

class InfoCarPage extends StatefulWidget {
  DataData? data;
  InfoCarPage({this.data}) : super();
  @override
  State<StatefulWidget> createState() => InfoCarPageState();
}

class InfoCarPageState extends BasePage<InfoCarPage, InfoCarProvider>
    with DataMix {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context,
        height: 50,
        title: Text(
          "Quét xe vào trạm",
          style: BasePKG().text!.normalNormal().copyWith(color: Colors.white),
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }

  @override
  InfoCarProvider initProvider() => InfoCarProvider(this);
  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Kiểm tra xe có đúng thông tin dưới đây trước khi cho vô trạm: ",
            style: BasePKG().text!.captionLowerNormal(),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Biển số: ${provider.state.widget.data!.vehicleLicensePlate}",
            style: BasePKG().text!.captionLowerNormal(),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Loại xe:  ${provider.state.widget.data!.vehicleType}",
            style: BasePKG().text!.captionLowerNormal(),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Số lần đã vô  ${provider.state.widget.data!.count}/${provider.state.widget.data!.dailyLimit}",
            style: BasePKG().text!.captionLowerNormal(),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Hình ảnh",
            style: BasePKG().text!.captionLowerNormal(),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              width: size.width - 80,
              child: _imagesPicker(provider.state.widget.data!.images!))
        ],
      ),
    );
  }

  Widget _imagesPicker(List<ImageScan> images) {
    return Wrap(
        alignment: WrapAlignment.start,
        runSpacing: BasePKG().convert(16),
        spacing: BasePKG().convert(16),
        children: List.generate(BasePKG().listOf(() => images).length,
            (index) => _image(BasePKG().dataOf(() => images[index]), index)));
  }

  Widget _image(ImageScan? imageUploaded, int index) {
    double size1 = size.width / 3;
    double heightIndicator = 3;
    double radius = 4;

    return ClipPath(
      clipper: BorderClipper(radius),
      child: SizedBox(
          width: size1 - 25,
          child: _imageNetwork(
              BasePKG().env!.accountDomainName! + imageUploaded!.imagePath!,
              size1 - 25,
              index,
              radius)),
    );
  }

  Widget _imageNetwork(String image, double size, int index, double radius) {
    return FadeInImageView.fromSize(
      image,
      width: BasePKG().convert(size),
      height: BasePKG().convert(size),
      fit: BoxFit.contain,
    );
  }
}
