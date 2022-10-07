import 'dart:async'; 
import 'package:cnvsoft/core/base_core/base_model.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/core/bus.dart'; 
import 'package:cnvsoft/core/http.dart'; 
import 'package:cnvsoft/core/package.dart'; 
import 'package:cnvsoft/special/base_citenco/extend/dashboard_extend/bottom_menu_icon.dart'; 
import 'package:cnvsoft/special/base_citenco/modify/home/home_icon.dart';  
import 'package:cnvsoft/special/base_citenco/page/error/error_list/error_list_page.dart';
import 'package:cnvsoft/special/base_citenco/page/error/error_page.dart'; 
import 'package:cnvsoft/special/base_citenco/page/landing/landing_page.dart'; 
import 'package:cnvsoft/special/base_citenco/page/webView2/web_view_core/web_page.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart'; 
import 'package:cnvsoft/special/base_citenco/modify/package.dart'; 
import 'package:flutter/material.dart';  
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

// HIOP
// class BookingPageData extends BusData {
//   BookingPageData(String method, {data}) : super(method, data: data);
// }
//booking spa

class BookingPageData extends BusData {
  BookingPageData(String method, {data}) : super(method, data: data);
}

class BookingProductData extends BusData {
  BookingProductData(String method, {dynamic data}) : super(method, data: data);
}

class BookingProductListData extends BusData {
  BookingProductListData(String method, {dynamic data})
      : super(method, data: data);
}

class BookingEcommerceListViewData extends BusData {
  BookingEcommerceListViewData(String method, {dynamic data})
      : super(method, data: data);
}

class BookingEcommerceListData extends BusData {
  BookingEcommerceListData(String method, {dynamic data})
      : super(method, data: data);
}

class BookingEcommerceCartData extends BusData {
  BookingEcommerceCartData(String method, {dynamic data})
      : super(method, data: data);
}

class BookingEcommerceOrderData extends BusData {
  BookingEcommerceOrderData(String method, {dynamic data})
      : super(method, data: data);
}

class SliderDialogData extends BusData {
  SliderDialogData(String method, {dynamic data}) : super(method, data: data);
}

class QRScanData extends BusData {
  QRScanData(String method, {dynamic data}) : super(method, data: data);
}

class DashboardData extends BusData {
  DashboardData(String method, {dynamic data}) : super(method, data: data);
}

class DashboardChangeHome extends BusData {
  DashboardChangeHome(String method, {dynamic data}) : super(method, data: data);
}


class HomeData extends BusData {
  HomeData(String method, {dynamic data}) : super(method, data: data);
}

class HomeExtendData extends BusData {
  HomeExtendData(String method, {dynamic data}) : super(method, data: data);
}

class SectionHomeData extends BusData {
  SectionHomeData(String method, {dynamic data}) : super(method, data: data);
}

class SectionHomeViewData extends BusData {
  SectionHomeViewData(String method, {dynamic data})
      : super(method, data: data);
}

class LuckyNumberData extends BusData {
  LuckyNumberData(String method, {dynamic data}) : super(method, data: data);
}

class LuckyNumberHistoryData extends BusData {
  LuckyNumberHistoryData(String method, {dynamic data})
      : super(method, data: data);
}

