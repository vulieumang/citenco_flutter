import 'dart:async';
import 'dart:ui' as ui;

import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LogoType { Login, LoginPhone }

class LogoView extends StatefulWidget {
  final LogoType? type;
  const LogoView({Key? key, this.type}) : super(key: key);

  factory LogoView.login() {
    return LogoView(type: LogoType.Login);
  }

  factory LogoView.loginPhone() {
    return LogoView(type: LogoType.LoginPhone);
  }

  @override
  State<StatefulWidget> createState() => LogoViewState();
}

class LogoViewState extends BaseView<LogoView, LogoViewProvider> {
  @override
  Widget body() {
    // double heightLogoIcon = ModifyPKG().convert(120);
    // if (widget.type == LogoType.Login)
    //   return Container(
    //     height: heightLogoIcon,
    //     child: Image.asset(
    //       "lib/special/modify/asset/image/logo/logo_login.png",
    //       height: ModifyPKG().convert(62),
    //       width: ModifyPKG().convert(248.59),
    //     ),
    //   );
    // else
    //   return Padding(
    //     padding: ModifyPKG().all(24),
    //     child: Image.asset(
    //       "lib/special/modify/asset/image/logo/logo.png",
    //       height: heightLogoIcon,
    //       width: ModifyPKG().convert(246.59),
    //     ),
    //   );

    return Container(
      child: Consumer<SizeNotifier>(
        builder: (context, logoSize, _) {
          if (logoSize.value == null || provider.asset == null)
            return SizedBox();
          else
            return 
                FadeInImageView.fromSize(
                  StorageCNV().getString("HOME_ACP_LOGO")!,
                  errorImage: "lib/special/modify/asset/image/logo/logo_login.png",
                  fit: BoxFit.contain,
                  height: 100,
                  width: 100,
                );
        },
      ),
    );
  }

  @override
  LogoViewProvider initProvider() => LogoViewProvider(this);
}

class LogoViewProvider extends BaseProvider<LogoViewState> {
  final SizeNotifier _size = SizeNotifier();
  String? asset;

  LogoViewProvider(LogoViewState state) : super(state);

  Completer<ui.Image>? completer;

  @override
  void onReady(callback) async {
    // TODO: implement onReady
    super.onReady(callback);
    if (state.widget.type == LogoType.Login)
      asset = "lib/special/modify/asset/image/logo/logo_login.png";
    else {
      if (await StorageCNV()
          .checkFileExist("lib/special/modify/asset/image/logo/logo_phone.png"))
        asset = "lib/special/modify/asset/image/logo/logo_phone.png";
      else
        asset = "lib/special/modify/asset/image/logo/logo.png";
    }

    final Size sketchSize = Size(375, 812);
    final Size squareLarge = Size(150, 150);
    final Size squareSmall = Size(100, 100);
    final Size retctLarge = Size(250, double.infinity);
    final Size retctSmall = Size(150, double.infinity);

    if (completer != null) completer = null;
    completer = Completer<ui.Image>();
    ImageStreamListener listener =
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      if (completer != null && !completer!.isCompleted) {
        completer?.complete(info.image);
      }
    });

    FadeInImage(
        placeholder: AssetImage(
            "lib/special/modify/asset/image/logo/logo.png"),
        image: NetworkImage(StorageCNV().getString("HOME_ACP_LOGO")!),
        fit: BoxFit.cover)
        .image
        .resolve(ImageConfiguration())
        .addListener(listener);
    completer?.future.then((image) {
      int width = image.width;
      int height = image.height + 2;
      double widthRatio = state.size.width / sketchSize.width;
      double heightRatio = state.size.height / sketchSize.height;
      if (state.widget.type == LogoType.Login) {
        if (width > height) {
          double _width = retctLarge.width * widthRatio;
          double _height = _width * height / width;
          _size.value = Size(_width, _height);
        } else {
          double _width = squareLarge.width * widthRatio;
          double _height = squareLarge.height * heightRatio;
          _size.value = Size(_width, _height);
        }
      } else {
        if (width > height) {
          double _width = retctSmall.width * widthRatio;
          double _height = _width * height / width;
          _size.value = Size(_width, _height);
        } else {
          double _width = squareSmall.width * widthRatio;
          double _height = squareSmall.height * heightRatio;
          _size.value = Size(_width, _height);
        }
      }
      print(_size.value);
    });
  }

  @override
  List<BaseNotifier> initNotifiers() => [_size];
}

class SizeNotifier extends BaseNotifier<Size> {
  SizeNotifier() : super(null);

  @override
  ListenableProvider<Listenable> provider() {
    // TODO: implement provider
    return ChangeNotifierProvider<SizeNotifier>(
      create: (_) => this,
    );
  }
}
