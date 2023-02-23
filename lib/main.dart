// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/firebase_options.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';
import 'package:movie_login/src/utils/theme/theme.dart';

import 'src/screens/on_boarding/on_boarding_screen.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.amberAccent.shade400,
            )),
      ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 150),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(error)),
                  SizedBox(height: 10),
                  Text('SOMETHING WENT WRONG'), 
                  SizedBox(height: 10),
                  Text("We couldn't load this file", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)), 
                ],
              ),
            ),
          ),
        ),
      );
  RenderErrorBox.backgroundColor = Colors.transparent;
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: OnBoardingScreen(),
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}