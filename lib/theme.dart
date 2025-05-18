import 'package:flutter/material.dart';

ThemeData light_mode = ThemeData(
  colorScheme: ColorScheme.light(
  brightness: Brightness.light  
  ),

  appBarTheme: AppBarTheme(
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.6),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black
  ),

  bottomAppBarTheme: BottomAppBarTheme(
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.6),
    color: Colors.white
  ),


  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black)
  ),

  cardTheme: CardTheme(
    color: Colors.white,
  ),

  iconTheme: IconThemeData(color: Colors.black)
);

ThemeData night_mode = ThemeData(
  colorScheme: ColorScheme.dark(
  brightness: Brightness.dark  
  ),
  
  appBarTheme: AppBarTheme(
    elevation: 2,
    shadowColor: Colors.white.withOpacity(0.5),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white
  ), 

  bottomAppBarTheme: BottomAppBarTheme(
    elevation: 2,
    shadowColor: Colors.white.withOpacity(0.6),
    color: Colors.black
  ),

  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  ),

  cardTheme: CardTheme(
    color: Colors.black87,
  ),

  iconTheme: IconThemeData(color: Colors.white)
);