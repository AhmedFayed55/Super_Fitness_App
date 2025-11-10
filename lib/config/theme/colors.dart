import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0B0B0B);
  static const Color red = Color(0xFFFF0000);
  static const Color cmykColor = Color(0xFF242424);
  static const Color blurOverlay = Color(0x40000000);
  static const Color glassBackground = Color(0x1A000000);
  static const Color cmykColor = Color(0xFF242424);

  static const MaterialColor grey = MaterialColor(0xFF0C1015, <int, Color>{
    10: Color(0xFF242424),
    20: Color(0xFF3A3A3A),
    30: Color(0xFF505050),
    40: Color(0xFF666666),
    50: Color(0xFF7C7C7C),
    60: Color(0xFF919191),
    70: Color(0xFFA7A7A7),
    80: Color(0xFFBDBDBD),
    90: Color(0xFFD3D3D3),
    100: Color(0xFFE9E9E9),
  });

  static const MaterialColor lightOrange =
      MaterialColor(0xFF0C1015, <int, Color>{
        10: Color(0xFFFF4100),
        20: Color(0xFFFF541A),
        30: Color(0xFFFF6733),
        40: Color(0xFFFF7A4D),
        50: Color(0xFFFF8D66),
        60: Color(0xFFFFA080),
        70: Color(0xFFFFB399),
        80: Color(0xFFFFC6B2),
        90: Color(0xFFFFD9CC),
        100: Color(0xFFFFECE5),
      });

  static const MaterialColor darkOrange =
      MaterialColor(0xFF0C1015, <int, Color>{
        10: Color(0xFFFF4100),
        20: Color(0xFFE52800),
        30: Color(0xFFCC0E00),
        40: Color(0xFFB20000),
        50: Color(0xFF990000),
        60: Color(0xFF800000),
        70: Color(0xFF660000),
        80: Color(0xFF4D0000),
        90: Color(0xFF330000),
        100: Color(0xFF1A0000),
      });
}
