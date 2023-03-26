import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/screens/forget_password/forget_password_email/forget_password_mail.dart';
import 'package:movie_login/src/screens/login_screen/login_screen.dart';
import 'package:movie_login/src/widgets/alert_dialog.dart';

Future passwordReset(context) async {
  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: ForgetPasswordMailScreenState.emailController.text.trim());
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              message: tEmailSent2,
              message2: tEmailSent,
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => const LoginScreen());
              });
        });
  } on FirebaseAuthException catch (e) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              message: 'error',
              message2: e.message.toString(),
              onTap: () => Navigator.of(context).pop());
        });
  }
}
