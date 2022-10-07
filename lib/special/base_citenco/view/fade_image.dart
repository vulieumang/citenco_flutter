import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:cnvsoft/special/base_citenco/util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

// import 'extended_image.dart';
// import 'extended_image_utils.dart';
// import 'extended_raw_image.dart';

enum _FadeInImageSize { small, medium, large }

class FadeInImageView extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final String? errorImage;
  final _FadeInImageSize? size;
  final double? width, height;
  final BorderRadius? borderRadius;
  final Color? color;
  final bool? httpsRequiered;
  final double? compressionRatio;
  final bool? cache;
  final String? cacheKey;
  final double? forceQuantity;

  late final PatternCDN patternCDN = PatternCDN(imageUrl);

  int retryTime = 0;

  FadeInImageView(
      {Key? key,
      required this.imageUrl,
      this.fit = BoxFit.cover,
      this.errorImage,
      this.size,
      this.width,
      this.height,
      this.borderRadius: BorderRadius.zero,
      this.color,
      this.httpsRequiered = false,
      this.compressionRatio,
      this.cacheKey,
      this.forceQuantity,
      this.cache = true})
      : super(key: key);

  factory FadeInImageView.small(String imageUrl,
      {double? width, double? height, BoxFit? fit, double? compressionRatio}) {
    return FadeInImageView(
        imageUrl: imageUrl,
        fit: fit,
        size: _FadeInImageSize.small,
        width: width,
        height: height,
        compressionRatio: compressionRatio);
  }

  factory FadeInImageView.medium(String imageUrl,
      {double? width, double? height, BoxFit? fit, double? compressionRatio}) {
    return FadeInImageView(
        imageUrl: imageUrl,
        fit: fit,
        size: _FadeInImageSize.medium,
        width: width,
        height: height,
        compressionRatio: compressionRatio);
  }

  factory FadeInImageView.large(String imageUrl,
      {double? width, double? height, BoxFit? fit, double? compressionRatio}) {
    return FadeInImageView(
        imageUrl: imageUrl,
        fit: fit,
        size: _FadeInImageSize.large,
        width: width,
        height: height,
        compressionRatio: compressionRatio);
  }

  factory FadeInImageView.fromSize(String imageUrl,
      {required double width,
      required double height,
      BoxFit? fit,
      Color? color,
      String? errorImage,
      BorderRadius? borderRadius,
      bool? httpsRequiered = false,
      double? compressionRatio,
      double? forceQuantity,
      String? cacheKey,
      bool cache = true}) {
    return FadeInImageView(
      cache: cache,
      imageUrl: imageUrl,
      fit: fit,
      size: null,
      width: width,
      height: height,
      color: color,
      errorImage: errorImage,
      borderRadius: borderRadius ?? BorderRadius.zero,
      httpsRequiered: httpsRequiered,
      compressionRatio: compressionRatio,
      cacheKey: cacheKey,
      forceQuantity: forceQuantity,
    );
  }

  // Widget _image;

  Map<_FadeInImageSize, dynamic> get _map => {
        _FadeInImageSize.small: {
          "size_loading": 25.0,
          'width': 100.0,
          'height': 100.0,
        },
        _FadeInImageSize.medium: {
          "size_loading": 50.0,
          'width': 200.0,
          'height': 200.0,
        },
        _FadeInImageSize.large: {
          "size_loading": 75.0,
          'width': 300.0,
          'height': 300.0,
        },
      };

  double get _height =>
      this.height ??
      (this.size == null ? (this.height ?? 200.0) : _map[this.size]['height']);

  double get _width =>
      this.width ??
      (this.size == null ? (this.width ?? 200.0) : _map[this.size]['width']);

  double get getSize {
    double? _width = this._width == double.infinity ? null : this._width;
    double? _height = this._height == double.infinity ? null : this._height;
    double size = 25;
    if (_width != null && _height != null)
      size = min(_width, _height) / 3.0;
    else if (_width != null)
      size = _width / 3.0;
    else if (_height != null) size = _height / 3.0;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    bool _isNetworkImage = !_imageUrl.startsWith("lib");

    return ClipRRect(
      borderRadius: this.borderRadius,
      child: _isNetworkImage ? _buildNetwork(context) : _buildAsset(context),
    );
  }

  _buildAsset(BuildContext context) {
    bool _isSvgImage = _imageUrl.toLowerCase().endsWith(".svg");
    return _isSvgImage
        ? SvgPicture.asset(
            _imageUrl,
            width: _width,
            height: _height,
            fit: this.fit ?? BoxFit.contain,
            alignment: Alignment.center,
            color: this.color,
            placeholderBuilder: (_) => _placeholder(_, _imageUrl),
          )
        : _initImage(context);
  }

  _buildNetwork(BuildContext context) {
    bool _isSvgImage = _imageUrl.toLowerCase().endsWith(".svg");
    return _isSvgImage
        ? SvgPicture.network(
            _imageUrl,
            width: _width,
            height: _height,
            fit: this.fit ?? BoxFit.contain,
            alignment: Alignment.center,
            color: this.color,
            placeholderBuilder: (_) => _placeholder(_, _imageUrl),
          )
        : _initImage(context);
  }

  // @override
  // Future<void> didChangeDependencies() async {
  //   if (_image != null)
  //     await precacheImage(
  //         _image is ExtendedImage
  //             ? (_image as ExtendedImage).image
  //             : (_image as Image).image,
  //         context);
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(FadeInImageView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldthis.imageUrl != this.imageUrl) {
  //     _initImage();
  //   }
  // }

  _initImage(BuildContext context) {
    bool _isSvgImage = _imageUrl.toLowerCase().endsWith(".svg");
    bool _isNetworkImage = !_imageUrl.startsWith("lib");

    if (!_isSvgImage) {
      if (_isNetworkImage) {
        double compression = this.compressionRatio ?? 1.0;
        return _initCompressImage(context, compression);
      } else {
        return Image.asset(
          _imageUrl,
          width: _width,
          height: _height,
          fit: this.fit,
          alignment: Alignment.center,
          color: this.color,
        );
      }
    }
  }

  _initCompressImage(BuildContext context, double compressionRatio) {
    //   http.Client().get(_imageUrl).then((resp){
    //     if(resp.statusCode != HttpStatus.ok)
    //     print(resp.bodyBytes);
    //   }).catchError((e){
    //     print(e);
    //   })
    // ;
    //   _image = Image.network(_imageUrl,
    //       color: this.color,
    //       alignment: Alignment.center,
    //       height: _height,
    //       width: _width,
    //       fit: this.fit ?? BoxFit.cover,
    //   );
    return ExtendedImage.network(
      _imageUrl,
      color: this.color,
      alignment: Alignment.center,
      height: _height,
      width: _width,
      fit: this.fit ?? BoxFit.cover,
      cache: false,
      cacheKey: cacheKey,
      scale: 0.7,
      handleLoadingProgress: true,
      compressionRatio: compressionRatio,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return CupertinoActivityIndicator(
              animating: true,
              radius: 16,
            );
          case LoadState.failed:
            retryTime++;
            return (_imageUrl.startsWith("https://cdn") && retryTime < 3)
                ? _initCompressImage(context, compressionRatio)
                : _errorWidget(context);
          case LoadState.completed:
            return ExtendedRawImage(
              color: this.color,
              image: state.extendedImageInfo?.image,
              alignment: Alignment.center,
              height: _height,
              width: _width,
              fit: this.fit ?? BoxFit.cover,
              scale: 0.7,
            );
        }
      },
    );
  }

  String get _errorImage =>
      this.errorImage ?? "lib/special/modify/asset/image/logo/logo_login.png";

  String get _imageUrl => (this.imageUrl.isEmpty || this.imageUrl.endsWith("/"))
      ? StorageCNV().containsKey("HOME_ACP_LOGO")
          ?  "lib/special/modify/asset/image/logo/logo_login.png"
          : _errorImage
      : patternCDN.getOptimizeUrl(forceQuantity ?? width ?? 200.0);

  Widget _errorWidget(BuildContext contex) {
    double size = getSize;
    return ClipRRect(
        borderRadius: this.borderRadius,
        child: Padding(
          padding: size < 12
              ? EdgeInsets.zero
              : (size < 28 ? EdgeInsets.all(0.0) : EdgeInsets.all(0.0)),
          child: Image.asset(_errorImage, errorBuilder: (context, _, __) {
            return Image.memory(kTransparentImage);
          }, width: _width, height: _height, fit: BaseScope().errorImageFit),
        ));
  }

  Widget _placeholder(BuildContext context, String url) {
    // return SpinKitFadingCircle(
    //     size: getSize, color: BasePKG().color.primaryColor);
    return _shimerWidget();
  }

  Widget _shimerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}

