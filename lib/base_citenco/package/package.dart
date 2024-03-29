import 'dart:async';
import 'package:cnvsoft/base_citenco/model/login_model.dart';
import 'package:cnvsoft/base_citenco/model/scand_model.dart';
import 'package:cnvsoft/base_citenco/page/login/login_page.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/info_scan/info_car_page.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/qr_flutter/qr_flutter_page.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/camera.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/custom_camera/image_reviews.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/temporary_car_page.dart';
import 'package:cnvsoft/base_citenco/page/temporary_car/verify_register_car/verify_register_page.dart';
import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/bus.dart';
import 'package:cnvsoft/core/http.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/base_citenco/extend/dashboard_extend/bottom_menu_icon.dart';
import 'package:cnvsoft/base_citenco/page/home/home_icon.dart';
import 'package:cnvsoft/base_citenco/page/error/error_list/error_list_page.dart';
import 'package:cnvsoft/base_citenco/page/error/error_page.dart';
import 'package:cnvsoft/base_citenco/page/landing/landing_page.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';
import '../page/scan_car/verify_car/verify_page.dart';
import 'button_style.dart';
import 'color_style.dart';
import 'decoration_style.dart';
import 'level_asset.dart';
import 'text_style.dart';

enum BlogType { Normal, HomeSlider }

enum RatingType {
  Order, // without rating product
  Product, // will be include rating order, customer would be pay to use this function
}

class QRScanData extends BusData {
  QRScanData(String method, {dynamic data}) : super(method, data: data);
}

class DashboardData extends BusData {
  DashboardData(String method, {dynamic data}) : super(method, data: data);
}

class DashboardChangeHome extends BusData {
  DashboardChangeHome(String method, {dynamic data})
      : super(method, data: data);
}

class HomeExtendData extends BusData {
  HomeExtendData(String method, {dynamic data}) : super(method, data: data);
}

class BasePKG extends BasePackage {
  String helpTitle = "";
  ENV? env;

  //enum này dùng dể gửi lên header api
  //phân biệt app retail hay ecom
  static const RETAIL_APP = 3;
  static const ECOM_APP = 2;

  // String supportCenterTitle = "Trung tâm hỗ trợ";
  // String haveSpaPackageUnused = "";
  // retail = 3, ecom = 2
  var clientAppHeader = RETAIL_APP;

  MemberCardStyle memberCardStyle = MemberCardStyle.OrderStatus;

  BoxFit landingBoxFit = BoxFit.fill;

  static BasePKG? _internal;
  static Map<State, BaseContext> _context = Map();

  BasePKG._();

  factory BasePKG() {
    if (_internal == null) {
      _internal = BasePKG._()
        ..bus = Bus([
          QRScanData,
          DashboardData,
          HomeExtendData,
          DashboardChangeHome,
        ]);
      _internal!.initStyle();
    }
    return _internal!;
  }

  static BaseContext of(State state) {
    if (_context[state] == null) {
      _context[state] = BaseContext.of(state);
    }
    return _context[state]!;
  }

  @override
  Map<String, Function(dynamic arg)> getPages() {
    return {
      "landing": (arg) => LandingPage(),
      "error": (arg) => ErrorPage(error: arg["error"]),
      "error_list": (arg) => ErrorListPage(),
      "scan_car": (arg) => QrFlutterPage(),
      "temporary_car": (arg) => TemporaryCarPage(),
      "login_page": (arg) => LoginPage(),
      "verify_car_page": (arg) => VerifyCarPage(
            isOut: arg == null ? false : arg['isOut'],
          ),
      "verify_car_register_page": (arg) => VerifyCarRegisterPage(),
      "info_car_page": (arg) => InfoCarPage(
            data: arg["data"],
          ),
      "camera_screen_takeimage": (arg) => CameraScreen.takeimage(
            titleAppbar: dataOf(() => arg["title_appbar"], null),
            accessGallery: boolOf(() => arg["access_gallery"]),
          ),
      "gallery_capture": (arg) => ImageReviews(
          imagePath: arg['imagePath'], type: arg['type'], color: arg["color"]),
    };
  }

  @override
  BaseColor get color => BaseColor();
}

class BaseContext extends Context with DataMix {
  static const String TOKEN_ADMIN_URL = "v1/auth/token";
  static const String LOGIN = "api/v1/users/token";
  static const String HISTORIS = "api/v1/histories";
  static const String SCAN = "api/v1/vehicles/";
  static const String SCAN_VERIFY = "api/v1/histories";
  static const String outStationDateTime =
      "api/v1/histories/outStationDateTime";

  Timer? debounceMap;

  BaseContext();

  factory BaseContext.of(State state) {
    return BaseContext()
      ..http = Http(state: state, factories: {
        BaseDataModel: (data) => BaseDataModel(data),
        Lgoin: (data) => Lgoin(data: LgoinData.fromJson(data)),
        DataScan: (data) => DataScan(data: DataScanData.fromJson(data)),
      });
  }

  loginApi(phone, pass) {
    return http!.post<Lgoin>(LOGIN, baseAPI: baseAPI, body: {
      "userName": phone,
      "password": pass,
    });
  }

  history(
      {vehicleDriverName,
      vehicleType,
      vehicleLoad,
      images,
      vehicleLicensePlate}) {
    return http!.post<BaseDataModel>(HISTORIS, baseAPI: baseAPI, body: {
      "vehicleInStationAt": DateTime.now().toUtc().toString(),
      "vehicleDriverName": vehicleDriverName,
      "vehicleType": vehicleType,
      "vehicleLicensePlate": vehicleLicensePlate,
      "vehicleLoad": vehicleLoad,
      "images": images
    });
  }

  scan({id}) {
    return http!.get<DataScan>(
      SCAN + id + "/scanInformation",
      baseAPI: baseAPI,
    );
  }

  scanVerify({int? id, String? name}) {
    return http!.post<BaseDataModel>(
      SCAN_VERIFY,
      baseAPI: baseAPI,
      body: {
        "vehicleId": id,
        "vehicleInStationAt": DateTime.now().toUtc().toString(),
        "vehicleDriverName": stringOf(() => name  ),
        "note": "",
        "images": []
      },
    );
  }

  putOut({
    String? historyId,
  }) {
    return http!.put<BaseDataModel>(
      outStationDateTime,
      baseAPI: baseAPI,
      body: {
        "historyId": historyId,
        "vehicleOutStationAt": DateTime.now().toUtc().toString(),
      },
    );
  }
}

class BaseColor extends ModifyColor {
  Color levelProfile = Color(0xff2E2E2E);
  Color orderCount = Color(0xffD3495B);
}

abstract class BasePackage extends Package {
  ColorStyle? color;

  BaseButton? button;

  BaseDecoration? decoration;

  BaseText? text;

  void initStyle() {
    color = ColorStyle();
    button = BaseButton();
    text = BaseText();
    decoration = BaseDecoration();
  }
}

class ParamsRequired {
  bool? email;
  bool? phone;
  bool? dob;

  ParamsRequired() {
    this.email = false;
    this.phone = false;
    this.dob = false;
  }

  void setEmail(bool email) => this.email = email;

  void setPhone(bool phone) => this.phone = phone;

  void setDob(bool dob) => this.dob = dob;

  bool get hasInfoRequired => email! || phone! || dob!;
}
