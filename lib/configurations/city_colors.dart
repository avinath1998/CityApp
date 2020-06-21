import 'dart:ui';

import 'package:flutter/material.dart';

class CityColors {
  CityColors._();
  static const Color primary_green = Color(0xff156150);
  static const MaterialColor dark_blue = MaterialColor(
    0x1E304F,
    <int, Color>{
      50: Color(0xFFF3E5F5),
      100: Color(0xFFE1BEE7),
      200: Color(0xFFCE93D8),
      300: Color(0xFFBA68C8),
      400: Color(0xFFAB47BC),
      500: Color(0xFFAB47BC),
      600: Color(0xFF8E24AA),
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A1B9A),
      900: Color(0xFF4A148C),
    },
  );
  static const Color primary_purple = Color(0xFF34344A);
  static const Color primary_yellow = Color(0xFFF6AE2D);
  static const MaterialColor primary_teal = MaterialColor(
    0xFF00A99D,
    <int, Color>{
      50: Color(0xFFD0F1CC),
      100: Color(0xFFA3E5A3),
      200: Color(0xFF7AD88F),
      300: Color(0xFF52C989),
      400: Color(0xFF29BA8E),
      500: Color(0xFF00A99D),
      600: Color(0xFF008197),
      700: Color(0xFF005383),
      800: Color(0xFF002D6F),
      900: Color(0xFF000F5A),
    },
  );
}
