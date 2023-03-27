import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/verify_email_screen.dart';
import 'package:movie_login/src/widgets/alert_dialog.dart';

Future sendVerificationEmail(setState, context) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      //timer to resend email 
      setState(() => VerifyEmailScreenState.canResendEmail = false);
      await Future.delayed(const Duration(seconds: 20));
      setState(() => VerifyEmailScreenState.canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(
                message: 'error',
                message2: e.message.toString(),
                onTap: () {
                  Navigator.of(context).pop();
                });
          });
    }
  }

  //call after email verification
  Future checkEmailVerified(setState) async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      VerifyEmailScreenState.isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (VerifyEmailScreenState.isEmailVerified) VerifyEmailScreenState.timer?.cancel();
  }