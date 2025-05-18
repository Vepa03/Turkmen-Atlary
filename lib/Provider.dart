import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn/theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData  _themeData = light_mode;
  ThemeData get themeData => _themeData;
  set themeData (ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == light_mode){
      themeData = night_mode;
    } else {
      themeData = light_mode;
    }
  }
}