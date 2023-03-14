import 'dart:typed_data';

import 'package:cnvsoft/base_citenco/model/upload_image_respo.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/qr_flutter/qr_flutter_page.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:cnvsoft/base_citenco/view/text_field.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:flutter/gestures.dart';
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

  dialogChangeName() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.dialog,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: BasePKG().all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text("Bạn muốn thay đổi thông tin tài xế!",
                  textAlign: TextAlign.center,
                  style: BasePKG()
                      .text!
                      .titleDialog()
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 18),
              width: size.width,
              child: TextFieldCustom(
                controller: provider.nameController,
                nameField: "Nhập họ tên tài xế",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareButton(
                  margin: BasePKG().zero,
                  padding: BasePKG().symmetric(vertical: 12, horizontal: 42),
                  text: "Xác nhận",
                  onTap: () {
                    if (provider.nameController.text.isNotEmpty) {
                      provider.state.widget.data!.vehicleDriverName =
                          provider.nameController.text;
                      provider.checkOldname();
                    }

                    Navigator.of(context).pop('OK');
                  },
                  radius: 8,
                  theme: BasePKG().button!.alternativeButton(context,
                      fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget body() {
    if (provider.state.widget.data == null) return Container();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Kiểm tra xe có đúng thông tin dưới đây trước khi cho vô trạm: ",
                style: BasePKG().text!.captionLowerNormal(),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Consumer<ChangeNameNotifier>(
                    builder: (context, show, snapshot) {
                  return Expanded(
                    child: Text(
                      "Tên tài xế: ${provider.state.widget.data!.vehicleDriverName}",
                      style: BasePKG().text!.captionLowerNormal(),
                      textAlign: TextAlign.start,
                    ),
                  );
                }),
                if (provider.state.widget.data!.actionType == 1)
                  Container(
                    child: Consumer<ChangeShowVerifyVehicleNotifier>(
                        builder: (context, change, snapshot) {
                      return Visibility(
                        visible: change.value!,
                        child: Row(
                          children: [
                            Consumer<RefreshNameNotifier>(
                                builder: (context, show, snapshot) {
                              return Visibility(
                                visible: !show.value!,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.refreshName();
                                  },
                                  child: Icon(
                                    Icons.refresh,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }),
                            GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    builder: (context) => dialogChangeName(),
                                    context: context);
                              },
                              child: Icon(
                                Icons.edit,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
              ],
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
              "Tải trọng:  ${provider.state.widget.data!.vehicleLoad} KG",
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
              "Địa chỉ xác nhận: ${provider.state.widget.data!.vehicleVerifiedBy}",
              style: BasePKG().text!.captionLowerNormal(),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Hợp tác xã:  ${provider.state.widget.data!.vehicleCollectionUnitName}",
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
                child: _imagesPicker(provider.state.widget.data!.images!)),
            SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer<OnCheckNotifier>(builder: (context, checked, _) {
                  return Checkbox(
                      value: checked.value!,
                      onChanged: (value) => provider.onChangCheck());
                }),
                Expanded(
                  child: Text(
                    "Tôi cam kết các thông tin khai báo là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật về tính xác thực của thông tin.",
                    style: BasePKG().text!.normalLowerNormal(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            if (provider.state.widget.data!.pendingHistoryId != null)
              Consumer2<ChangeNameNotifier, ChangeShowVerifyVehicleNotifier>(
                  builder: (context, show, changeVerify, snapshot) {
                return Visibility(
                  visible: show.value! && !changeVerify.value!,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: provider.submitOut,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 80,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text("Xác nhận xe ra",
                                  style: BasePKG()
                                      .text!
                                      .captionBold()
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            Consumer<ChangeShowVerifyVehicleNotifier>(
                builder: (context, changeVerify, snapshot) {
              return Column(
                children: [
                  Visibility(
                    visible: changeVerify.value!,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (StorageCNV().containsKey(
                                  "AddVehicleHistoryOverLimitation") &&
                              StorageCNV().getInt(
                                      "AddVehicleHistoryOverLimitation")! >=
                                  3 &&
                              provider.state.widget.data!.count! >=
                                  provider.state.widget.data!.dailyLimit!) ...[
                            GestureDetector(
                              onTap: provider.submitSend,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 80,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: BasePKG().color.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    "Xác nhận cho vô quá số lần quy định",
                                    style: BasePKG()
                                        .text!
                                        .captionBold()
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ] else
                            GestureDetector(
                              onTap: provider.submitSend,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 80,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: BasePKG().color.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text("Xác nhận xe vào",
                                      style: BasePKG()
                                          .text!
                                          .captionBold()
                                          .copyWith(color: Colors.white)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !changeVerify.value!,
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Nếu bạn cho phép xe vào vào trạm bấm \n',
                          style: BasePKG().text!.normalLowerNormal(),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'vào đây',
                                style: BasePKG()
                                    .text!
                                    .normalLowerNormal()
                                    .copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    provider.changeShowVerifyVehicle();
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 80,
            )
          ],
        ),
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
