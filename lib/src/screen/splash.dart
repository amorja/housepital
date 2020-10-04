import 'dart:async';
import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/database_helper.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:device_info/device_info.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  final dbHelper = DatabaseHelper.instance;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;
  IosDeviceInfo iosInfo ;
  String tokenid;
  var uniqueid ;
  fetchDeviceInfo() async {
    if (Platform.isAndroid) {
       androidInfo = await deviceInfoPlugin.androidInfo;
       return uniqueid=androidInfo.androidId ;
    }

    if (Platform.isIOS) {
       iosInfo = await deviceInfoPlugin.iosInfo;
       return uniqueid=iosInfo.identifierForVendor ;
    }

  }

  

  startTime(String data) async {
    var _duration = new Duration(seconds: 2);
    print('data: $data');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('data_global', '$data');
    //return new Timer(_duration, navigationPage);
    await ServiceRequest.call(
      url: '${finalUrl}splash',
      method: HttpMethods.POST,
      requestBody: {'data_global' : data == null ? '' : data},
      successCallback: success,
      failureCallback: failure
    );

  }
  navigationPage(){
    Navigator.pushNamedAndRemoveUntil(context, login,(Route<dynamic> route) => false);
  }
  void success(res) async{
    if(res['code']=='101'){

       print('${res['result']['next_page']['page_code']}');
      // String redirecturl= res['result']['next_page']['page_code'] ;
      Navigator.pushNamed(context, res['result']['next_page']['page_code']);
    }
    else if(res['code']=='10'){

    }
  }
  failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
  
  @override
  void initState() {
   //FirebaseNotifications() ;
  //  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //  _firebaseMessaging.getToken().then((token) {
  //     setState(() {
  //       tokenid = token ;
  //       print('Device: $tokenid');
  //     });
  //   });
    fetchDeviceInfo();
    _query();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:Container(
        width:double.infinity ,
        height: double.infinity,
        decoration: BoxDecoration(
          color: white100
        ),
        child: Center(
          child: Container(
            width: 240.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/assets/logo/logo.png'),
              ],
            ),
          ),
        ),
      )
      
    );
  }
  void _insert(value) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnmobileid : value,
      DatabaseHelper.columnname  : '',
      DatabaseHelper.columnusername  : '',
      DatabaseHelper.columnavatar  : '',
      DatabaseHelper.columnemail  : '',
      DatabaseHelper.columndata  : '',
      DatabaseHelper.columnmobileno  : '',
      DatabaseHelper.columnloggedin  : 0
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    //Navigator.pushNamed(context, RegisterViewRoute);
    //startTime('');
    Navigator.pushNamed(context, login);
  }
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print(uniqueid);
    if(allRows.isEmpty){
      _insert(uniqueid);
      //print('null');
    }else{
      //print('query all rows: ${allRows.length}');
    allRows.forEach((row) {
      //print(row) ;
      if(row['unique_mobileId']== uniqueid && row['loggedin']==1){
        
        Navigator.pushNamed(context, screen,arguments: {'screenid':0});
      }
      else{
        print('Logout');
        //startTime('${row['data_global']}');
         Navigator.pushNamed(context, login);
      }
    });
    }

  }
}