import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/font_sizes.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/layout/layout.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/screen/home/webViewPage.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/drawer.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      url: '${finalUrl}home',
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
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          // child: CustomAppbar(
          //   title : 'Home',
          //   leadingbtn: false,
          //   drawer : false,
          // ),
          child: AppBar(
            backgroundColor: primaryBtnColor,
            title: Text('Home',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: progress ? Container(
            child: CircularProgressIndicator(),
          ) : LayoutPage(homeData),
        ),

      ),
    );
  }
  Widget homeService(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: grey77),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.only(left: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      print(text);
                    },
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.search,size: 36,),
                      hintText: 'Search ..',
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: black25)
                      ),
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Medical care at home',style: Styles.primaryTextwithf16,),
                Divider(
                  color: black75,
                ),
                SizedBox(height:6.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: layoutContainer(2,'motherbaby','Mother Baby Care','fill'),
                    ),
                    SizedBox(width:6.0),
                    Expanded(
                      child: layoutContainer(2,'nursingcare','Nursing Care','fill'),
                    )
                  ],
                ),
                SizedBox(height:6.0),
                layoutContainer(1,'physio','Physiotherapy & Rehabilitation Care','contain'),
                SizedBox(height:6.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: layoutContainer(2,'eldercare','Elder Care','fill'),
                    ),
                    SizedBox(width:6.0),
                    Expanded(
                      child: layoutContainer(2,'nursingcare','Critical Care','fill'),
                    )
                  ],
                ),
                SizedBox(height:16.0),
                Text('Medical Service at home',style: Styles.primaryTextwithf16,),
                Divider(
                  color: black75,
                ),
                SizedBox(height:6.0),
                layoutContainer(1,'serviceinhome','Elder Care','contain'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget layoutContainer(width,imagename,title,imagefit){
    
    return Container(
      color: greyBackgroundColor,
      width: MediaQuery.of(context).size.width/width,
      child: Column(
        children: <Widget>[
          Container(
            height: 140.0,
            child: ClipRRect(
              child: Image.network(imagename,fit: imagefit== 'fill' ? BoxFit.fill : BoxFit.cover,width: MediaQuery.of(context).size.width
              ,),
            ),
          ),
          SizedBox(height:6.0),
          SizedBox(height:40.0,child: Center(child: Text(title ,style: Styles.blackTextwithf18,))),
          SizedBox(height:6.0),
        ],
      ),
    );
  }

}
