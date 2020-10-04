import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/layout/layout.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/screen/home/webViewPage.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/drawer.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with WidgetsBindingObserver {
  List<dynamic> homeData ;
  bool progress=true ;
  String data_global ;
  
  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      data_global = prefs.getString('data_global');
      //data_global='R2l3Zi9JWUdqekhSa05Ed0NPQjgrNjBNYmVnMzRnMlgxS3I3TW9LQnZWM3FUTThJNzFGTktNME0xWWRTUllQK0tueDZOUDh3ZC8yRTFiL2dmTDFwaU1GMEFUWXB1WlVoZkwxWk8wcjBKOEJ6azRUWVZ5ZkoxdkhRckxmRUZ5dUdKYk1qZGIwSjlVTmlKVEc4REc5aHU5WWdBcmlDbTN6bDhEdWdEK3VNSXhpWWlQMnlyeXlva09jTTI3K2NTWmp0UE1LSWV2dmFCRUNiRkpKWnJaQkYrRGJ3RjFCbFhtTG1UVXEyQ2xsNEVVaz0=';
   
    });
     await ServiceRequest.call(
      url: '${finalUrl}notification',
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
        backgroundColor: greyBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: primaryBtnColor,
            title: Text('Notification',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: LayoutPage(homeData),
        
        // Center(
        //   child: progress ? Container(
        //     child: CircularProgressIndicator(),
        //   ) : projectwidget(),
        // ),

      ),
    );
  }
  Widget layout(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          container1('lib/assets/icons/cart.png','Payment Pending','Payment pending for - Nurses 12 Hr(23 days), Oxygen cyliender 5L (31 days)','23 min ago'),
          SizedBox(height: 6.0,),
          container1('lib/assets/icons/doller.png','Order Purchased','Payment for Nurses 12 Hr (30 days), Oxygen cyliender 5L has being confirmed ','23 May at 3:00 pm'),
          SizedBox(height: 6.0,),
          container1('lib/assets/icons/cart.png','Payment Pending','Payment pending for - Nurses 12 Hr(23 days), Oxygen cyliender 5L (31 days)','23 min ago'),
          SizedBox(height: 6.0,),
          container1('lib/assets/icons/doller.png','Order Purchased','Payment for Nurses 12 Hr (30 days), Oxygen cyliender 5L has being confirmed ','23 May at 3:00 pm'),
        ],
      ),
    );
  }
  Widget container1(image,title,subtitle,time){
    return Container(
      padding: EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
      width: MediaQuery.of(context).size.width,
      color: white100,
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            child: Image.asset(image)),
          SizedBox(width:16.0),
          Container(
            width: MediaQuery.of(context).size.width-100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,style: Styles.blackTextwithf16w6),
                Text(subtitle,style: Styles.blackopacity5f14, ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(time,style: Styles.blackopacity5f14,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget projectwidget(){
    return new ListView.builder(
      itemCount: homeData == null ?0 : homeData.length ,
      itemBuilder: (BuildContext context, i){
        return _firstlayout(homeData[i]);
      },
    ) ;
  }
   _firstlayout(data){
        
    if(data['layout_code']=="1"){
      if(data['title']==""){
        return new Container(
          child: new SizedBox(
            height: 10.0,
          ),
        );
      } else{
      return Container(
          margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data['title']!=null ?data['title']:"", style: TextStyle(color: Colors.black54, fontSize:22.0, fontWeight: FontWeight.bold,letterSpacing:1.0 ))
            ],
          ),
          ),
      );
      }
    }
    else if(data['layout_code']=="2"){
      if(data['image']==""){
        return new Container(
          child: new SizedBox(
            height: 15.0,
          ),
        );
      }else{
      
      return InkWell(
        onTap: (){
          if(data['web_view']== "0"){
            Navigator.pushNamed(context, data['next_page']['page_code'],arguments: data['next_page']);
          }else{
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewPage(
              path: data['web_link'],
              title: data['web_view_heading'], ),
            ));
          }
        },
        child: Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0,color: Colors.grey[400]),
          boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                child: new ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: new Image(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                        return Center(
                          child: LinearProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? 
                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 30.0,
                  child: AutoSizeText(data['text'] !=null ?data['text']:"", 
                    style: TextStyle(color: Colors.black54,fontSize: 16.0),
                    maxLines: 2,minFontSize: 12.0,softWrap: true, overflow: TextOverflow.clip,)),
              )
            ],
          ),
        ),
      );
      }
    }
    else if(data['layout_code']=="3"){
      return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewPage(
              path: data['web_link'],
              title: data['web_view_heading'], ),
            ));
          },
          child: Container(
          padding: EdgeInsets.all(6.0),
          margin: EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
          height: 100.0,
          decoration: BoxDecoration(
            color: Color(int.parse("0xFF${data['background_color']}")) ,
            border: Border.all(width: 1.0,color: Colors.grey[400]),
            boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Row(
              children: <Widget>[
                new Container(
                  height: 100.0,
                  width:110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data['image']))
                    ),
                  
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,right:8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 70.0,
                        child: Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 16.0),)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data['timestamp']* 1000)), style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              
            ],
          )
        ),
      );
    }
    else if(data['layout_code']=="4"){
      return Container(
        margin: EdgeInsets.all(12.0),
        height: 400.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
        ),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: new Image(
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(data['image']),
                fit: BoxFit.fill,
              ),
            ),
            ),
            
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 22.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Icon(Icons.arrow_forward , color: Colors.black54,size: 30.0,),
                )
              ],
            )
          ],
        )
      );
    }
    else if(data['layout_code']=="5"){
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.all(8.0),
        height:110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: NetworkImage(data['image']),
            fit: BoxFit.cover
          ),
        ),
      );
    }
    else if(data['layout_code']=="6"){
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 20.0),
                  child: new Text(data['title']!=null ?data['title']:"", style: TextStyle(color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 20.0),
                  child: new Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _listhrdata(data['elements'][0]),
                _listhrdata(data['elements'][1]),
                _listhrdata(data['elements'][2]),
              ],
            )
          ],
        )
      );
    }
    else{
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(top:8.0,left: 8.0,right:8.0,bottom: 16.0),
        child: new Divider(
          height:2.0,
          color: Colors.black,
        ),
      );
    }
    //return Text(data['layout_code'], style: TextStyle(color: Colors.deepPurple));
  }

   _listhrdata(datael){
     String colorbg = datael['element_bg_color'].replaceAll('#', '0xff');
     String colorfont = datael['element_text_color'].replaceAll('#', '0xff');
    return new Container(
      height: 200.0,
      width:MediaQuery.of(context).size.width/3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: new Color(int.parse(colorbg)),
      ),
      child: Center(child: new Text(datael['element_name']!=null? datael['element_name']:"",style: TextStyle(color: new Color(int.parse(colorfont)),fontSize: 18.0),)),
    );
      //return myList;
  }
}