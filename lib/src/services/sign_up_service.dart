// sign user up method
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/signup_screen/signUp_form.dart';
import 'package:movie_login/src/screens/verify_email_screen.dart';

void signUserUp(context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // check if passwords are the same
    if (SignUpFormState.passwordController.text != SignUpFormState.passwordConfirmController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match", context);
      return;
    }
    // try sign Up
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: SignUpFormState.emailController.text, password: SignUpFormState.passwordController.text.trim());

      // create user in Users collection Firebase
      var user = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user)
          .set({'Email': SignUpFormState.emailController.text.trim(), 
          'ProfilePicture': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'});
      // get to movies screen
      Get.to(const VerifyEmailScreen());
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code, context);
    }
  }

  // error message
  void showErrorMessage(String message, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: tThirdColor,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }