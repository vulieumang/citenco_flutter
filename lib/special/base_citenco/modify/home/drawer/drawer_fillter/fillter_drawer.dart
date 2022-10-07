 import 'package:cnvsoft/core/base_core/base_page.dart'; 
import 'package:cnvsoft/special/base_citenco/modify/home/drawer/drawer_fillter/checkBox.dart'; 
import 'package:cnvsoft/special/base_citenco/modify/home/drawer/drawer_fillter/widget_chips/widget_chips.dart';
import 'package:cnvsoft/special/base_citenco/modify/home/drawer/drawer_fillter/widget_chips/widget_chips_provider.dart'; 
import 'package:cnvsoft/special/base_citenco/package/package.dart'; 
import 'package:cnvsoft/special/base_citenco/package/trans.dart'; 
import 'package:cnvsoft/special/base_citenco/view/bottom_button.dart'; 
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'fillter_drawer_provider.dart';

enum ChildType { Sort, Filter }

class FillterDrawer extends StatefulWidget {
  const FillterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FillterDrawerState();
  }
}

class FillterDrawerState
    extends BasePage<FillterDrawer, FillterDrawerProvider> {
  @override
  FillterDrawerProvider initProvider() {
    return FillterDrawerProvider(this);
  }
 

  Widget buildTitleAppbar() {
    return Row(children: [
      Container(
          width: 25,
          child: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                      "lib/special/base_citenco/asset/image/close.png",
                      width: 20,
                      height: 20,
                      color: Colors.black),
                ),
              ],
            ),
          )),
      SizedBox(width: 8),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Bộ lọc",
              style: BasePKG()
                  .text!
                  .smallUpperBold()
                  .copyWith(color: Colors.black),
            ),
          ),
        ],
      )),
      SizedBox(width: 8),
      Container(
          // padding: EdgeInsets.symmetric(horizontal: 12),
          child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Text(
          "Đặt lại",
          style: BasePKG()
              .text!
              .smallLowerBold()
              .copyWith(color: BaseColor().primaryColor),
        ),
      )),
    ]);
  }

  @override
  Widget body() {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Bạn đang tìm kiếm?",
                      style: BasePKG()
                          .text!
                          .largeUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                provider.listTabBodyInfo.length,
                                (index) => _buildButtonTab(
                                    buttonText: provider.listTabBodyInfo[index]
                                        [0],
                                    assetIcon: provider.listTabBodyInfo[index]
                                        [1],
                                    index: index))),
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xffF5F4F8),
                  ),
                  Expanded(
                      child: PageView(
                          controller: provider.pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                        StartupFillter(),
                        Investors(),
                        Nursery(),
                      ])),
                ],
              ),
            ),
          ),
          BottomButtonView(text: "Áp dụng", onTap: provider.onStartPressed)
        ],
      ),
    );
  }

  Container Investors() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Quốc gia đăng ký",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn quốc gia",
                    listData: [ItemInput("Chọn quốc gia")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Lĩnh vực ưu tiên",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn các lĩnh vực",
                    listData: [
                      ItemInput("Chọn các lĩnh vực"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Giai đoạn phát triển",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn Giai đoạn phát triển",
                    listData: [ItemInput("Giai đoạn phát triển")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Vòng đầu tư",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  Column(
                    children: [
                      GetCheckValue(),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Container Nursery() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Lĩnh vực ưu tiên",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn Lĩnh vực ưu tiên",
                    listData: [ItemInput("Tài chính"), ItemInput("Công nghệ")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Quốc gia",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn quốc gia",
                    listData: [ItemInput("Viet Nam"), ItemInput("Hoa Ky")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Địa phương",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn địa phương",
                    listData: [ItemInput("Viet Nam"), ItemInput("Hoa Ky")],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container StartupFillter() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<DemandNotifier>(builder: (ctx, demand, _) {
              return Container(
                child: _buildDemand(demand.value),
              );
            }),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "${BaseTrans().$field_of_activity}",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn ${BaseTrans().$field_of_activity}",
                    listData: [ItemInput("${BaseTrans().$field_of_activity}")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Chọn mô hình kinh doanh",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn mô hình kinh doanh",
                    listData: [ItemInput("Chọn mô hình kinh doanh")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Chọn địa phương kinh doanh",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn địa phương kinh doanh",
                    listData: [ItemInput("Chọn địa phương kinh doanh")],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Chọn giai đoạn phát triển",
                      style: BasePKG()
                          .text!
                          .smallUpperBold()
                          .copyWith(color: Color(0xff0D2A5C)),
                    ),
                  ),
                  WidgetChips(
                    nameField: "Chọn giai đoạn phát triển",
                    listData: [ItemInput("Chọn giai đoạn phát triển")],
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  _buildDemand(int? value, {bool withOther = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(
            "Nhu cầu gọi vốn",
            style: BasePKG()
                .text!
                .smallUpperBold()
                .copyWith(color: Color(0xff0D2A5C)),
          ),
          SizedBox(height: 15),
          Row(
            children: List.generate(2, (index) {
              var _icon = value == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked;
              var _text = provider.getDemand(index);
              return Expanded(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Icon(_icon,
                                color: BasePKG().color.primaryColor,
                                size: 22),
                            Padding(
                              padding: BasePKG().symmetric(
                                  horizontal: BasePKG().convert(8)),
                              child: Text(
                                _text,
                                style: BasePKG().text!.normalNormal(),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () => provider.setDemand(index),
                    ),
                    Spacer(),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 33),
        ],
      ),
    );
  }

  Widget _buildButtonTab({String? buttonText, String? assetIcon, int? index}) {
    return Consumer<IndexTabSelectedNotifier>(builder: (context, value, _) {
      return GestureDetector(
        onTap: () => provider.onTabChange(index!),
        child: Container(
            decoration: provider.buttonDecorationNew(index!),
            margin: EdgeInsets.only(right: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              child: Text(BasePKG().stringOf(() => buttonText),
                  style: provider.buttonTextStyle(index)),
            )),
      );
    });
  }
}
