import 'dart:io';
import 'dart:typed_data';

import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';

mixin TakePictureMix {
  Future<File?> cropImage(
    String path,
  ) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: BaseTrans().$editPic,
          toolbarColor: BasePKG().color.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    return croppedFile;
  }

  Future<String> rotateImage(String image, {double? maxlengthInByte}) async {
    File _imageFile = File(image);
    int rotate = 0;
    List<int> imageBytes = await _imageFile.readAsBytes();

    int _quantity = 100;

    List<int> result = await compressWithList(imageBytes, _quantity, rotate);

    if (maxlengthInByte != null) {
      while ((result as Uint8List).lengthInBytes > maxlengthInByte) {
        _quantity -= 5;
        result = await compressWithList(imageBytes, _quantity, rotate);
      }
    }

    print(
        "iamge after rotate length =================> ${(result as Uint8List).lengthInBytes}");

    await _imageFile.writeAsBytes(result);
    return _imageFile.path;
  }

  Future<List<int>> compressWithList(
      List<int> imageBytes, int _quantity, int rotate) async {
    return await FlutterImageCompress.compressWithList(imageBytes as Uint8List,
        quality: _quantity, rotate: rotate);
  }
}
