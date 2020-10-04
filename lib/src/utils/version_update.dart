import 'dart:io';

import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:housepital/src/lang/lang.dart';
import 'package:http/http.dart' as http;
import 'package:housepital/src/utils/service_request.dart';
import 'package:url_launcher/url_launcher.dart';

class  VersionUpdate {
  static var context;
  var appStoreUrl;
  var playStoreUrl;
  var updateversion;
  var finalUpdatedVersion;
  bool forceUpdate ;
  bool recommendUpdate ;

  versionCheck(context) async {
    print('main');
    /// make the service call to check the current version;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now();
    /// this is used to check the current time 
    /// is expired of not from the
    await prefs.setString("forceUpdateExpireTime", '${currentTime.add(Duration(hours: 0))}');
    final forceUpdateTime = prefs.getString("forceUpdateExpireTime");

    if (forceUpdateTime == null) {
      print('forcecheck');
      return;
    }

    if (forceUpdateTime != null) {
      print('notnull');
      print('$forceUpdateTime');
      final expiryTime = DateTime.parse(forceUpdateTime);
      if (!currentTime.isAfter(expiryTime)) {
        print('notcheck');
        //return;
      }
    }
    
    final PackageInfo pkgInfo = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(pkgInfo.version.trim().replaceAll(".", ""));

    /// get latest current version from the server;
    success(res) {
      /// this is called for success
      finalUpdatedVersion = res['appVersion'];
      appStoreUrl = res['appStoreLink'];
      playStoreUrl = res['playStoreLink'];
      forceUpdate = res['forceUpdate'];
      recommendUpdate = res['recommendUpdate'];
      finalUpdatedVersion = double.parse(finalUpdatedVersion
        .trim()
        .replaceAll(".", ""));
      if (finalUpdatedVersion > currentVersion) {
        /// show the update dislog modal;
        showVersionDialog(context);
      }
    }

    failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }

    await ServiceRequest.call(
      url: versionApi,
      method: HttpMethods.GET,
      successCallback: success,
      failureCallback: failure
    );

  }

  Widget _iosUpdateDialog(context) {
    return CupertinoAlertDialog(
      title: Text(VersionUpdateText.title),
      content: Text(VersionUpdateText.message),
      actions: <Widget>[
        FlatButton(
          child: Text(VersionUpdateText.btnLabel),
          onPressed: () => _launchURL(appStoreUrl),
        ),
        forceUpdate ? SizedBox(width:2.0) :
        FlatButton(
          child: Text(VersionUpdateText.btnLabelCancel),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _androidUpdateDialog (context){
    return AlertDialog(
      title: Text(VersionUpdateText.title),
      content: Text(VersionUpdateText.message),
      actions: <Widget>[
        FlatButton(
          child: Text(VersionUpdateText.btnLabel),
          onPressed: () {
            _launchURL(playStoreUrl);
          },
        ),
        forceUpdate ? SizedBox(width:2.0) :
        FlatButton(
          child: Text(VersionUpdateText.btnLabelCancel),
          onPressed: () async{ 
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('app_version', updateversion);
            Navigator.pop(context);
            
          },
        ),
      ],
    );
  }

  showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: (){return Future.value(false);},
          child: Platform.isIOS ? _iosUpdateDialog(context) : _androidUpdateDialog(context),
        ) ;
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
