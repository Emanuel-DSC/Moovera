// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/features/authentication/screens/login_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
        children: [
          // ignore: prefer_const_constructors
          SizedBox(height: 50),
          // ignore: sized_box_for_whitespace
          Container(
            width: 200,
            height: 200,
            child: Image(image: AssetImage(tWelcomeImage_dark),
                      height: height * 0.6)),

          Text(tWelcomeText, style: Theme.of(context).textTheme.headline2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DegradeButton(
                      buttonText: 'SIGN UP',
                      isDarkMode: isDarkMode,
                      border: 32,
                      screenName: 'SignUpScreen'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
