import 'dart:io';

import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy {
  static PrivacyPolicy? _internal;

  PrivacyPolicy._();

  factory PrivacyPolicy() {
    if (_internal == null) _internal = PrivacyPolicy._();
    return _internal!;
  }

  bool isVisible(State state) =>
      getLink(state).isNotEmpty &&
      Platform.isAndroid &&
      PackageManager().onlyInReviewVersion(state);

  String getLink(State state) {
    String link = BasePKG.of(state).http!.accountDomainName ?? "";
    if (link.isNotEmpty) {
      link = "https://privacy-policy.cnvloyalty.com/" + link;
    }
    String scopeLink = BaseScope().privacyLink;
    if (scopeLink.isNotEmpty) {
      if (scopeLink == "null") scopeLink = "";
      link = scopeLink;
    }
    return link;
  }
}
