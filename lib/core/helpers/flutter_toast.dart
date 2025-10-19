import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/theme/colors.dart';

abstract class ToastMessage {
  static Future<bool?> toastMsg(
    String msg, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.green,
      textColor: textColor ?? AppColors.white,
      fontSize: 20,
    );
  }
}
