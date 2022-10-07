import 'package:cnvsoft/core/storage.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class ColorStyle {
  // static BaseColor _internal;

  // BaseColor._();

  // factory BaseColor() {
  //   if (_internal == null) {
  //     _internal = BaseColor._();
  //   }
  //   return _internal;
  // }

  // Color accentColor = Color(0xffF67C98); //apbar
  // Color primaryColor = Color(0xffF67C98);
  // Color backgroundLoginButton = Color(0xffF67C98);
  static bool invertColor = false;
  
  Color textSkip = Color(0xff958E84);
  Color description = Colors.black.withOpacity(.6);
  Color message = Color(0xff7F7F7F);
  Color disable = Color(0xff2E2E2E).withOpacity(0.1);
  Color disableText = Color(0xff2E2E2E).withOpacity(0.3);

  Color colorTextHeader = Color(0xffffffff);
  Color card = Color(0xffffffff);
  Color background = Color(0xffF5F4F8);
  Color homeBackground = Colors.white;
  Color line = Color(0xffD8D8D8);
  Color date = Color(0xff7F7F7F);
  Color hint = Color(0xff7F7F7F);
  Color dialog = Color(0xffffffff);
  Color icDialogSuccess = Color(0xff39D031);
  Color icDialogError = Color(0xffE02020);
  Color red = Color(0xffD35252);
  Color green = Color(0xff27C096);
  Color smoke = Color(0xff7F7F7F);
  Color textPrimaryButton = Colors.white;
  Color backgroundPrimaryButton = Colors.black;
  Color? textPrimaryDialogButton;
  Color? backgroundPrimaryDialogButton;
  Color textNegativeButton = Colors.black;
  Color backgroundNegativeButton = Color(0xffE3E3E3);
  Color borderLineNegativeButton = Color(0xffE3E3E3);
  Color textAlternaiveButton = Colors.black;
  Color backgroundAlternativeButton = Colors.white;
  Color titleList = Color(0xff1F1F1F);
  Color titleItemList = Color(0xff000000);
  Color profileText = Color(0xFFFFFFFF);
  Color profileSubText = Color(0xff767676);
  Color unselect = Color(0xff6D6D6D);
  Color dateRemain = Color(0xffDC5454);
  Color border = Color(0xffD8D8D8);
  Color row = Color(0xff6D6D6D);
  Color usageRemaining = Color(0xFF979797);
  Color error = Color(0xffcc0000);
  Color youtube = Color(0xffFF0000);
  Color facebook = Color(0xFF1778f2);
  Color apple = ColorStyle.invertColor ? Colors.white : Colors.black;
  Color appleText = ColorStyle.invertColor ? Colors.black : Colors.white;
  Color titleItem = Colors.white;
  Color? homeGridMenuBg;
  Color? colorBottomMenuBg;
  Color homeGridMenuItemCNVTitle = Colors.black;
  Color homeIconTitle = Colors.black;
  Color lineHomeGridMenu = Color(0xffD8D8D8);
  Color textLevelHomeGridMenu = Colors.black54;
  Color arrowIconReward = Colors.white;
  Color homeUserInfo = Color(0xffB4B7BC);
  Color smoothIndicator = Colors.black;
  Color barCodeTabBar = Colors.white;
  Color dateTimePickerText = Colors.white;
  Color snackBarText = Colors.white;
  Color descriptionNotify = Color(0xff545454);
  Color titleNotifySeen = Color(0xff7F7F7F);
  Color bgNumberOfNotification = Colors.red;
  Color pointChange = Color(0xffF9A05D);
  Color cancel = Colors.red;
  Color? primaryStartColor;
  Color? primaryEndColor;
  Color? accentStartColor;
  Color? accentEndColor;
  Color? profileBgColor;
  Color? appBarStartColor;
  Color? appBarEndColor;

  ///Member card's text color:
  List<List<Color>> listMemberCardColor = [
    [
      Color(0xff3ea9a4),
      Color(0xff89f2c6),
      Color(0xff3eb8ce),
    ],
    [
      Color(0xff888a8c),
      Color(0xffdadbdc),
      Color(0xff8c8e90),
    ],
    [
      Color(0xffa7782f),
      Color(0xffd8be79),
      Color(0xffa7782f),
    ],
    [
      Color(0xffa22ccb),
      Color(0xfffa44c7),
      Color(0xff7751cb),
    ],
  ];
  List<List<Color>> listMemberCardTextColor = [];

  List<Color> defaultListTextColor = [Colors.transparent, Colors.transparent];
  List<Color> defaultListColor = [Colors.transparent, Colors.transparent];

  Color levelNew = Color(0xff4b9ac1);
  Color levelSilver = Color(0xFF9E9E9E);
  Color levelGold = Color(0xFFFFC107);
  Color levelDiamond = Color(0xFF673AB7);

  //pager
  Color pagerTitleBackground = Colors.black;
  Color pagerTitleSelected = Colors.white;
  Color pagerTitleUnselected = Colors.grey;

  // Color pending = Color(0xffff9800);
  // Color cancelled = Color(0xffE34B4B);
  // Color confirmed = Color(0xff27C096);
  // Color pending_to_seat = Color(0xff9e9e9e);
  // Color seated = Color(0xff2196f3);

  Color barCodeTitle = Color(0xff000000);
  Color bell = Color(0xffEDE9E6);

  //dialog
  Color titleDialog = Color(0xff000000);
  Color messageDialog = Color(0xff7F7F7F);

  // Color appBarTitle = HexColor(StorageCNV().getString("DES_ACP_HEADER_TEXTCOLOR")!);
  Color appBarTitle = Color(0xffffffff);
  Color appBarbackArrow = HexColor(StorageCNV().getString("DES_ACP_ICON_ACTIVE")!);
  Color nenCard = HexColor(StorageCNV().getString("DES_ACP_ICON_ACTIVE")!);
  Color textCard = HexColor(StorageCNV().getString("DES_ACP_ICON_UNACTIVE")!);
  Color iconCard = HexColor(StorageCNV().getString("DES_ACP_HEADER_NOTICOLOR")!);
  Color htmlText = Color(0xff000000);
  Color text = Color(0xff0D2A5C);

  Color textLoginButton = Colors.white;
  Color loginDescription = Color(0xff958E84);
  Color loginSkip = Color(0xff958E84);
  Color tabBarMain = Color(0xffffffff);
  Color tabbarIconUnselect = Colors.black87;
  Color calendarInMonth = Color(0xff33383D);
  Color calendarOutMonth = Color(0xff90989E);
  Color iconColorPr = Colors.white;
  Color homeMenuHeader = Color(0xff4F4F4F);

  Color facebookButtonBg =
      ColorStyle.invertColor ? Color(0xff121212) : Color(0xFF1778f2);
  Color invertBgLoginColor =
      ColorStyle.invertColor ? Color(0xff121212) : Colors.white;
  Color invertTextColor = HexColor(StorageCNV().getString("DES_ACP_HEADER_TEXTCOLOR")!);

  Color dateUnselected = ColorStyle.invertColor ? Colors.white : Colors.black;

  //reward
  Color rewardPointBg = Color(0xff000000).withOpacity(0.8);
  Color rewardPointText = Color(0xffFFD714);

  Color? colorBuildDay;

  Color get hintOpacity => hint.withOpacity(0.5);
}
