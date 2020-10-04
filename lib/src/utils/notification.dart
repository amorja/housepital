// import 'dart:io';
// //import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';


// class FirebaseNotifications with ChangeNotifier {
//  FirebaseMessaging _firebaseMessaging;
//  bool _newNotification=false ;
//  String token ='';
//  setUpFirebase() {
//    _firebaseMessaging = FirebaseMessaging();
//    firebaseCloudMessaging_Listeners();
//  }

//  void firebaseCloudMessaging_Listeners() {
//    if (Platform.isIOS) iOS_Permission();

//    _firebaseMessaging.getToken().then((token) {
//      token = token ;
//      print('Device Token : $token');
//    });

//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//        _newNotification=true;
//        notifyListeners();

//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//      },
//    );
//  }

//  void iOS_Permission() {
//    _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//  }
// }