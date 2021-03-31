import 'package:flutter/material.dart';

const skinOrange = Color(0xFFFFC677);
const lightBlue = Color(0xFF77DDFF);
const greyishWhite = Color(0xFFEAECFF);
const dark = Color(0xFF2D2F41);
const lightpurpleBlue = Color(0xFF748EF6);
const greybrown = Color(0xFF707070);
const darkBlue = Color(0xFF444974);
const googleBanner = Color(0xffdb3236);
const blue = Color(0xff3b5998);
const facebookBlue = Color(0xff3b5998);

const Duration animationDuration = Duration(milliseconds: 400);

const kappTextStyle = TextStyle(
  fontFamily: 'VarelaRound',
  fontWeight: FontWeight.bold,
  letterSpacing: 1.1,
);

final kdarkthemeData = ThemeData(
  scaffoldBackgroundColor: dark,
  iconTheme: IconThemeData(color: greyishWhite),
  appBarTheme: AppBarTheme(
      backgroundColor: dark,
      elevation: 0.0,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: dark,
      )),
  accentColor: greyishWhite,
  primaryColorLight: blue,
  primaryColor: dark,
  primarySwatch: Colors.blue,
);

final klightThemeData = kdarkthemeData.copyWith(
  scaffoldBackgroundColor: greyishWhite,
  iconTheme: IconThemeData(color: dark),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: greyishWhite,
    iconTheme: IconThemeData(color: greyishWhite),
  ),
  accentColor: dark,
  primaryColor: greyishWhite,
  primaryColorLight: darkBlue,
);
