import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/widgets/alert_dialog.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/widgets/form/form_header_widget.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // user creation
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      //timer to resend email 
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 20));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(
                message: 'error',
                message2: e.message.toString(),
                onTap: () {
                  Navigator.of(context).pop();
                });
          });
    }
  }

  //call after email verification
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
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
