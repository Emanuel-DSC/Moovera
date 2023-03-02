// ignore_for_file: file_names

import 'package:flutter/material.dart';

SnackBar mySnackBar(bool isDarkMode, Color color1, Color color2, String text) {
  return SnackBar(
    content:  Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        )),
    backgroundColor: isDarkMode ? color1 : color2,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    behavior: SnackBarBehavior.floating,
    width: 250,
    duration: const Duration(seconds: 2),
  );
}
