

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Color primarySwatch=Colors.lightBlue;

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ),

    ),
    fontFamily: "jannah",
  primarySwatch:Colors.lightBlue ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.lightBlue,
    elevation: 10.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 24.0,color: Colors.black,fontWeight: FontWeight.bold
      ),
      bodyText2: TextStyle(
          fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold
      ),
  ),

);

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black26,
    appBarTheme: const AppBarTheme(
      color: Colors.black26,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.light,
      ),

    ),
    fontFamily: "jannah",
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.lightBlue,
    elevation: 10.0,
    backgroundColor: Colors.black26,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 24.0,color: Colors.white,fontWeight: FontWeight.bold
    ),
    bodyText2: TextStyle(
        fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold
    ),
  ),
);
