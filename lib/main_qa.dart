import 'package:flutter/material.dart';
import 'package:housepital/App.dart';
import 'package:housepital/src/config/app_config.dart';
import 'package:housepital/src/config/app_enum.dart';
import 'package:housepital/src/constants/urls.dart';

void main() {
  AppFlavorConfig(
    appFlavor: AppFlavor.QA,
    flavorValues: AppFlavorSpecificValues(
      baseUrl: qaBaseUrl
    )
  );
  runApp(App());
}