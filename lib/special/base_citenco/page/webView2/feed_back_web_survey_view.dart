import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/page/webView2/web_view_core/web_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';


class FeedBackSurvayWebView extends StatelessWidget {
  const FeedBackSurvayWebView({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FeedBackWebPage(
      urlView:  BaseScope().env?.env == "staging"
      ? 'https://social-staging.cnvloyalty.com/${BaseScope().env?.accountDomainName}/customer-experience/feedback-survey/list'
      : 'https://social.cnvloyalty.com/${BaseScope().env?.accountDomainName}/customer-experience/feedback-survey/list'
    );
  }
}


// class FeedBackWebPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return FeedBackWebebState();
//   }
// }

// class FeedBackWebebState extends BasePage<FeedBackWebPage, FeedBackWebProivder>
//     with DataMix {
//   @override
//   void initState() {
//     var style = BasePKG().text!.appBarTitle();
//     super.initState();
//     appBar = AppBarData.backArrow(context,
//         onBack: () => onBack(),
//         title: Consumer<TitleNotifier>(
//           builder: (context, value, _) {
//             return Text(
//               "${value.value}",
//               style: style,
//             );
//           },
//         ),
//         actions: [actionAppbar(context)]);
//   }

//   onBack() async {
//     if (await provider.checkWebHistory()) {
//       provider.backInWebView();
//     } else {
//       Navigator.pop(context);
//     }
//   }

//   disableBackAndroid() async {
//     if (await provider.checkWebHistory()) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   Container actionAppbar(context) {
//     return Container(
//       height: 34,
//       width: 84,
//       margin: EdgeInsets.only(top: 12, bottom: 10.79, right: 16),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(17.09),
//           border: Border.all(width: 1, color: Colors.white)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Consumer<LoadTooltipsNotifier>(builder: (context, show, _) {
//             return Stack(
//               children: [
//                 Center(
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: provider.onShowToolTips,
//                       child: Container(
//                         height: 20,
//                         width: 20,
//                         child: Image(
//                           image: AssetImage(
//                               "lib/special/base_citenco/asset/image/3_dot.png"),
//                           width: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: -20,
//                   bottom: 0,
//                   child: SimpleTooltip(
//                     show: show.value!,
//                     tooltipDirection: TooltipDirection.down,
//                     ballonPadding:
//                         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                     borderColor: Colors.transparent,
//                     arrowTipDistance: 0,
//                     arrowLength: 10,
//                     targetCenter: Offset(100, 100),
//                     minimumOutSidePadding: 0,
//                     child: Container(),
//                     minWidth: 130,
//                     tooltipTap: provider.onTapToolTips,
//                     content: Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         child: Text("Reload",
//                             style: BasePKG().text!.normalNormal()),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 11),
//             child: Container(height: 24, width: 1, color: Colors.white),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               child: Image(
//                 image: AssetImage(
//                   "lib/special/base_citenco/asset/image/close_icon.png",
//                 ),
//                 width: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   initProvider() {
//     return FeedBackWebProivder(this);
//   }

//   @override
//   Widget body() {
//     return WillPopScope(
//       onWillPop: () => disableBackAndroid(),
//       child: Stack(
//         children: [
//           InAppWebView(
//             initialUrlRequest: URLRequest(
//                 url: Uri.parse(provider.url), headers: provider.header),
//             onLoadStart: provider.onPageStarted,
//             onLoadStop: provider.onPageFinished,
//             onTitleChanged: provider.onChangeTitle,
//             onWebViewCreated: provider.onWebViewCreated,
//           ),
//         ],
//       ),
//     );
//   }

//   // @override
//   // Widget lazyLoad(bool visible) {
//   //   // return Container();
//   //   return FeedBackLazy(this, visible);
//   // }
// }
