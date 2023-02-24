import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/common_widget/form/form_header_widget.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/screens/forget_password/forget_password_otp/otp_screen.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

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
              children: [
                const SizedBox(height: 120),
                Center(
                    child: FormHeaderWidget(
                        isDarkMode: isDarkMode,
                        size: size,
                        title: tForgetPasswordText6,
                        subtitle: tForgetPasswordText7,
                        image: tWelcomeImage_dark,
                        imageDark: tWelcomeImage)),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: tLoginText3,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
              DegradeButton(
              buttonText: 'NEXT',
              isDarkMode: isDarkMode,
              border: 8, onTab: () { Get.to(const OTPSreen()); },
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
