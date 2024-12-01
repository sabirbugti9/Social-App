import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[200]!, primary:defaultColor , primaryContainer: Colors.white),
  primarySwatch: defaultColor,

  cardTheme: CardTheme(
    color: Colors.grey[700],////////
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[350],
  ),
  inputDecorationTheme:  InputDecorationTheme(

    hintStyle: TextStyle(
      color: Colors.grey[300],
      fontWeight: FontWeight.normal,
      fontSize: 15.0,
    ),
    labelStyle: TextStyle(
      color: Colors.grey[300],
    ),
    prefixIconColor: Colors.white,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),

  ),
  scaffoldBackgroundColor: HexColor('333739'),

  textTheme:  TextTheme(
    bodyMedium: const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18.0,
      color: Colors.white,
      fontFamily: 'Jannah',
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 17.0,
      color: Colors.grey[350],
    ),
      bodySmall: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 13.0,
        color: Colors.grey,
      ),
    titleMedium: const TextStyle(
     // height: 1.3,
      fontSize: 14.0,
      color: Colors.white,
      fontFamily: 'Jannah',
    ),
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 8.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme =  ThemeData(
  cardTheme: CardTheme(
    elevation: 4.0,
    color: Colors.white.withOpacity(0.8),
    surfaceTintColor: Colors.white,
  ),

  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70, primary:defaultColor , primaryContainer: Colors.white),
  primarySwatch: defaultColor,
  primaryColor: defaultColor,
  dividerTheme: DividerThemeData(
    color: Colors.grey[400],
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme:  const TextTheme(
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      //fontWeight: FontWeight.normal,
      fontSize: 13.0,
      color: Colors.grey,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18.0,
      color: Colors.black,
      fontFamily: 'Jannah',
    ),
    titleMedium: TextStyle(
      height: 1.3,
      fontSize: 14.0,
      color: Colors.black,
      fontFamily: 'Jannah',
      fontWeight: FontWeight.normal,
    ),
  ),
  inputDecorationTheme:  InputDecorationTheme(
  hintStyle: TextStyle(
    color: Colors.black87.withOpacity(0.8),
    fontWeight: FontWeight.normal,
    fontSize: 15.0,
  ),
  labelStyle: TextStyle(
    color: Colors.black87.withOpacity(0.8),
    fontWeight: FontWeight.normal,
  ),

  border: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),

),
  appBarTheme:  const AppBarTheme(
      titleSpacing: 16.0,
      titleTextStyle: TextStyle(
        fontFamily: "Jannah",
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 15.0,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah',

  //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //useMaterial3: true,
);