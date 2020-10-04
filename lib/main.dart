import 'dart:async';

import 'package:flutter/material.dart';
import 'package:housepital/App.dart';
import 'package:housepital/src/config/app_config.dart';
import 'package:housepital/src/config/app_enum.dart';
import 'package:housepital/src/constants/urls.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// void main() {
//   AppFlavorConfig(
//     appFlavor: AppFlavor.DEV,
//     color: Colors.deepPurple[300],
//     //flavorValues: AppFlavorSpecificValues(baseUrl: graphqluri)
//     flavorValues: AppFlavorSpecificValues(baseUrl: graphqluriproduction)
//   );
//   Crashlytics.instance.enableInDevMode = true;
//   // Pass all uncaught errors to Crashlytics.
//   FlutterError.onError = Crashlytics.instance.recordFlutterError;
//   runZoned(() {
//     runApp(App());
//   }, onError: Crashlytics.instance.recordError);

// }

void main() {
  AppFlavorConfig(
    appFlavor: AppFlavor.DEV,
    color: Colors.deepPurple[300],
    flavorValues: AppFlavorSpecificValues(baseUrl: productionBaseUrl)
  );
  runApp(App());
}
