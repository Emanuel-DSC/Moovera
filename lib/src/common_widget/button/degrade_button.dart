import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/features/authentication/screens/forget_password/forget_password_email/forget_password_mail.dart';
import 'package:movie_login/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:movie_login/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:movie_login/src/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/gnav_bottom_bar.dart';

class DegradeButton extends StatelessWidget {
  const DegradeButton({
    Key? key,
    required this.buttonText,
    required this.isDarkMode,
    required this.border,
    required this.screenName,
  }) : super(key: key);

  final bool isDarkMode;
  final String buttonText;
  final double border;
  final String screenName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(border))),
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
          callPage(screenName);
        },
        child: Text(
          buttonText,
          style: const TextStyle(
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
    );
  }
}

callPage(page) {
  if (page == 'SignUpScreen') {
    Get.to(const SignUpScreen());
  }
  if (page == 'LoginScreen') {
    Get.to(const LoginScreen());
  }
  if (page == 'ForgetPasswordMailScreen') {
    Get.to(const ForgetPasswordMailScreen());
  }
  if (page == 'OTPScreen') {
    Get.to(const OTPSreen());
  }
  if (page == 'GNAV') {
    Get.to(const GnavBottomBar());
  }
}
