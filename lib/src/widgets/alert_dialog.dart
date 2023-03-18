import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

// ignore: must_be_immutable
class MyAlertDialog extends StatelessWidget {
  String message;
  String message2;
  VoidCallback onTap; 

  MyAlertDialog({
    Key? key,
    required this.message,
    required this.onTap,
    required this.message2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message.toUpperCase(),
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold)),
      content: Text(message2, style: GoogleFonts.lato(color: Colors.white)),
      actions: [
        TextButton(
          onPressed: onTap,
          child: Text('close'.toUpperCase(),
              style: GoogleFonts.lato(color: Colors.white)),
        ),
      ],
      elevation: 10,
      backgroundColor: tThirdColor,
    );
  }
}
