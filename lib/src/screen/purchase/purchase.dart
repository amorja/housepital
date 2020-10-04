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

class Purchase extends StatefulWidget {
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
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
      url: '${finalUrl}cart',
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
            backgroundColor: primaryBtnColor,
            title: Text('Purchase',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: LayoutPage(homeData)
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