import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:movie_login/src/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/common_widget/form/form_header_widget.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';

class OTPSreen extends StatelessWidget {
  const OTPSreen({super.key});

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
                        title: tOtpText,
                        subtitle: "$tOtpText2 emanuelldsc@gmail.com",
                        image: tEmailPassword,
                        imageDark: tEmailPasswordDark)),
                const SizedBox(height: 80),
                OtpTextField(
                  numberOfFields: 6,
                  filled: true,
                  fillColor: isDarkMode ? tPrimaryColor.withOpacity(0.1) : tSecundaryDarkColor.withOpacity(0.1),
                  focusedBorderColor: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
                  disabledBorderColor: tThirdDarkColor,
                  cursorColor: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
                  margin: const EdgeInsets.only(right: 10.0),
                  fieldWidth: 45,
                  onSubmit: (code) {print("OTP IS -> $code"); } ,
                ),
                const SizedBox(height: 50),
                DegradeButton(buttonText: 'DONE', isDarkMode: isDarkMode, border: 10, screenName: 'OTPScreen'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
