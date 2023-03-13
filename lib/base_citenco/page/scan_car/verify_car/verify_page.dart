import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base_core/base_page.dart';
import 'verify_provider.dart';

class VerifyCarPage extends StatefulWidget {
  VerifyCarPage({
    Key? key,
    this.isOut = false,
  }) : super(key: key);
  bool isOut;
  @override
  VerifyCarPageState createState() => VerifyCarPageState();
}

class VerifyCarPageState extends BasePage<VerifyCarPage, VerifyCarProvider> {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context,
        height: 60,
        title: Text(
          "Quét xe vào trạm",
          style: BasePKG().text!.normalNormal().copyWith(color: Colors.white),
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }

  @override
  void didUpdateWidget(VerifyCarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (BasePKG().boolOf(() =>
    //     widget.resumeCamera != null &&
    //     oldWidget.resumeCamera != widget.resumeCamera)) {
    // provider.onOpenCamera(true);
    // }
  }

  @override
  Widget buildBackground() {
    return Container(color: Colors.white);
  }


  @override
  Widget body() {
    return Container(
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            "lib/base_citenco/asset/image/bg_home_bottom.png",
            width: size.width,
          ),
          Container(
            height: size.height,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      provider.state.widget.isOut
                          ? "Xác nhận xe đi ra thành công"
                          : "Xác nhận xe vô thành công",
                      style: BasePKG()
                          .text!
                          .captionMedium()
                          .copyWith(color: Colors.black.withOpacity(.7)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.toDashBoard();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffD1E0ED),
                            borderRadius: BorderRadius.circular(15)),
                        child: Consumer<CountDownNotifier>(
                            builder: (context, count, _) {
                          return RichText(
                              text: TextSpan(
                                  text: "Về màn hình chính \n",
                                  style: BasePKG()
                                      .text!
                                      .captionNormal()
                                      .copyWith(color: Color(0xff004D99)),
                                  children: [
                                    TextSpan(
                                        text:
                                            "Tự động quay lại (${count.value.toString()} giây)",
                                        style: BasePKG()
                                            .text!
                                            .smallLowerNormal()
                                            .copyWith(color: Colors.red))
                                  ]),
                              textAlign: TextAlign.center);
                        })),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  VerifyCarProvider initProvider() => VerifyCarProvider(this);
}
