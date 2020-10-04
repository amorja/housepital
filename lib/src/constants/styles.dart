import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'font_sizes.dart';

abstract class Styles {

  static const gradientbg = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFFBF8), Color(0xffb8eae3)]
            );
  static const gradientbgwhite = LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]
            );

  static var splashStyle= TextStyle(
    fontSize: FontSizes.FONT_30,
    color: black100,
  );
  static var sublineStyle= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
  static var headingstyle= TextStyle(
      fontSize: FontSizes.FONT_18,
      color: black100,
    );

  static var whiteTextwithf12= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_12
  );
  static var whiteTextwithopacity75f12= TextStyle(
    color: Color(0xffffffff).withOpacity(0.75),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_12
  );
  static var whiteTextwithopacity75f16= TextStyle(
    color: Color(0xffffffff).withOpacity(0.70),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_16
  );
  static var whiteTextwithopacity75f18= TextStyle(
    color: Color(0xffffffff).withOpacity(0.70),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_18
  );
  static var whiteTextwithf14= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_14
  );
  static var whiteTextwithf16= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_16
  );
  static var whiteTextwithf18= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_18
  );
  static var greyTextwithf16= TextStyle(
    color: Color(0xff7E8088),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_16
  );
  static var greyTextwithf18= TextStyle(
    color: Color(0xff7E8088),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_18
  );
  static var whiteTextwithf20= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_20
  );
  static var whiteTextwithf20w6= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_20
  );
  static var whiteTextwithf22= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_22
  );
  static var whiteTextwithf22w6= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_22
  );
   static var primaryTextwithf12= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_12
  );
   static var primaryTextwithf12ul= TextStyle(
    fontSize: FontSizes.FONT_12,
    color: primaryColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  );
   static var primaryTextwithf14= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
   static var primaryTextwithf16= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_16
  );
   static var primaryTextwithf18= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_18
  );
   static var primaryTextwithf18w6= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_18
  );
   static var primaryTextwithf20= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_20
  );
  static var primaryTextwithf22= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_22
  );
  static var primaryTextwithf24= TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_24
  );

  static var btnTextwithf12= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_12
  );
   static var btnTextwithf12ul= TextStyle(
    fontSize: FontSizes.FONT_12,
    color: btnTextColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  );
   static var btnTextwithf14= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
   static var btnTextwithf16= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_16
  );
   static var btnTextwithf18= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_18
  );
   static var btnTextwithf18w6= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_18
  );
   static var btnTextwithf20= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_20
  );
  static var btnTextwithf22= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_22
  );
  static var btnTextwithf24= TextStyle(
    color: btnTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_24
  );

  static var secondaryTextwithf12= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_12
  );
   static var secondaryTextwithf12ul= TextStyle(
    fontSize: FontSizes.FONT_12,
    color: secondaryColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  );
   static var secondaryTextwithf14= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
   static var secondaryTextwithf16= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_16
  );
   static var secondaryTextwithf18= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_18
  );
   static var secondaryTextwithf18w6= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_18
  );
   static var secondaryTextwithf20= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_20
  );
  static var secondaryTextwithf22= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_22
  );
  static var secondaryTextwithf24= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_24
  );
  static var secondaryTextwithf28= TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_28
  );
   static var warningTextwithf12= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_12
  );
   static var warningTextwithf14= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
   static var warningTextwithf16= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_16
  );
   static var warningTextwithf18= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_18
  );
   static var warningTextwithf20= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_20
  );
  static var warningTextwithf22= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_22
  );
  static var warningTextwithf24= TextStyle(
    color: warningColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_24
  );
   static var blackTextwithf10= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_10
  );
  static var blackTextwithf12= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_12
  );
  static var blackTextwithf14= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_14
  );
  static var blackTextwithf16= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_16,
  );
  static var blackTextwithf16w6= TextStyle(
    color: black100,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_16
  );
  static var blackTextwithf18= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_18
  );
  static var blackTextwithf18w6= TextStyle(
    color: black100,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_18
  );
  static var blackTextwithf20= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_20
  );
  static var blackTextwithf20w6= TextStyle(
    color: black100,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_20
  );
  static var blackTextwithf22w6= TextStyle(
    color: black100,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_22
  );
  static var blackTextwithf22= TextStyle(
    color: black100,
    fontWeight: FontWeight.w400,
    fontSize: FontSizes.FONT_22
  );
  static var blackTextwithf24= TextStyle(
    color: black100,
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_24
  );
  static var blackTextwithf24w6= TextStyle(
    color: black100,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_24
  );
  static var blackTextwithf30= TextStyle(
    color: black75,
    fontWeight: FontWeight.w600,
    fontSize: FontSizes.FONT_30
  );
  static var blackTextwithf30w6= TextStyle(
    color: black75,
    fontWeight: FontWeight.normal,
    fontSize: FontSizes.FONT_30
  );

  static var btnWhiteText= TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.FONT_14
  );
  static var btnWhiteback= TextStyle(
    color: Color(0xff41BFA8),
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.FONT_14
  );
  static var btnShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    side: BorderSide(color: downloadbtn)
  );
  static var btnShapefillcolor = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  static var btnShapeOrangeColor = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    side: BorderSide(color: otpColor)
  );
  static var greentextStyle = TextStyle(
    fontSize: FontSizes.FONT_12,
    color: primaryColor,
    fontWeight: FontWeight.w500,
  );
  static var waittextstyle = TextStyle(
    fontSize: FontSizes.FONT_12,
    color: waitbtn,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  );
  static var blackopacity5 = TextStyle(
    fontSize: FontSizes.FONT_12,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );
  static var blackopacity5f18 = TextStyle(
    fontSize: FontSizes.FONT_18,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );
  static var blackopacity5f18wlineheight = TextStyle(
    fontSize: FontSizes.FONT_18,
    color: black75 ,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );
  static var blackopacity5f16 = TextStyle(
    fontSize: FontSizes.FONT_16,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );
  static var blackopacity5f14 = TextStyle(
    fontSize: FontSizes.FONT_14,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );
  static var blackopacity5f12 = TextStyle(
    fontSize: FontSizes.FONT_12,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );
  static var blackopacity5f10 = TextStyle(
    fontSize: FontSizes.FONT_10,
    color: blackopacity5color ,
    fontWeight: FontWeight.w400,
  );

  static var cardBorder = Border(
    top: BorderSide(color: Color(0xffeeeeee)),
    left: BorderSide(color: Color(0xffeeeeee)),
    bottom: BorderSide(color: Color(0xffeeeeee)),
    right: BorderSide(color: Color(0xffeeeeee)),
  );
  static var containerTopCircle = BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0)
  );

  static var btnBorderRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0)
  );
  static var background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryThemeColor,primaryThemeColorgradiant]
  );

}
