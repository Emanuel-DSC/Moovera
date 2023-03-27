

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/login_screen/login_form.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/gnav_bottom_bar.dart';

 
// sign user in method
  void signUserIn(context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: LoginFormState.emailController.text,
        password: LoginFormState.passwordController.text,
      );
      // pop the loading circle
      Get.to(() => const GnavBottomBar());
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code, context);
    }
  }

  // error message
  void showErrorMessage(String text, context) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(message: 'error', message2: text, 
        onTap: () => Navigator.of(context).pop());
      },
    );
  }