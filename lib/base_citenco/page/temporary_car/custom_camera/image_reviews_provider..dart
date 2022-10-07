import 'dart:io';

import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/camera.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/image_reviews.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/base_citenco/mix/take_picture_mix.dart'; 
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageReviewsProvider extends BaseProvider<ImageReviewsState>
    with TakePictureMix {
  ImageReviewsProvider(ImageReviewsState state) : super(state);
  final CropImageNotifier cropImageNotifier = CropImageNotifier();

  @override
  List<BaseNotifier> initNotifiers() {
    return [cropImageNotifier];
  }

  comfirmImage() async {
    if (state.widget.type == CameraScreenType.TakeImage) {
      Navigator.of(context!).pop();
      Navigator.of(context!).pop(cropImageNotifier.value!.path);
    } else if (state.widget.type == CameraScreenType.EditImage) {
      Navigator.of(context!).pop(cropImageNotifier.value!.path);
    } else {
      await MessageDialog.show(state, BaseTrans().$takePictureSus);
      Navigator.of(context!).popUntil((t) => t.settings.name == "dash_board");
    }
  }

  Future<void> cropImageFunc() async {
    File? croppedFile = await super.cropImage(state.widget.imagePath!);
    if (croppedFile != null) {
      cropImageNotifier.value = croppedFile;
    }
  }
}

class CropImageNotifier extends BaseNotifier<File> {
  CropImageNotifier() : super(null);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CropImageNotifier>(create: (_) => this);
  }
}
