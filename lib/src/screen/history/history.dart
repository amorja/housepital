import 'dart:async';
import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/drawer.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String donateUrl='' ;
  num _stackToView = 2;
  InAppWebViewController webView;
  double progress = 0;
  int progressbar=0 ;
      
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
            backgroundColor: primaryBtnColor,
            title: Text('History',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: layout()
      ),
    );
  }

  Widget layout(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          children: <Widget>[
            container1('lib/assets/images/payment.jpg','Payment History'),
            SizedBox(height:8.0),
            container1('lib/assets/images/order.jpg','Order History'),
          ],
        ),
      ),
    );
  }
  Widget container1(image,title){
    return Stack(
      children: <Widget>[
        Material(
          elevation: 8.0,
          shadowColor: black100,
          child: ClipRRect(
            child: Image.asset(image),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            decoration: BoxDecoration(
              color: black50
            ),
            child: Center(child: Text(title,style: Styles.whiteTextwithf20w6,)),
          ))
      ],
    );
  }
}