// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); // To avoid creating instances

  // Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      side: const BorderSide(width: 2, color: Colors.black),
    ),
  );
  
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      side: const BorderSide(width: 2, color: Colors.white),
    ),
  );
}
