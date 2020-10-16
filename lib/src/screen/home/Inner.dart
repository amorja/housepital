import 'dart:async';
import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:housepital/src/layout/layout.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/drawer.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  
  List<dynamic> homeData ;
  bool progress = false ;
  String data_global ;
  final GlobalKey _scaffoldKey = new GlobalKey();
  
  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    print('globle: ${prefs.getString('data_global')}');
    setState(() {
      data_global = prefs.getString('data_global');
      //data_global='aGIzUWp1OWQ3QkNYckdDRkpwZk5hZlZncXdKL0J1K0Y2aFN2TVRSKzlpYWg4NEQyMHU3LzZ3NWxreldtMTVnNg==';
   
    });
     await ServiceRequest.call(
      url: '${finalUrl}home_inner',
      //url: 'http://incontactadmin.co.uk/mobile/registration',
      method: HttpMethods.POST,
      requestBody: {'data_global': data_global},
      successCallback: success,
      failureCallback: failure
    );

  }

  void success(res) async{
    if(res['code']=='101'){
      var _duration = new Duration(seconds: 2);
      //showToast('${res['message']}',context) ;
      setState(() {
        homeData = res['result'];
        progress=false ;
      });
      
    }
    else {
      showToast('${res['message']}',context) ;
    }
  }

  failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
  @override
  void initState() {
    super.initState();
    actionButton();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            // backgroundColor: primaryBtnColor,
            // title: Text('History',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        //drawer: AppDrawer(),
        //point1
        body: LayoutPage(homeData)
       //body: layout()
      ),
    );
  }

  // Widget layout(){
  //   return SingleChildScrollView(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
  //       child: Column(
  //         children: <Widget>[
  //           container1('lib/assets/images/payment.jpg','Payment History'),
  //           SizedBox(height:8.0),
  //           container1('lib/assets/images/order.jpg','Order History'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  
}