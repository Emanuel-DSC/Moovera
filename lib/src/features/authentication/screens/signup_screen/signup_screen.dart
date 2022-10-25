import 'package:flutter/material.dart';

import 'widgets/signupform.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SignUpFormWidget(isDarkMode: isDarkMode, size: size,),
        ),
      ),
    );
  }
}

