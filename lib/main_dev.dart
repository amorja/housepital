import 'package:flutter/material.dart';
import 'package:housepital/App.dart';
import 'package:housepital/src/config/app_config.dart';
import 'package:housepital/src/config/app_enum.dart';
import 'package:housepital/src/constants/urls.dart';

void main() {
  AppFlavorConfig(
    appFlavor: AppFlavor.PRODUCTION,
    flavorValues: AppFlavorSpecificValues(
      baseUrl: debugBaseUrl
    )
  );
  runApp(App());
}