import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

import '../forget_password/forget_password_option/forget_password_model_bottom_sheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
// text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureTextController = true;
  FocusNode textFieldFocusPassword = FocusNode();


  void _toggleObscureText() {
    setState(() {
      _obscureTextController = !_obscureTextController;
    });
  }
  // sign user in method
  void signUserIn() async {
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
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Get.to(() => const GnavBottomBar());
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
          title: Text('error'.toUpperCase(),
              style: GoogleFonts.lato(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text(message, style: GoogleFonts.lato(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('close'.toUpperCase(),
                  style: GoogleFonts.lato(color: Colors.white)),
            ),
          ],
          elevation: 10,
          backgroundColor: tThirdColor,
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
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(textFieldFocusPassword),
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: tLoginText3,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusPassword,
            obscureText: _obscureTextController,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: tLoginText4,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureTextController ? const Icon(LineAwesomeIcons.eye_slash_1)  
                : const Icon(LineAwesomeIcons.eye),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                //cria um container pop up inferior
                ForgetPasswordScreen.buildShowModalBottomSheet(context);
              },
              child: const Text(tLoginText5),
            ),
          ),
          const SizedBox(height: 10),
          DegradeButton(
            buttonText: 'SIGN IN',
            isDarkMode: isDarkMode,
            border: 10,
            onTab: () {
              signUserIn();
            },
          ),
        ],
      ),
    );
  }
}
