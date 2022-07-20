import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
      color: Colors.indigo,
      elevation: 0,
    ));
  }
}
