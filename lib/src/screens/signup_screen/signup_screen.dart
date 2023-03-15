import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/screens/login_screen/login_screen.dart';
import 'package:movie_login/src/screens/signup_screen/signUp_form.dart';
import 'package:movie_login/src/widgets/form/form_footer_widget.dart';
import 'package:movie_login/src/widgets/form/form_header_widget.dart';
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
                const SignUpForm(),
                FormFooter(
                  buttonTitle1: tLoginText6,
                  buttonTitle2: tSignUpText5,
                  buttonTitle3: tLoginText8,
                  onTap: () {
                    Get.to(const LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
