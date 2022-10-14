import 'package:flutter/material.dart';
import 'package:movie_login/src/common_widget/form_footer_widget.dart';
import 'package:movie_login/src/common_widget/form_header_widget.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'login_form.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        // o resize tira o scroll
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // theme on image
                FormHeaderWidget(isDarkMode: isDarkMode, size: size, title: tLoginText, subtitle: tLoginText2,
                        image: tWelcomeImage_dark,
                        imageDark: tWelcomeImage),
                const SizedBox(height: 20),
                const LoginForm(),
                const FormFooter(buttonTitle1: tLoginText6, buttonTitle2: tLoginText7, buttonTitle3: tLoginText9)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

