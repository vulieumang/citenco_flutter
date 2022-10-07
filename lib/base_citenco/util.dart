import 'dart:convert';
import 'dart:io';
import 'dart:math'; 
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

import 'package/package.dart';

class Utils with DataMix {
  static const String SERVER_DATETIME_PATTERN = "yyyy-MM-ddTHH:mm:ssz";
  static const String SERVER_DATE_PATTERN = "yyyy-MM-dd";
  static const String DEFAULT_DATE_PATTERN = "dd/MM/yyyy";
  static const String DEFAULT_TIME_DATE_PATTERN = "hh:mm, dd/MM/yyyy";
  static const String DEFAULT_TIME_DATE_PATTERN_BLOG = "EEE, MMM dd - hh:mm";
  static DateTime initDateTime = DateTime(DateTime.now().year - 18, 1, 1);
  String billionUnit = "Tỷ";

  static DateTime? stringToDate(
      {required String source,
      String? toPattern = SERVER_DATETIME_PATTERN,
      String? locale}) {
    try {
      return DateFormat(toPattern, locale).parse(source);
    } catch (e) {
      return null;
    }
  }

  static String dateToString(
      {required DateTime? source,
      String? toPattern = DEFAULT_DATE_PATTERN,
      String? locale = "vi_VN"}) {
    try {
      return DateFormat(toPattern, locale).format(source!);
    } catch (e) {
      return '';
    }
  }
  static String ageUser(String dateCreate){
    if(dateCreate == "") return "";
    DateTime dob = DateTime.parse(dateCreate);
    Duration dur =  DateTime.now().difference(dob);
    String differenceInYears = (dur.inDays/365).toStringAsFixed(1).toString();
    return differenceInYears;
  }
  static String numberToDecimal(
      {required int source, String toPattern = "#,###"}) {
    return NumberFormat(toPattern, "vi_VN").format(source);
  }

  static String numberToCurrency(
      {required int source,
      String toPattern = "#,###",
      String? currencySymbol}) {
    return NumberFormat(toPattern, "vi_VN").format(source) +
        (currencySymbol ?? "₫");
  }

  static String numberDoubleToCurrency(
      {required double source,
      String toPattern = "#,###",
      String? currencySymbol}) {
    return NumberFormat(toPattern, "vi_VN").format(source) +
        (currencySymbol ?? "₫");
  }

