// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/authentication/firebase_options.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';
import 'package:movie_login/src/screens/error_screen.dart';
import 'package:movie_login/src/screens/on_boarding/on_boarding_screen.dart';
import 'package:movie_login/src/utils/theme/theme.dart';

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
      home: OnBoardingScreen(), //dashboard
    );
  }
}
