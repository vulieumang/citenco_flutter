import 'dart:typed_data';

import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';

import 'scan_car_provider.dart';

class ScanCarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScanCarPageState();
}

class ScanCarPageState extends BasePage<ScanCarPage, ScanCarProvider>
    with DataMix {
  @override
  void initState() {
    super.initState();
  } 
  
  @override
  ScanCarProvider initProvider() => ScanCarProvider(this);
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
