import 'dart:async';
import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/drawer.dart';

class Purchase extends StatefulWidget {
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  num _stackToView = 2;
  InAppWebViewController webView;
  double progress = 0;
  int progressbar=0;
      
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
            title: Text('Purchase',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: layout()
      ),
    );
  }
  Widget layout(){
    return SingleChildScrollView(
      child:Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            container1('lib/assets/images/image1.jpg','Care Taker 24 hour for 30 Days','From - 20 jan to 20 Feb \nDays - 30 \nTotal Amount - 24000 Rs'),
            SizedBox(height:8.0),
            container1('lib/assets/images/oxygen.png','Oxygen concentrators 5L','Quantity - 1 \nGST - 3000 Rs \nTotal Amount - 24000 Rs'),
          ],
        ),
      ),
    );
  }
  Widget container1(image,title,subtitle){
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: white100
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
            width: MediaQuery.of(context).size.width/3,
            height: 140.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(image,fit: BoxFit.cover,))),
            SizedBox(width:16.0),
            Container(
              width: MediaQuery.of(context).size.width*2/3-50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: Styles.blackTextwithf16w6),
                  Text(subtitle,style: Styles.blackopacity5f14, ),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset('lib/assets/icons/edit.png',width: 20.0,color: yellowGreen,),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset('lib/assets/icons/delete.png',width: 24.0,color: warningColor,),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}