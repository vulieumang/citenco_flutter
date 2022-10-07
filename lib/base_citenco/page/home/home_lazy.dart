 import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/package/package.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cnvsoft/base_citenco/view/lazy_load.dart';

class HomeLazy extends BaseLazyLoad with DataMix {
  HomeLazy(State<StatefulWidget> state, this.visible,
      {this.getClipperHeight})
      : super(state, visible, durationToHide: false);

  final bool visible;

  final double? getClipperHeight;
  String get cipplerImage =>
      "lib/special/modify/asset/image/header_background.png";

  @override
  Widget lazyLoad() {
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: BasePKG().only(bottom: 12),
        child: Container(
          color: BasePKG().color.card,
          child: Column(
            children: <Widget>[
              _buildStandardHeader(),
            ],
          ),
        ));
  } 
  Widget _buildStandardHeader() {
    return Container(
      child: Stack(children: <Widget>[  
        SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 8),
                buildStandardUserInfo(),
                SizedBox(height: 39),
                 _buildMenuIcon(4,
                    shape: BoxShape.rectangle, size: 61, radius: 4), 
                SizedBox(height: 26),
                _buildSlide(), 
                SizedBox(height: 37),
                _buildReward(),
                SizedBox(height: 44),
                _buildBlog()
              ],
            ))
      ]),
    );
  }
 
  Widget buildStandardUserInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: Colors.grey[100]
      ),
      padding: EdgeInsets.only(bottom: 5),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: BasePKG().only(right: 14, left: 14, top: 14, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      child: line(
                        width: 30,
                        height: 30, 
                        radius: 4
                      ),
                    ),
                    SizedBox(width: 20,),
                    _buildAvatar(),
                    Expanded(child: _buildUserInfo()),
                    Container(
                      child: line(
                        width: 30,
                        height: 30, 
                        radius: 4
                      ),
                    ),
                  ],
                ),
                line(width: size.width,height: 36,radius: 20,top: 30)
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildAvatar() {
    double sizeHomeUserAvatar = BasePKG().convert(32);
    return Container(
      child: line(
        width: sizeHomeUserAvatar,
        height: sizeHomeUserAvatar,
        radius: sizeHomeUserAvatar/2
      ),
    );
    // return GestureDetector(
    //   onTap: () => MyProfile().loginAuthentic(state,
    //       () => BasePKG().bus!.fire<DashboardData>(DashboardData("profile"))),
    //   child: ClipPath(
    //       clipper: BorderClipper(sizeHomeUserAvatar / 2.0),
    //       child: FadeInImageView.fromSize(stringOf(() => MyProfile().avatarUrl),
    //           errorImage: "lib/special/modify/asset/image/avatar.png",
    //           cacheKey: StorageCNV().getString(MyProfile().imageKey),
    //           width: sizeHomeUserAvatar,
    //           height: sizeHomeUserAvatar,
    //           httpsRequiered: false)),
    // );
  }

  Widget _buildUserInfo() {
    return GestureDetector( 
      child: Container(
          color: Colors.transparent,
          padding: BasePKG().symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              line(width: 80, height: 8,top: 5),
              line(width: 90, height: 8,top: 5),
            ],
          )),
    );
  }

  buildNotificationIcon() {
    double widthNotificationIcon = BasePKG().convert(25);
    int count = 0;
    return Row(
      children: [
        GestureDetector(
            onTap: () => Navigator.of(context).pushNamed("announcement"),
            child: Container(
                padding: EdgeInsets.only(left: 12),
                color: Colors.transparent,
                child: Stack(alignment: Alignment.topRight, children: <Widget>[
                  Padding(
                      padding: count == 0
                          ? EdgeInsets.zero
                          : EdgeInsets.only(right: count > 99 ? 10 : 8, top: 4),
                      child: SvgPicture.asset(
                          "lib/special/base_citenco/asset/image/bell.svg",
                          color: BasePKG().color.iconColorPr,
                          width: widthNotificationIcon,
                          height: widthNotificationIcon)),
                  buildNumberOfNotification(count)
                ]))),
        // buildSocialMessager(widthNotificationIcon)
      ],
    );
  }

  Widget buildNumberOfNotification(int count) {
    return Visibility(
        visible: count > 0,
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BasePKG().color.bgNumberOfNotification),
            padding: EdgeInsets.all(3),
            child: Padding(
                padding: count < 10
                    ? EdgeInsets.symmetric(horizontal: 2)
                    : EdgeInsets.zero,
                child: Text(count > 99 ? "99+" : count.toString(),
                    style: count > 99
                        ? BasePKG()
                            .text!
                            .tinyLowerBold()
                            .copyWith(color: Colors.white)
                        : BasePKG()
                            .text!
                            .tinyUpperBold()
                            .copyWith(color: Colors.white)))));
  }

  Widget buildLevelView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 4, right: 14),
          child: Row(children: [
            Expanded(
                child: Row(children: [
                  line(width: 22,height: 22), 
              Expanded(
                child: Padding(
                    padding: BasePKG().symmetric(horizontal: 12),
                    child: line(width: 120,height: 12)),
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(children: [
                    line(width: 60,height: 20),
                    SizedBox(width: 8),
                    line(width: 120,height: 12)
                  ]),
                ),
              )
            ])),
          ]),
        ),
      ],
    );
  }

  Widget buildHeaderMenu({bool showLevel: true}) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF612A37).withOpacity(.25), //Colors.black12,
                  blurRadius: 40.0, // has the effect of softening the shadow
                  spreadRadius: -12.0, // has the effect of extending the shadow
                  offset: Offset(0, 1))
            ],
            color: BasePKG().color.homeGridMenuBg,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(right: 14, left: 14, bottom: 16),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildMenuIcon(4),
                    SizedBox(height: 8),
                    _buildMenuTitle(4),
                  ],
                )),
          ],
        ));
  }

  Widget _buildMenuIcon(int length,
      {BoxShape shape = BoxShape.circle, double size = 54, double radius = 0}) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            length,
            (index) => Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      line(width: size, height: size,radius: shape != BoxShape.circle
                                ? radius
                                : size/2),
                    ],
                  ),
                )));
  }

  Widget _buildMenuTitle(int length) {
    double width = 42;
    double height = 8;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            length,
            (index) => Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      line(width: width,
                        height: height,), 
                    ],
                  ),
                )));
  }

  Widget _buildSlide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 188, 
        child: line(
          height: 188,
          width: size.width,
          radius: 0
        )
      ),
    );
  }

  Widget _buildReward() {
    return Column(
      children: List.generate(1, (index) => listReward()),
    );
  }

  Widget listReward() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: line(width: 120,height: 12,),
                ),
                Container(
                  child: line(width: 80,height: 12,),
                )
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  children: List.generate(6, (index) => itemStartup())
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  
  Container itemStartup(
    {
      String? imageUrl = "https://picsum.photos/600/600",
      String? date = "Th9, 2022",
      String? founder = "2 Founder",
      String? address = "TP.HCM",
      String? title = "Công ty cổ phần CNV Loyalty"
    }
  ) {
    return Container(
      width: 322,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child:  Stack(
              alignment: Alignment.bottomLeft,
              children: [
                line(
                  radius: 6,
                  height: 131,
                  width: 131,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5,bottom: 5),
                  child: Container( 
                    child: line(
                      height: 10,
                      width: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: line(
                      height: 12,
                      width: 120,
                    ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 13),
                  child: Row(
                    children: [ 
                      line(
                        height: 14,
                        width: 14,
                        radius: 2
                      ), 
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: line(
                          height: 10,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: [ 
                      line(
                        height: 14,
                        width: 14,
                        radius: 2
                      ), 
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: line(
                          height: 10,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: [ 
                      line(
                        height: 14,
                        width: 14,
                        radius: 2
                      ), 
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: line(
                          height: 10,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                )
            ],),
          ))
        ],
      )
    );
  }


  Widget itemReward() {
    double width = 256;
    return Container(
        width: width,
        margin: BasePKG().only(right: 22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          line(width: 154,
              height: 16,radius: 4),
          SizedBox(height: 18),
          line(width: width,
              height: 132,radius: 4),
          SizedBox(height: 12),
          
          Container(
              margin: BasePKG().only(left: 7),
              width: 228,
              height: 8,
              decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: line(width: 228,
              height: 8,radius: 4),
          ),
          SizedBox(height: 12),
          Container(
              margin: BasePKG().only(left: 7),
              width: 154,
              height: 8,
              decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            child: line(width: 154,
              height: 8,radius: 4),        
          ),
          SizedBox(height: 12),
          Container(
              margin: BasePKG().only(left: 7),
              width: 121,
              height: 8,
              decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.all(Radius.circular(4))), 
                child: line(
                  width: 121,
                  height: 8,
                  radius: 4),
                ),
        ]));
  }

  Widget _buildBlog() {
    return Column(
      children: List.generate(1, (index) => listReward()),
    );
  }
}
