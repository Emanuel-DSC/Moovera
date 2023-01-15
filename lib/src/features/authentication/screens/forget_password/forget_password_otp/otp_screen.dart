import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/common_widget/form_header_widget.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/features/authentication/controllers/otp_controller.dart';

class OTPSreen extends StatelessWidget {
  const OTPSreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    String otp;
    var otpController = Get.put(OTPController());

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
                  fillColor: isDarkMode
                      ? tPrimaryColor.withOpacity(0.1)
                      : tSecundaryDarkColor.withOpacity(0.1),
                  focusedBorderColor:
                      isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
                  disabledBorderColor: tThirdColor,
                  cursorColor: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
                  margin: const EdgeInsets.only(right: 10.0),
                  fieldWidth: 45,
                  onSubmit: (code) {
                    code.toString();
                    otp = code;
                    OTPController.instance.verifyOTP(otp);
                  },
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    gradient: LinearGradient(
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: [
                        isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                        isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      
                     // OTPController.instance.verifyOTP(otp);
                    },
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.transparent,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
