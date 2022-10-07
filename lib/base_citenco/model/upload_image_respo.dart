 import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:flutter/material.dart';

class ImageUploadRespo extends BaseModel {
  List<String>? data;

  ImageUploadRespo({this.data});

  ImageUploadRespo.fromJson(Map<String, dynamic> json) {
    this.data = List<String>.from(json["data"]);
  }
}

class ImageUploaded extends ChangeNotifier {
  //total size
  int? _total;

  //posted size
  int? _current = 0;

  //local path of file image or url posted
  String? _path;

  //temple url of posted image
  String? _url;

  double get percent => total != 0 ? (current / total) : 0;

  set total(int? total) {
    this._total = total;
    notifyListeners();
  }

  int get total => this._total ?? 0;

  set current(int? current) {
    this._current = current;
    notifyListeners();
  }

  int get current => this._current ?? 0;

  set path(String? path) {
    this._path = path;
    notifyListeners();
  }

  String? get path => this._path;

  set url(String? url) {
    this._url = url;
    notifyListeners();
  }

  String? get url => this._url;
}
