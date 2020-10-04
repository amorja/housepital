import 'dart:async';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GDPRScreen extends StatefulWidget {
  @override
  _GDPRScreenState createState() => _GDPRScreenState();
}

class _GDPRScreenState extends State<GDPRScreen> {
  double _isvisible=0.0 ;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white100,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 64.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('GDPR',style: Styles.blackTextwithf20w6,),
              SizedBox(height: 10.0,),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: WebView(
                    gestureRecognizers:gestureRecognizers,
                    initialUrl: webUrlLibrary,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onPageFinished: pageFinishedLoading,
                  )
                )
                ),
                SizedBox(height: 32.0,),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            child: Opacity(
              opacity: _isvisible,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black54,
              ),
            )),
          Positioned(
            bottom: 32.0,
            left: 16.0,
            right: 16.0,
            child: Button(
              title: 'I agree',
              onpress: (){ _showGDPRDialog(); } ,
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
  _showGDPRDialog() {
    setState(() {
      _isvisible = 1.0 ;
    });
    showDialog(
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
                  decoration: InputDecoration(
                    labelText: 'Insert text here',
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
                        setState(() {
                          _isvisible = 0.0 ;
                        });
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
                        _goToTerms(context); } ,
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
  _goToTerms(context){
    Navigator.pushNamed(context, TermnCons);
  }
}