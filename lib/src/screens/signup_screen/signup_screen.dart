import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/common_widget/form/form_footer_widget.dart';
import 'package:movie_login/src/common_widget/form/form_header_widget.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';

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
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // theme on image
                  FormHeaderWidget(
                      isDarkMode: isDarkMode,
                      size: size,
                      title: tSignUpText,
                      subtitle: tSignUpText2,
                        image: tWelcomeImage_dark,
                        imageDark: tWelcomeImage),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(tSignUpText3),
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(tLoginText3),
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(tSignUpText4),
                      prefixIcon: Icon(Icons.phone_android_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(tLoginText4),
                      prefixIcon: Icon(Icons.fingerprint),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DegradeButton(
                      isDarkMode: isDarkMode,
                      buttonText: 'SIGN UP',
                      border: 8, onTab: () { Get.to(const SignUpScreen()); },
                      ),
                  const FormFooter(
                      buttonTitle1: tLoginText6,
                      buttonTitle2: tSignUpText5,
                      buttonTitle3: tLoginText8)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
