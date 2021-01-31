import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    accentColor: _accentColor,
    textSelectionTheme: TextSelectionThemeData(cursorColor: _accentColor));

Color _accentColor = Color(0xfff7892b);
