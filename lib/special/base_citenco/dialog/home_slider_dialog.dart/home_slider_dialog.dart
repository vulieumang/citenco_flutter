// import 'package:cnvsoft/core/base_core/base_view.dart';
// import 'package:cnvsoft/special/base_citenco/dialog/home_slider_dialog/home_slider_dialog_provider.dart'
//     as dialogTrans;
// import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../package/package.dart';
// import '../../util.dart';
// import 'home_slider_dialog_provider.dart';

// class HomeSliderDialog extends StatefulWidget {
//   final dialogTrans.SliderDialogModel item;

//   const HomeSliderDialog({Key key, this.item}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return HomeSliderDialogState();
//   }

//   static Future show(BuildContext conext,
//       {dialogTrans.SliderDialogModel item}) async {
//     return await showDialog(
//         barrierDismissible: false,
//         context: conext,
//         builder: (ctx) => HomeSliderDialog(item: item));
//   }
// }

// class HomeSliderDialogState
//     extends BaseView<HomeSliderDialog, HomeSliderDialogProvider> {
//   @override
//   Widget body() {
//     return Consumer<SliderNotifier>(builder: (ctx, liderList, _) {
//       return buildHomeSlideHomeGrid(liderList.value);
//     });
//   }

//   @override
//   HomeSliderDialogProvider initProvider() {
//     return HomeSliderDialogProvider(this);
//   }

//   Widget _buildSlidePage(List<dialogTrans.SliderDialogModel> itemSlider) {
//     return Container(
//         color: Colors.transparent,
//         height: 210,
//         margin: BasePKG().only(left: 14, right: 14),
//         child: ClipPath(
//             clipper: BorderClipper(12),
//             child: PageView.builder(
//                 controller: provider.slideCtrl,
//                 itemCount: itemSlider.length,
//                 onPageChanged: provider.slideChanged,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     color: BasePKG().color.card,
//                     child: GestureDetector(
//                         child: FadeInImageView.medium(
//                             itemSlider[index].imageUrl,
//                             fit: BoxFit.contain),
//                         onTap: () => provider.onItemPressed(itemSlider[index])),
//                   );
//                 })));
//   }

//   Widget _buildSmoothIndicator(List<dialogTrans.SliderDialogModel> itemSlider) {
//     Color _dotColor = BasePKG().smoothIndicator ?? BasePKG().color.primaryColor;
//     return Visibility(
//       visible: BasePKG().intOf(() => itemSlider.length) > 1,
//       child: SmoothPageIndicator(
//           controller: provider.slideCtrl, // PageController
//           count: itemSlider.length,
//           effect: WormEffect(
//               radius: 0,
//               dotHeight: BasePKG().convert(1.5),
//               dotWidth: BasePKG().convert(24),
//               activeDotColor: _dotColor,
//               dotColor: _dotColor,
//               paintStyle: PaintingStyle.stroke,
//               strokeWidth: 0.5) // your preferred effect
//           ),
//     );
//   }

//   Widget buildHomeSlideHomeGrid(
//       List<dialogTrans.SliderDialogModel> itemSlider) {
//     return Dialog(
//         backgroundColor: Colors.transparent,
//         child: Stack(alignment: Alignment.topRight, children: [
//           InkWell(
//               onTap: () => Navigator.of(context).pop(),
//               child: Padding(
//                   padding: BasePKG().all(7),
//                   child: SvgPicture.asset(
//                       "lib/special/base_citenco/asset/image/close.svg",
//                       width: 15))),
//           Padding(
//               padding: BasePKG().symmetric(vertical: 30),
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 _buildSlidePage(itemSlider),
//                 SizedBox(height: 8),
//                 _buildSmoothIndicator(itemSlider)
//               ]))
//         ]));
//   }
// }
