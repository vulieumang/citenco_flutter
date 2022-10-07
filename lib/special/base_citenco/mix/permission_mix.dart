import 'dart:io';

import 'package:cnvsoft/special/base_citenco/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionMix {
  Future<bool> permissionCamera(State state) async {
    var permission = await Permission.camera.request();
    bool isGranted = !permission.isDenied && !permission.isPermanentlyDenied;

    if (!isGranted) {
      await ConfirmDialog.show(state,
          msg: "Vui lòng cung cấp quyền truy cập camera", onPositive: () async {
        if (Platform.isIOS) {
          openAppSettings();
        }
      });
    }

    return isGranted;
  }

  Future<bool> permissionGallery(State state) async {
    var permissionPhotos = await Permission.photos.request();
    var permissionPhotosAdded = await Permission.photosAddOnly.request();
    bool isGranted =
        (!permissionPhotos.isDenied && !permissionPhotos.isPermanentlyDenied) ||
            (!permissionPhotosAdded.isDenied &&
                !permissionPhotosAdded.isPermanentlyDenied);

    if (!isGranted) {
      await ConfirmDialog.show(state,
          msg: "Vui lòng cung cấp quyền truy cập hình ảnh",
          onPositive: () async {
        if (Platform.isIOS) {
          openAppSettings();
        }
      });
    }

    return isGranted;
  }
}
