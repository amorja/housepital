
import 'package:housepital/src/screen/home/Home.dart';

import 'package:housepital/src/screen/home/home_detail.dart';
import 'package:housepital/src/screen/home/notification.dart';
import 'package:housepital/src/screen/home/page_detail.dart';
import 'package:housepital/src/screen/onboard/category.dart';
import 'package:housepital/src/screen/onboard/gdpr.dart';
import 'package:housepital/src/screen/onboard/loginswitch.dart';
import 'package:housepital/src/screen/onboard/otpscreen.dart';
import 'package:housepital/src/screen/onboard/register.dart';
import 'package:housepital/src/screen/onboard/termsandcon.dart';
import 'package:housepital/src/screen/profile/active.dart';
import 'package:housepital/src/screen/profile/helpNSupport.dart';
import 'package:housepital/src/screen/profile/savedresources.dart';
import 'package:housepital/src/screen/screens.dart';
import 'package:housepital/src/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:housepital/src/screen/onboard/login.dart';
import './route_const.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case screen:
      return MaterialPageRoute(builder: (context) => Screens(settings.arguments));
    case home:
      return MaterialPageRoute(builder: (context) => Home());
    case detailedPage:
      return MaterialPageRoute(builder: (context) => DetailedPage(settings.arguments));

     
    case activeServicePage :
      return MaterialPageRoute(builder: (context) => ActiveService(settings.arguments));
    case pageExtanded:
      return MaterialPageRoute(builder: (context) => PageExtanded(settings.arguments));
    case notification:
      return MaterialPageRoute(builder: (context) => NotificationView());
    case login:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case otpscreen:
      return MaterialPageRoute(builder: (context) => OTPScreen());
    case registration:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case switchAccount:
      return MaterialPageRoute(builder: (context) => SwitchLoginPage());
    case gdpr:
      return MaterialPageRoute(builder: (context) => GDPRScreen());
    case TermnCons:
      return MaterialPageRoute(builder: (context) => TermnConScreen());
    case category:
      return MaterialPageRoute(builder: (context) => Category());
    case SaveResource:
      return MaterialPageRoute(builder: (context) => SavedResource());
    case Help:
      return MaterialPageRoute(builder: (context) => HelpSupport());

    default:
      return MaterialPageRoute(builder: (context) => Screens(settings.arguments));
  }
}
