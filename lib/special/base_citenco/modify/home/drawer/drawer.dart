import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'drawer_provider.dart';

enum ChildType { Sort, Filter }

class HomeDrawer extends StatefulWidget {

  const HomeDrawer(
      {Key? key,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeDrawerState();
  }
}

class HomeDrawerState extends BaseView<HomeDrawer, HomeDrawerProvider> {
  @override
  HomeDrawerProvider initProvider() {
    return HomeDrawerProvider(this);
  }

  @override
  Widget body() {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Color(0xff011029),
        image: DecorationImage(
          image: AssetImage("lib/special/base_citenco/asset/image/bg_star.png",),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
        ), 
        child: SafeArea(
          child: Column(
            children: [
              headerClose(),
              SizedBox(width: 16,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(provider.data.length, (index){
                      return GestureDetector(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:  provider.data[index].onTapString,
                              child: ItemList(index)
                            ),
                            Divider(color: Color(0xff143470),thickness: 1,height: 1,)
                          ],
                        )
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container ItemList(int index) {
    return Container(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          "${provider.data[index].asset!}",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          "${provider.data[index].name!}",
                          style: BasePKG().text!.smallUpperNormal().copyWith(color: Colors.white)
                        )
                      )
                    ],
                  )
                );
  }

  Row headerClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () { Navigator.pop(context);},
          child: Container(
            child: Image.asset("lib/special/base_citenco/asset/image/close.png",width: 30,height:30 ,),
          ),
        ),
        SizedBox(width: 20,),
        Expanded(child: _buildUserInfo(context)),
        _buildAvatar(),
      ]);
  }

  Widget _buildUserInfo(BuildContext context) {
    return GestureDetector(
        onTap: () => MyProfile().loginAuthentic(
            this,
            () => BasePKG().bus!.fire<DashboardData>(DashboardData(
                BaseScope().newUIProfile ? "membership_new" : "membership"))),
        child: Container(
            color: Colors.transparent,
            padding: BasePKG().symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          text: "${BaseTrans().$hello},",
                          style: BasePKG()
                              .text!
                              .normalLowerNormal()
                              .copyWith(color: BasePKG().color.homeUserInfo),
                    )),
                  SizedBox(height: 2),
                  Text(
                    "${MyProfile().name}",
                    style: BasePKG()
                        .text!
                        .normalBold()
                        .copyWith(
                            color: BasePKG().color.primaryColor1)
                  ),
                ])));
  }

  _buildAvatar() {
    double sizeHomeUserAvatar = 44;
    return GestureDetector(
        // onTap: () => MyProfile().loginAuthentic(this,
        //     () => BasePKG().bus!.fire<DashboardData>(DashboardData("profile"))),
        child: ClipPath(
            clipper: BorderClipper(sizeHomeUserAvatar / 2.0),
            child: FadeInImageView.fromSize(
                 MyProfile().avatarUrl!,
                errorImage: "lib/special/base_citenco/asset/image/avatar.png",
                width: sizeHomeUserAvatar,
                height: sizeHomeUserAvatar,
                httpsRequiered: false)));
  }
}
