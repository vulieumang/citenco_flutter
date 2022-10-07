import 'package:cnvsoft/base_citenco/mix/permission_mix.dart';
import 'package:cnvsoft/base_citenco/mix/take_picture_mix.dart';
import 'package:cnvsoft/base_citenco/model/image.dart';
import 'package:cnvsoft/base_citenco/model/upload_image_respo.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/review_image/review_image.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';  
import 'package:cnvsoft/base_citenco/package/level_asset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

import 'temporary_car_page.dart';

class TemporaryCarProvider extends BaseProvider<TemporaryCarPageState> with TakePictureMix,PermissionMix  {
  TemporaryCarProvider(TemporaryCarPageState state) : super(state); 
  final TextEditingController noteCtrl = TextEditingController(); 
  final ImagesReviewNotifier _imageReview = ImagesReviewNotifier(); 
  List<String> _criteria = []; 

  void addListCriteria(String value) {
    if (_criteria.contains(value)) {
      _criteria.remove(value);
    } else {
      _criteria.add(value);
    }
  }

  onImagePressed(images,context) async {
    dynamic image = [];
    for (var item in images) {
      image.add(ImageNET()..id = images.indexOf(item)..url= item.path ..isDefault = false);
    }
    await Navigator
        .push(context, MaterialPageRoute(builder: (context) => ReviewImage(images: image ,)),);
  }
 

  @override
  void onReady(callback) {
    super.onReady(callback); 
  }

  @override
  List<BaseNotifier> initNotifiers() => [  
        _imageReview,
      ];  

  void onSelectImage() async {
    bool hasPermission =
        await permissionCamera(state) && await permissionGallery(state);

    if (!hasPermission) return;

    if (BasePKG().listOf(() => _imageReview.value).length >= 5) return;

    var _result = await Navigator.of(context!).pushNamed(
        "camera_screen_takeimage",
        arguments: {"access_gallery": true});
    if (_result != null && _result is String) {
      loading(() async {
        var _imageRotate = await rotateImage(_result);
        addImage(_imageRotate);
      });
    }
  }

  void addImage(String imagePath) async {
    if (BasePKG().listOf(() => _imageReview.value).length < 5) {
      List<ImageUploaded> _temp = BasePKG().listOf(() => _imageReview.value);
      String _attach = Utils.fileImgToBase64(imagePath);

      ImageUploaded _imageNoti = ImageUploaded();
      _imageNoti.path = imagePath;
      _temp.add(_imageNoti);

      _imageReview.value = List.from(_temp); 
    }
  }

  void removeImage(int index) {
    List<ImageUploaded> _temp = BasePKG().listOf(() => _imageReview.value);
    if (index < _temp.length) {
      _temp.removeAt(index);
      _imageReview.value = List.from(_temp);
    }
  }

  @override
  void dispose() { 
    super.dispose();
  }
} 

class ImagesReviewNotifier extends BaseNotifier<List<ImageUploaded>> {
  ImagesReviewNotifier() : super([]);

  bool get uploadComplete => BasePKG()
      .listOf(() => List.from(value
              ?.where(
                  (element) => BasePKG().stringOf(() => element.url).isEmpty)
              .toList() ??
          []))
      .isEmpty;

  @override
  ListenableProvider<Listenable?> provider() =>
      ChangeNotifierProvider<ImagesReviewNotifier>(create: (_) => this);
} 

class RatingTextNotifier extends BaseNotifier<String> {
  RatingTextNotifier() : super("");

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<RatingTextNotifier>(create: (_) => this);
  }
} 

class ContentImprovedListNotifier extends BaseNotifier<List<String>> {
  ContentImprovedListNotifier() : super([]);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<ContentImprovedListNotifier>(
        create: (_) => this);
  }
} 
 