import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/services/verify_email_service.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/widgets/form/form_header_widget.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => VerifyEmailScreenState();
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  static bool isEmailVerified = false;
  static bool canResendEmail = false;
  static Timer? timer;

  @override
  void initState() {
    super.initState();

    // user creation
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail(setState, context);

      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified(setState));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return isEmailVerified
        ? const GnavBottomBar()
        : SafeArea(
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
                              subtitle: tOtpText2,
                              image: tEmailPassword,
                              imageDark: tEmailPasswordDark)),
                      const SizedBox(height: 80),
                      DegradeButton(
                        buttonText: 'resent email'.toUpperCase(),
                        isDarkMode: isDarkMode,
                        border: 10,
                        onTab: () {
                          canResendEmail ? sendVerificationEmail : null ;
                        },
                      ),
                      const SizedBox(height: 50),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ), 
                        child: Text('Cancel', 
                        style: TextStyle(fontSize: 24, color: isDarkMode ? tPrimaryColor : tPrimaryDarkColor)),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
