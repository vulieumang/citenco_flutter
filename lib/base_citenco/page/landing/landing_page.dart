import 'dart:typed_data';

import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';

import 'landing_provider.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends BasePage<LandingPage, LandingProvider>
    with DataMix {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didPopNext() {
  //   // TODO: implement didPopNext
  //   super.didPopNext();
  //   Future.delayed(Duration(milliseconds: 100)).then((value) {
  //     Navigator.of(context).pushReplacementNamed("login");
  //   });
  // }

  @override
  LandingProvider initProvider() => LandingProvider(this);
  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[ 
          SafeArea(
            bottom: true,
            child: Padding(
              padding: BasePKG().symmetric(vertical: 10),
              child: Column(
                children: [
                  SpinKitThreeBounce(
                    size: 24,
                    color: BasePKG().color.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("lib/base_citenco/modify/asset/image/splash.jpg"))),
    );
  } 
}
