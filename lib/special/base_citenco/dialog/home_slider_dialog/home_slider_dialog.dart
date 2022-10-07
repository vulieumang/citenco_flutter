import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../util.dart';
import 'home_slider_dialog_provider.dart';

class HomeSliderDialog extends StatefulWidget {
  final List<SliderDialogModel>? items;

  const HomeSliderDialog({Key? key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeSliderDialogState();
  }

  static Future show(BuildContext conext,
      {List<SliderDialogModel>? item}) async {
    return await showDialog(
        barrierDismissible: false,
        context: conext,
        builder: (ctx) => HomeSliderDialog(items: item));
  }
}

class HomeSliderDialogState
    extends BaseView<HomeSliderDialog, HomeSliderDialogProvider> {
  @override
  Widget body() {
    return Consumer<SliderNotifier>(builder: (ctx, liderList, _) {
      return buildHomeSlideHomeGrid(liderList.value!);
    });
  }

  @override
  HomeSliderDialogProvider initProvider() {
    return HomeSliderDialogProvider(this);
  }

  Widget buildHomeSlideHomeGrid(List<SliderDialogModel> itemSlider) {
    return Container(
        color: Colors.transparent,
        margin: BasePKG().symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Padding(
            padding: BasePKG().symmetric(vertical: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _buildSlidePage(itemSlider),
              SizedBox(height: 8),
              _buildSmoothIndicator(itemSlider),
              SizedBox(height: 16),
              _buildClose()
            ])));
  }

  Widget _buildSlidePage(List<SliderDialogModel>? itemSlider) {
    return Container(
        color: Colors.transparent,
        height: size.height / 1.5,
        width: size.width,
        child: ClipPath(
            clipper: BorderClipper(12),
            child: PageView.builder(
                controller: provider.slideCtrl,
                itemCount: itemSlider?.length,
                onPageChanged: provider.slideChanged,
                allowImplicitScrolling: itemSlider!.length > 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: GestureDetector(
                        child: FadeInImageView.fromSize(
                          itemSlider[index].imageUrl ?? "",
                          width: size.width,
                          height: size.height / 1.5,
                          fit: BoxFit.contain,
                        ),
                        onTap: () => provider.onItemPressed(itemSlider[index])),
                  );
                })));
  }

  Widget _buildSmoothIndicator(List<SliderDialogModel> itemSlider) {
    Color _dotColor = BasePKG().smoothIndicator ?? BasePKG().color.primaryColor;
    return Visibility(
      visible: BasePKG().intOf(() => itemSlider.length) > 1,
      child: SmoothPageIndicator(
          controller: provider.slideCtrl, // PageController
          count: itemSlider.length,
          effect: WormEffect(
              radius: 0,
              dotHeight: BasePKG().convert(1.5),
              dotWidth: BasePKG().convert(24),
              activeDotColor: _dotColor,
              dotColor: _dotColor,
              paintStyle: PaintingStyle.stroke,
              strokeWidth: 0.5) // your preferred effect
          ),
    );
  }

  Widget _buildClose() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black38,
            border: Border.all(width: 1.5, color: Colors.white),
            shape: BoxShape.circle),
        alignment: Alignment.center,
        child: InkWell(
            onTap: provider.onClose,
            child: Center(
                child: Padding(
                    padding: BasePKG().all(7),
                    child: SvgPicture.asset(
                        "lib/special/base_citenco/asset/image/close.svg",
                        width: 13,
                        color: Colors.white)))));
  }
}
