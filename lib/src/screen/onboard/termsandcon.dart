import 'dart:async';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermnConScreen extends StatefulWidget {
  @override
  _TermnConScreenState createState() => _TermnConScreenState();
}

class _TermnConScreenState extends State<TermnConScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  _showGDPRDialog() async{
    await Future.delayed(Duration(milliseconds: 50));
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.notifications_none,size:60.0,color: black75,),
                Text('We take GDPR seriously',style: Styles.blackTextwithf18w6,),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'please review and agree our policies',
                    labelStyle: Styles.blackTextwithf16,
                    contentPadding: EdgeInsets.only(left:20.0)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Button(
                      title: 'Skip',
                      onpress: (){ 
                        Navigator.of(context).pop(); } ,
                      color: grey77,
                      width: MediaQuery.of(context).size.width/3,
                      height: 44.0,
                      textStyle: Styles.blackTextwithf16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)
                      ),
                    ),
                    Button(
                      title: 'Yes, Please',
                      onpress: (){ 
                        Navigator.of(context).pop();
                         } ,
                      color: primaryColor,
                      width: MediaQuery.of(context).size.width/3,
                      textStyle: Styles.whiteTextwithf16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
    });
  }
  @override
  void initState() {
    _showGDPRDialog();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white100,
        automaticallyImplyLeading: false,
        actions: <Widget>[

          Icon(Icons.file_download,color: black100,),
          SizedBox(width:20.0),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Terms & Conditions',style: Styles.blackTextwithf20w6,),
              SizedBox(height: 10.0,),
              Expanded(
                child: WebView(
                  gestureRecognizers:gestureRecognizers,
                  initialUrl: '',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  //onPageFinished: pageFinishedLoading,
                )
              ),
              SizedBox(height: 32.0,),
            ],
            ),
          ),
          Positioned(
            bottom: 32.0,
            left: 16.0,
            right: 16.0,
            child: Button(
              title: 'I agree',
              onpress: (){ _goToTerms(context); } ,
              color: primaryColor,
              width: MediaQuery.of(context).size.width,
              textStyle: Styles.whiteTextwithf16,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
            ),
          )
        ],
      ),
    );
  }
  void pageFinishedLoading(String url) {
    setState(() {
      //_stackToView = 0;
    });
  }
  _goToTerms(context){
    Navigator.pushNamedAndRemoveUntil(context, switchAccount,(Route<dynamic> route) => false);
  }
}