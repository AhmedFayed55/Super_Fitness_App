import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(super.hex);

  factory HexColor.fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return HexColor(int.parse(buffer.toString(), radix: 16));
  }
}
