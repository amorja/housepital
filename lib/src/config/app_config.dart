// this file consists the file app configuration
// for different flavours like DEV, QA, and PRODUCTION
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:housepital/src/config/app_enum.dart';
import 'package:housepital/src/utils/string_utils.dart';

class AppFlavorSpecificValues {
  // this class consist values corresponding to 
  // flavour of the app like different baseUrl for QA and PRODUCTION
  AppFlavorSpecificValues({@required this.baseUrl});

  final String baseUrl;
  
}

class AppFlavorConfig {
  // this class provide the flavor config
  // and used for different development URL for
  // for specific apk flavor;
  final AppFlavor appFlavor;
  final String name;
  final Color color;
  final AppFlavorSpecificValues flavorValues;

  static AppFlavorConfig _instance;

  factory AppFlavorConfig({
    @required AppFlavor appFlavor,
    Color color: Colors.blue,
    @required AppFlavorSpecificValues flavorValues
  }) {
    _instance ??= AppFlavorConfig._internal(
      appFlavor, StringUtils.enumName(appFlavor.toString()), color, flavorValues);
    return _instance;
  }

  AppFlavorConfig._internal(
    this.appFlavor,
    this.name,
    this.color,
    this.flavorValues
  );

  static AppFlavorConfig get instance => _instance;
  // is Production ready apk
  static bool isProduction() => _instance.appFlavor == AppFlavor.PRODUCTION;
  // is debug apk
  static bool isDebug() => _instance.appFlavor == AppFlavor.DEV;
  // is QA apk
  static bool isQA() => _instance.appFlavor == AppFlavor.QA;
}