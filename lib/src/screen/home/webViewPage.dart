import 'dart:async';
import 'dart:io';

import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String path ;
  String title;
  String redirect;
  WebViewPage({this.path,this.title,this.redirect});
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  num _stackToView = 1;
  InAppWebViewController webView;
  double progress = 0;
  int progressbar=0;

  @override
  Widget build(BuildContext context) {
    print('Path: ${widget.path}');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: CustomAppbar(
          title : widget.title,
          leadingbtn: true,
          ),
      ),
      body: IndexedStack(
      index: _stackToView,
      children: [
        Column(
          children: < Widget > [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: InAppWebView(
                  initialUrl: widget.path,
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: true,
                    )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    
                  },
                  onLoadStop: (InAppWebViewController controller, String url) async {
                    if(mounted){
                      setState(() {
                        _stackToView=0;
                      });
                    }
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    if(mounted){
                      setState(() {
                        progressbar=progress;
                        this.progress = progress / 100;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Loading : $progressbar %' ,style: Styles.blackTextwithf16w6,),
                Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()),
              ],
            ),
          ),
        ),
      ],
    )
    );
  }
}