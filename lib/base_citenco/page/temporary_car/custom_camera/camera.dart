import 'package:camera/camera.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/camera_provider.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';

enum CameraScreenType { TakeImage, Capturebill, EditImage, Video }

class CameraScreen extends StatefulWidget {
  final bool? accessGallery;
  final CameraScreenType? type;
  final String? titleAppbar;
  final String? switchCameraImg;
  final String? cameraAlt;

  CameraScreen(
      {Key? key,
      this.type,
      this.titleAppbar,
      this.switchCameraImg,
      this.cameraAlt,
      this.accessGallery})
      : super(key: key);

  factory CameraScreen.takeimage({String? titleAppbar, bool? accessGallery}) =>
      CameraScreen(
          type: CameraScreenType.TakeImage,
          titleAppbar: titleAppbar,
          accessGallery: accessGallery);

  factory CameraScreen.capturebill() =>
      CameraScreen(type: CameraScreenType.Capturebill);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends BasePage<CameraScreen, CameraProvider>
    with DataMix {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData.backArrow(
      context,
      text: stringOf(() => widget.titleAppbar!, "Camera"),
      onBack: () => Navigator.of(context).pop(true),
      radius: 0,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
              "lib/base_citenco/asset/image/switch_camera.svg",
              height: 20,
              width: 20,
              color: BasePKG().color.appBarTitle),
          onPressed: () {
            provider.onCameraSwitch();
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    provider.controller?.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Consumer<CheckHaveCameraNotifier>(builder: (context, value, child) {
      if (provider.controller != null &&
          boolOf(() => provider.controller?.value.isInitialized)) {
        if (!value.value!) {
          return Container();
        }
      } else {
        return const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Stack(
        key: ValueKey(value.value),
        children: <Widget>[
          Container(width: size.width, child: _buildCameraPreview()),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomNavigationBar(),
            ),
          )
        ],
      );
    });
  }

  Widget _buildCameraPreview() {
    // final size = MediaQuery.of(context).size;
    return boolOf(() => provider.controller?.value.isInitialized)
        ? CameraPreview(provider.controller!)
        : Container();
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: boolOf(() => widget.accessGallery!)
                ? GestureDetector(
                    onTap: provider.accessGallery,
                    child: Container(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset(
                          "lib/base_citenco/asset/image/gallery.svg",
                          color: Colors.white,
                        )),
                  )
                : Container(),
          ),
          Expanded(
              child: Consumer<CheckClickNotifier>(builder: (context, click, _) {
            return GestureDetector(
              onTap: click.value! ? null : provider.captureImage,
              child: Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                    "lib/base_citenco/asset/image/camera_alt.svg"),
              ),
            );
          })),
          Expanded(child: Container())
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void logError(String code, String? message) =>
      print('Error: $code\nError Message: $message');

  @override
  bool get wantKeepAlive => true;

  @override
  CameraProvider initProvider() => CameraProvider(this);

  void resetState() {
    if (mounted) {
      setState(() {});
    }
  }
}