class OtpVerifyData extends BusData {
  OtpVerifyData(String method, {dynamic data}) : super(method, data: data);
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
  bool isShowNameCard = false;
  bool enableSetting = false;
  bool enableBrand = false;
  bool enableHomeReview = false;
  bool isStickyHome = false;
  bool linkProductEcom = false;
  bool hasLogoVerifyName = false;
  bool upperCaseFirstHomeIconTitle = false;
  bool showHomeListNewsHome = false;
  Color? smoothIndicator;
  Color? sharedReferralColor;
  Color? sharedReferralTextColor;
  Color? fancyTabBarSelected;
  Color? headerSectionColor;
  Color? headerSectionTextColor;
  Theme? anotherTheme;
  bool showLevelCard = true;
  List<String> languages = [];
  String backArrowLink = "lib/special/base_citenco/asset/image/arrow.svg";
  bool enableTopUp = false;
  bool enableAgeUser = false;
  bool isIndividual = false;
  bool enableProfileWarranty = false;
  bool enableAnnoucement = false;
  bool enableLocation = false;
  bool enableContact = false;
  bool enableSupportCenter = true;
  bool showOtherGender = false;
  bool showYoutube = false;
  bool homeIconCircle = false;
  bool enableFacebookFanpage = false;
  bool isGoogle = false;
  bool isApple = false;
  bool enableGame = false;
  String liveStreamId = "2";
  String helpPageId = "1";
  BoxFit errorImageFit = BoxFit.contain;
  bool isGridIconMenuBorderBg = false;
  Color? colorLoginPrimary;
  Color? colorHeaderMenu;
  Color? colorBottombar;
  List<String> enableLogin = [
    "-google:ios:review",
    "-facebook:ios:review",
    "-apple:ios:review"
  ];
  List<String> enableGameProfile = [];
  Map<String, String> games = {};
  List<HomeIcon> headerIcons = [];
  List<HomeIcon> gridIcons = [];
  List<BottomMenuIcon> footerIcons = [];
  double elevationAppbar = 0;
  bool enablePayoo = false;
  bool enableMomo = false;
  bool centerGridIcons = true;

  // String homeRewardTitle = "Ưu đãi nổi bật";
  // String homeProductTitle = BaseTrans().$hotProducts; //"Sản phẩm nổi bật";
  bool enableLocalImage = false;
  String dsnErrorLog = "";
  bool showMeasurement = false;
  bool isMultiBrand = false;
  String commitMessage = "";
  String commitTitle = "";
  // bool setOrderLocation =
  //     false; // link task https://gitlab.cnv.vn/projects-operation/mobile-apps/sprint-mobile/-/issues/285
  bool enableHeaderColor = false;
  bool enableOTP = false;
  String? linkInvitation;
  bool allowNetwork = true;
  var durationNumberCircle = 60;
  bool homeDialogTrans = false;
  bool loginIcon = true;
  bool phoneBg = true;
  double borderRadiusBottomAppBar = 0.0;
  double marginSkipBtn = 0.0;
  String? sku;
  bool useNewSupportCenterPage =
      true; // enable new support center all app 08/04/2021
  bool enableGiftCard = false;
  bool logoGallery = false;
  bool isShowPriceCompare = true;
  bool skipReferral = false;
  bool newUIProfile = true;
  RatingType ratingType = RatingType.Order;
  SquareButtonStyle buttonStyle = SquareButtonStyle.Radius;
  String privacyLink = "";
  bool forceUnAuth = false;
  bool enableInputTopupValue = true;
  bool isLoginRandom = false;
  bool disableShadowHeaderMenuBottomMenu = false;

  // String purchaseHistory = "Lịch sử mua hàng";

  // bool loginScreenIsAdmin = false;
  ParamsRequired paramsRequired = ParamsRequired();
  bool isLoginPhoneByServer = false;

  bool enableRewardSupportCenter = true;

  //ecommerce
  bool ecommerceUI = false;

  //Reward
  bool redeemWithCode = true;

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
          HomeData,
          HomeExtendData,
          SliderDialogData,
          SectionHomeData,
          BookingProductListData,
          BookingProductData,
          BookingPageData,
          BookingEcommerceListViewData,
          LuckyNumberData,
          LuckyNumberHistoryData,
          SectionHomeViewData,
          DashboardChangeHome,
          OtpVerifyData
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
      "web2": (arg) => FeedBackWebPage(urlView: dataOf(() => arg["url"])),  
    };
  }

  @override
  BaseColor get color => BaseColor();
}

class BaseContext extends Context with DataMix {
  static const String TOKEN_ADMIN_URL = "v1/auth/token"; 

  Timer? debounceMap;

  BaseContext();

  factory BaseContext.of(State state) {
    return BaseContext()
      ..http = Http(state: state, factories: {
        BaseDataModel: (data) => BaseDataModel(data),
      });
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
