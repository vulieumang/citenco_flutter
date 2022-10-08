import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/page/home/drawer/drawer.dart';
import 'package:cnvsoft/base_citenco/page/home/home_lazy.dart';
import 'package:cnvsoft/base_citenco/page/home/home_provider.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePage<HomePage, HomeProvider> with DataMix {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context,
        flexibleSpace: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        "CÔNG TY TNHH MTV MÔI TRƯỜNG ĐÔ THỊ TPHCM",
                        style: BasePKG()
                            .text!
                            .normalNormal()
                            .copyWith(color: Colors.white),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  "Quản lý xe ra vào trạm",
                  style: BasePKG()
                      .text!
                      .normalBold()
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  HomeProvider initProvider() => HomeProvider(this);

  @override
  Widget buildBackground() {
    return Container(color: Colors.white);
  }

  @override
  Widget body() {
    return HomePage1();
  }

  RefreshIndicator HomePage1() {
    return RefreshIndicator(
        key: provider.refreshIndicator,
        onRefresh: provider.onRefresh,
        color: BasePKG().color.primaryColor,
        child: Center(
          child: Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BasePKG().color.card,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "lib/base_citenco/asset/image/bg_home_bottom.png",
                  width: size.width,
                ),
                Container(
                  height: size.height,
                  width: size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Xin chào: Nguyễn Văn A ",
                          style: BasePKG().text!.captionLowerNormal(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Trạm: Long Hoà",
                          style: BasePKG().text!.captionLowerNormal(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Đăng xuất",
                                style: BasePKG()
                                    .text!
                                    .largeLowerBold()
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "lib/base_citenco/asset/image/ic_logout.png",
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Vui lòng chọn",
                          style: BasePKG()
                              .text!
                              .captionNormal()
                              .copyWith(color: Colors.black.withOpacity(.7)),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "scan_car");
                          },
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: Color(0xffD1E0ED),
                                border: Border.all(
                                    color: Color(0xffF1EEEE), width: 3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Quét xe vào trạm",
                                  style: BasePKG()
                                      .text!
                                      .captionBlack()
                                      .copyWith(color: Color(0xff004D99)),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Image.asset(
                                  "lib/base_citenco/asset/image/ic_location_xe.png",
                                  width: 25,
                                  height: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "temporary_car");
                          },
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: Color(0xffD1E0ED),
                                border: Border.all(
                                    color: Color(0xffF1EEEE), width: 3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Nhập xe vãng lai",
                                  style: BasePKG()
                                      .text!
                                      .captionBlack()
                                      .copyWith(color: Color(0xff004D99)),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Image.asset(
                                  "lib/base_citenco/asset/image/ic_location_xe.png",
                                  width: 25,
                                  height: 25,
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget lazyLoad(bool visible) {
    return HomeLazy(
      this,
      visible,
    );
  }
}