class PatternCDN with DataMix {
  late String url;

  PatternCDN(this.url);

  final String s16 = "16x16";
  final String s32 = "32x32";
  final String s50 = "50x50";
  final String s100 = "100x100";
  final String s160 = "160x160";
  final String s240 = "240x240";
  final String s480 = "480x480";
  final String s600 = "600x600";
  final String s1024 = "1024x1024";
  // final String s2048 = "2048x2048";

  late List<String> patterns = [
    s16,
    s32,
    s50,
    s100,
    s160,
    s240,
    s480,
    s600,
    s1024,
    //s2048
  ];

  late List<double> sizes = [8, 16, 25, 50, 80, 120, 240, 300, 512, 1024];

  bool get isCdn => boolOf(
      () => url.startsWith("https://cdn") || url.startsWith("http://cdn"));

  bool get isSvg => boolOf(() => url.toLowerCase().endsWith(".svg"));

  String getPattern(double width) {
    String _temp = patterns[indexSize(width)];
    return "_$_temp";
  }

  int indexSize(double width) {
    int index = sizes.length - 1;
    while (sizes[index] > width && index >= 0) {
      index--;
    }
    return index;
  }

  String getOptimizeUrl(double width) {
    if (isCdn && !isSvg) {
      String temp = url;
      String ext = Utils.getExtension(url);

      String fileName = Utils.nameWithoutExtension(url);

      temp = fileName + getPattern(width) + ext;
      // temp = fileName + ext;
      return temp;
    }
    return url;
  }
}
