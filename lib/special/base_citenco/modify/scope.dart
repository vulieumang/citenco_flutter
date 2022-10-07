import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:flutter/material.dart';
import 'package:cnvsoft/special/base_citenco/package/scope.dart';
 
class LoyaltyScope with DataMix {
  static LoyaltyScope? _i;
 
  LoyaltyScope._();
 
  factory LoyaltyScope() {
    if (_i == null) _i = LoyaltyScope._();
    return _i!;
  }

  BaseScope base = BaseScope();
 
  void set(State state, Map<String, dynamic> json) { 
    dataOf(() =>BaseScope().set(state,json["base"]));
  }
}