  static String stringDateToStringDate({
    required String source,
    String fromPattern = SERVER_DATETIME_PATTERN,
    String toPattern = DEFAULT_DATE_PATTERN,
  }) {
    try {
      DateTime? dateTime = stringToDate(source: source, toPattern: fromPattern);
      dateTime = dateTime?.toLocal();
      return dateToString(source: dateTime!, toPattern: toPattern);
    } catch (e) {
      return '';
    }
  }
//  String priceText(ProductCart value) {
//     bool _allowsToBuy = (boolOf(() => value.value?.allowToBuy));
//     if (_allowsToBuy ) {
//       int price = value.value!.price!.toInt();
//       if (price > 999999999) {
//         return "${(price / 1000000000).toStringAsFixed(1)} $billionUnit";
//       } else {
//         return Utils.numberToCurrency(
//             source: value.value!.price!.toInt(), currencySymbol: " ₫");
//       }
//     } else {
//       return BaseTrans().$contact;
//     }
//   }
  static bool compareDate(DateTime? date1, DateTime? date2) {
    return date1 != null &&
        date2 != null &&
        date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static launchURL(String url) async {
    url = url.replaceAll(RegExp(r'\s'), '');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String upperCaseFirst(String? text, [bool silent = true]) {
    if (text == null || text.isEmpty) return "";
    return text.substring(0, 1).toUpperCase() +
        (silent ? text.substring(1).toLowerCase() : text.substring(1));
  }

  ///silent: all characters after first ís lower
  static String upperCaseFullFirst(String? text, [bool silent = true]) {
    if (text == null || text.isEmpty) return "";
    return text.split(" ").map((f) => upperCaseFirst(f, silent)).join(" ");
  }

  static Future<bool> assetExists(String asset) {
    return rootBundle.load(asset).then((_) => true).catchError((e) => false);
  }

  static Future<File> compressAndGetFile(File file) async {
    var result;
    String type = file.path.split("/").last;
    String targetPath = file.path.replaceAll(type, "") + "1" + type;
    try {
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 88,
        rotate: 0,
      );
    } catch (e) {
      print(e);
    }

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }  

  static bool validatePhone(String phone) {
    if (phone.isEmpty) return false;
    var _phoneRegex = RegExp(r"(09|03|07|08|05)+([0-9]{8})\b");
    return _phoneRegex.hasMatch(phone);
  }

  static Future<bool> validatePhoneCode(
      String phone, String code, String name, String dialCode) async {
    PhoneNumberUtil plugin = PhoneNumberUtil();
    RegionInfo region = RegionInfo(
        code: code,
        prefix: int.parse(dialCode.replaceAll("+", "")),
        name: name);
    return await plugin.validate(phone, region.code);
  }

  static bool validateEmail(String email) {
    if (email.isEmpty) return false;
    var _emailRegex = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return _emailRegex.hasMatch(email);
  }

  static String numericFormat(num number) {
    if (number > 999999999) {
      return _roundedPriceFormat(number as int, 1000000000, "B");
    } else if (number > 999999) {
      return _roundedPriceFormat(number as int, 1000000, "M");
    } else if (number > 999) {
      return _roundedPriceFormat(number as int, 1000, "K");
    } else {
      return number.toString();
    }
  }

  static String _roundedPriceFormat(
      int currentPoint, int divisionPoint, String formatUnit) {
    double value = currentPoint / divisionPoint;
    String priceString = value.toStringAsFixed(1);
    var priceStringSplit = priceString.split(".");
    if (priceStringSplit[1] == "0") {
      return "${priceStringSplit[0]} $formatUnit";
    }

    return "$priceString $formatUnit";
  }

  formatTimeAssigned(DateTime date){
    // if(DateTime.now().isBefore( DateTime(date.year,date.month,date.day) )){
      String time =  "${DateFormat('HH').format(date)}:${DateFormat('mm').format(date)}";
      if(date.hour == 0 && date.minute == 0 )
      time = "Càng sớm càng tốt";

      return "${time} - ${DateFormat('dd').format(date)}/${DateFormat('MM').format(date)}/${DateFormat('yyyy').format(date)}";
    // }else{
    //   return "${DateFormat('HH').format(date)}:${DateFormat('mm').format(date)}, Hôm nay";
    // }
  }
  
  String getPriceByVietNamFormat(String price) {
    if (price.length < 4) return price;
    price = price.replaceAll(".", "");
    price = price.substring(0, price.length - 3);
    List<String> type = ["k", "m", "b"];
    for (int indexType = 1; indexType < type.length; indexType++) {
      if (price.length > 4) {
        price = price.substring(0, price.length - 3);
        if (indexType == type.length - 1) {
          price += type[indexType];
        }
      } else if (price.length == 4) {
        String cost = (double.parse(price) / 1000).toString().substring(1);
        price = price.substring(0, 1);
        if (cost != ".0") {
          price += cost;
        }
        price += type[indexType];
        break;
      } else {
        price += type[indexType - 1];
        break;
      }
    }
    return price;
  }

  static Color hexToColor(String code, {Color? defaultCOlor}) {
    Color _color = defaultCOlor ?? BasePKG().color.primaryColor;

    try {
      _color = Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      print("Convert color fail with reason: " + e.toString());
    }
    return _color;
  }

  static bool isHexColor(String code) {
    if (code.isEmpty) return false;
    var _hexColorRegex = RegExp(r"^#+([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$");
    return _hexColorRegex.hasMatch(code);
  }

  static String cleanHtml(String html) {
    var document = parse(BasePKG().stringOf(() => html));
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  static String nameWithoutExtension(String pathOrUrl, {String? separator}) {
    File file = File(pathOrUrl);
    String dir = path.dirname(file.path);
    String name = path.basenameWithoutExtension(file.path);
    String _separator = separator ?? "/";
    return dir + _separator + name;
  }

  static String getExtension(String pathOrUrl) {
    File file = File(pathOrUrl);
    String ext = path.extension(file.path);
    return ext;
  }

  static String lastName(String? name) {
    if (name == null) return "";
    name = name.trim();
    List<String> splits = name.split(' ');
    if (splits.length > 0) {
      String _lastName = splits[0];
      return _lastName;
    }
    return "";
  }

  static String firstName(String? name) {
    if (name == null || name.isEmpty) return "";
    name = name.trim();
    List<String?>? splits = name.split(' ');
    splits.removeAt(0);
    if (splits.length > 0) {
      String _firstName = splits.join(' ');
      return _firstName;
    }
    return "";
  }

  static String fileImgToBase64(String path) {
    try {
      File file = File(path);
      List<int> bytes = file.readAsBytesSync();
      String base64 = base64Encode(bytes);
      return base64;
    } catch (e) {
      return "";
    }
  }

  static String fileName(String path) {
    try {
      File file = File(path);
      String fileName = file.path.split("/").last;
      return fileName;
    } catch (e) {
      return "";
    }
  }
}

class BorderClipper extends CustomClipper<Path> {
  final double radius;
  bool? topLeft;
  bool? topRight;
  bool? bottomLeft;
  bool? bottomRight;
  bool? all;

  BorderClipper(this.radius,
      {bool? topLeft, bool? topRight, bool? bottomLeft, bool? bottomRight}) {
    this.all = all ??
        (topLeft == null &&
            topRight == null &&
            bottomLeft == null &&
            bottomRight == null);
    this.topLeft = topLeft ?? false;
    this.topRight = topRight ?? false;
    this.bottomLeft = bottomLeft ?? false;
    this.bottomRight = bottomRight ?? false;
  }

  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.moveTo((topLeft! || all! ? radius : 0), 0);
    _path.lineTo(size.width - (topRight! || all! ? radius : 0), 0);
    _path.lineTo(size.width, (topRight! || all! ? radius : 0));
    _path.lineTo(size.width, size.height - (bottomRight! || all! ? radius : 0));
    _path.lineTo(size.width - (bottomRight! || all! ? radius : 0), size.height);
    _path.lineTo((bottomLeft! || all! ? radius : 0), size.height);
    _path.lineTo(0, size.height - (bottomLeft! || all! ? radius : 0));
    _path.lineTo(0, (topLeft! || all! ? radius : 0));

    if (topLeft! || all!)
      _path.addOval(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius));
    if (topRight! || all!)
      _path.addOval(Rect.fromCircle(
          center: Offset(size.width - radius, radius), radius: radius));
    if (bottomRight! || all!)
      _path.addOval(Rect.fromCircle(
          center: Offset(size.width - radius, size.height - radius),
          radius: radius));
    if (bottomLeft! || all!)
      _path.addOval(Rect.fromCircle(
          center: Offset(radius, size.height - radius), radius: radius));
    return _path;
  }

  @override
  bool shouldReclip(BorderClipper oldClipper) {
    return true;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class DotBorderPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DotBorderPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: Point(0, 0),
      b: Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: Point(x, 0),
      b: Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: Point(0, y),
      b: Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: Point(0, 0),
      b: Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required Point<double> a,
    required Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    Point<double> currentPoint = Point(a.x, a.y);

    num radians = atan(size.height / size.width);

    num dx =
        cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;

    num dy =
        sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
