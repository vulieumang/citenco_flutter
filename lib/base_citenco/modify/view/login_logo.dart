import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';

enum LogoType { Login, LoginPhone }

class LogoView extends StatelessWidget {
  final LogoType? type;

  const LogoView({Key? key, this.type}) : super(key: key);

  factory LogoView.login() {
    return LogoView(type: LogoType.Login);
  }

  factory LogoView.loginPhone() {
    return LogoView(type: LogoType.LoginPhone);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double heightLogoIcon = ModifyPKG().convert(120);
    if (type == LogoType.Login)
      return Container(
        height: heightLogoIcon,
        child: FadeInImage(
          placeholder: AssetImage(
              "lib/special/modify/asset/image/logo/logo.png"),
          image: NetworkImage(StorageCNV().getString("HOME_ACP_LOGO")!,),
          fit: BoxFit.cover,
          height: ModifyPKG().convert(62),
          width: ModifyPKG().convert(248.59),)
      );
    else
      return Padding(
        padding: ModifyPKG().all(24),
        child: 
        FadeInImage(
          placeholder: AssetImage(
              "lib/special/modify/asset/image/logo/logo.png"),
          image: NetworkImage(StorageCNV().getString("HOME_ACP_LOGO")!),
          fit: BoxFit.cover,
          height: heightLogoIcon,
          width: ModifyPKG().convert(246.59),
        )
      );
  }
}
