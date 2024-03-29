// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/firebase_options.dart';
import 'package:movie_login/src/services/auth_services.dart';
import 'package:movie_login/src/screens/error_screen.dart';
import 'package:movie_login/src/screens/verify_email_screen.dart';
import 'package:movie_login/src/screens/on_boarding/on_boarding_screen.dart';
import 'package:movie_login/src/constants/theme/theme.dart';

void main() async {

  //firebase init
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  //error page
  ErrorWidget.builder = (FlutterErrorDetails details ) {
    return ErrorScreen();
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,

      // if user loged in -> Movies Screen else -> OnBoarding
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return VerifyEmailScreen();
          } else {
            return OnBoardingScreen();
          }
        }
      ), 
    );//dashboard
  }
}
