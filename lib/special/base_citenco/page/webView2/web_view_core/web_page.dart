import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';
import 'web_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class FeedBackWebPage extends StatefulWidget {
  final String? urlView;

   const FeedBackWebPage(
      {Key? key,
      @required this.urlView,})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FeedBackWebebState();
  }
}

class FeedBackWebebState extends BasePage<FeedBackWebPage, FeedBackWebProivder>
    with DataMix {
  @override
  void initState() {
    var style = BasePKG().text!.appBarTitle();
    super.initState();
    appBar = AppBarData.backArrow(context,
        onBack: () => onBack(),
        title: Consumer<TitleNotifier>(
          builder: (context, value, _) {
            return Text(
              "${value.value}",
              style: style,
            );
          },
        ),
        actions: [actionAppbar(context)]);
  }

  onBack() async {
    if (await provider.checkWebHistory()) {
      provider.backInWebView();
    } else {
      if(ModalRoute.of(context)?.settings.name! == "dash_board"){
        BasePKG().bus!.fire<DashboardData>(DashboardData("navigate", data: 0));
      }else{
        Navigator.pop(context);
      }
    }
  }

  disableBackAndroid() async {
    if (await provider.checkWebHistory()) {
      return false;
    } else {
      return true;
    }
  }

  Container actionAppbar(context) {
    return Container(
      height: 34,
      width: 84,
      margin: EdgeInsets.only(top: 12, bottom: 10.79, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.09),
          border: Border.all(width: 1, color: Colors.white)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<LoadTooltipsNotifier>(builder: (context, show, _) {
            return Stack(
              children: [
                Center(
                  child: Center(
                    child: GestureDetector(
                      onTap: provider.onShowToolTips,
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Image(
                          image: AssetImage(
                              "lib/special/base_citenco/asset/image/3_dot.png"),
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: 0,
                  child: SimpleTooltip(
                    show: show.value!,
                    tooltipDirection: TooltipDirection.down,
                    ballonPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    borderColor: Colors.transparent,
                    arrowTipDistance: 0,
                    arrowLength: 10,
                    targetCenter: Offset(100, 100),
                    minimumOutSidePadding: 0,
                    child: Container(),
                    minWidth: 130,
                    tooltipTap: provider.onTapToolTips,
                    content: Material(
                      color: Colors.transparent,
                      child: Container(
                        child: Text("Reload",
                            style: BasePKG().text!.normalNormal()),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: Container(height: 24, width: 1, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              if(ModalRoute.of(context)?.settings.name! == "dash_board"){
                BasePKG().bus!.fire<DashboardData>(DashboardData("navigate", data: 0));
              }else{
                Navigator.pop(context);
              }
            },
            child: Container(
              child: Image(
                image: AssetImage(
                  "lib/special/base_citenco/asset/image/close_icon.png",
                ),
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  initProvider() {
    return FeedBackWebProivder(this);
  }
  
  @override
  Widget body() {
    return WillPopScope(
      onWillPop: () => disableBackAndroid(),
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(provider.url), headers: provider.header),
            onLoadStart: provider.onPageStarted,
            onLoadStop: provider.onPageFinished,
            onTitleChanged: provider.onChangeTitle,
            onWebViewCreated: provider.onWebViewCreated,
            androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
              return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
            },
            initialOptions:provider.options,
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              if (["file", "chrome",
                "data", "javascript", "about","tel","mailto"].contains(uri.scheme)) {
                if (await canLaunch(navigationAction.request.url!.toString())) {
                  launch(
                    navigationAction.request.url!.toString(),
                  );
                  return NavigationActionPolicy.CANCEL;
                }
              }
              return NavigationActionPolicy.ALLOW;
            },
          ),
        ],
      ),
    );
  }

  // @override
  // Widget lazyLoad(bool visible) {
  //   // return Container();
  //   return FeedBackLazy(this, visible);
  // }
}
