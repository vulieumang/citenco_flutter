import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/camera.dart';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CameraProvider extends BaseProvider<CameraScreenState> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isRecordingMode = false;
  bool isRecording = false;

  CameraProvider(CameraScreenState state) : super(state);

  final CheckHaveCameraNotifier _checkHaveCameraNotifier =
      CheckHaveCameraNotifier();
  final CheckClickNotifier _checkClickNotifier = CheckClickNotifier();
  @override
  void onReady(callback) {
    super.onReady(callback);
    _initCamera();
  }

  @override
  List<BaseNotifier> initNotifiers() =>
      [_checkHaveCameraNotifier, _checkClickNotifier];

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.ultraHigh,
        enableAudio: BasePKG()
            .boolOf(() => state.widget.type == CameraScreenType.Video));
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _checkHaveCameraNotifier.value = controller!.value.isInitialized;
    });
  }

  captureImage() async {
    if (controller!.value.isInitialized) {
      SystemSound.play(SystemSoundType.click);
      _checkClickNotifier.value = true;
      XFile imageFile = await controller!.takePicture();
      Navigator.of(context!).pushNamed("gallery_capture", arguments: {
        "imagePath": imageFile.path,
        "type": state.widget.type
      }).then((value) => _checkClickNotifier.value = false);
    }
  }

  accessGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      var result = await Navigator.of(context!).pushNamed("gallery_capture",
          arguments: {"imagePath": image.path, "type": state.widget.type});
      // if (result != null) {
      //   var _imageRotate = await rotateImage(result);
      //   _avatarNotifier.value = FileImage(File(_imageRotate));
      //   _fileAvatar = File(_imageRotate);
      // }
    }
  }

  Future<void> onCameraSwitch() async {
    final CameraDescription cameraDescription =
        (controller?.description == cameras![0]) ? cameras![1] : cameras![0];
    // if (controller != null) {
    //   await controller?.dispose();
    //   _checkHaveCameraNotifier.value = false;
    // }

    controller =
        CameraController(cameraDescription, ResolutionPreset.ultraHigh);
    controller?.addListener(() {
      if (mounted) state.resetState();
      if (controller!.value.hasError) {
        state.showInSnackBar(
            'Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller?.initialize();
      _checkHaveCameraNotifier.value = true;
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _showCameraException(CameraException e) {
    state.logError(e.code, e.description);
    state.showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

class CheckClickNotifier extends BaseNotifier<bool> {
  CheckClickNotifier() : super(false);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CheckClickNotifier>(create: (_) => this);
  }
}

class CheckHaveCameraNotifier extends BaseNotifier<bool> {
  CheckHaveCameraNotifier() : super(false);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<CheckHaveCameraNotifier>(create: (_) => this);
  }
}
