import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';

class HatzolahTheme {
  static mainTheme(BuildContext buildContext){
    return ThemeData(
      primaryColor: primaryColour,
      errorColor: secondaryColour,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColour,
      )
    );
  }
}