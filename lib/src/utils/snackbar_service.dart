import 'package:flutter/material.dart';
import 'package:todoapp/src/res/colors.dart';

class SnackBarService {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
}
