import 'package:flutter/material.dart';
import 'package:housepital/src/constants/colors.dart';


ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: secondaryColor,
    primaryColor: secondaryColor,
    textTheme: buildAppTextTheme(base.textTheme),
    primaryTextTheme: buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: buildAppTextTheme(base.accentTextTheme),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
    iconTheme: buildAppIconTheme(base.iconTheme),
    primaryIconTheme: base.iconTheme.copyWith(
      color: Colors.black
    ),
    accentIconTheme: base.iconTheme.copyWith(
      color: primaryDarkColor
    ),
    scaffoldBackgroundColor: white100,
    cardColor: Colors.white,
    textSelectionColor: secondaryDarkColor,
    errorColor: Colors.red,
  );
}

TextTheme buildAppTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500
    ),
    title: base.title.copyWith(
      fontWeight: FontWeight.w300
    ),
  ).apply(
    fontFamily: 'Ubuntu',
    displayColor: Colors.black,
    bodyColor: Colors.black,
  );
}

IconThemeData buildAppIconTheme(IconThemeData base) {
  return base.copyWith(
    color: Colors.black
  );
}