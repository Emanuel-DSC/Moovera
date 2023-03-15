// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
// text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  FocusNode textFieldFocusPassword = FocusNode();
  FocusNode textFieldFocusConfirmPassword = FocusNode();

  // sign user up method
  void signUserUp() async {
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
    if (passwordController.text != passwordConfirmController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match");
      return;
    }
    // try sign Up
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // create user in Users collection Firebase
      var user = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user)
          .set({'ID': emailController.text});
      // get to movies screen
      Get.to(const GnavBottomBar());
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // error message
  void showErrorMessage(String message) {
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

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextFormField(
            // onFieldSumbitted go to password text field
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textFieldFocusPassword),

            controller: emailController,
            decoration: const InputDecoration(
              label: Text(tLoginText3),
              prefixIcon: Icon(Icons.mail_outline_rounded),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusPassword,
            // onFieldSumbitted go to confirm password text field
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(textFieldFocusConfirmPassword),
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              label: Text(tLoginText4),
              prefixIcon: Icon(Icons.fingerprint),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusConfirmPassword,
            controller: passwordConfirmController,
            obscureText: true,
            decoration: const InputDecoration(
              label: Text(tLoginText44),
              prefixIcon: Icon(Icons.fingerprint),
            ),
          ),
          const SizedBox(height: 10),
          DegradeButton(
            buttonText: 'SIGN UP',
            isDarkMode: isDarkMode,
            border: 10,
            onTab: () {
              signUserUp();
            },
          ),
        ],
      ),
    );
  }
}
