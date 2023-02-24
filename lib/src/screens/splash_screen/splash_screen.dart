// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/controllers/splash_screen_controllers.dart';
import 'package:movie_login/src/constants/images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of ( context ) ;
    var brightness = mediaQuery.platformBrightness ;
    final isDarkMode = brightness == Brightness.dark ;

    splashController.startAnimation();
    return Scaffold(
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 1200),
              opacity: splashController.animate.value ? 1 : 0,
              child: Positioned(
                top: 0,
                left: 0,
                child: Image(
                  width: 400,
                  height: 825,
                  fit: BoxFit.fill,
                  image: AssetImage(isDarkMode ? tSplashLauncherDark : tSplashLauncher),
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              top: splashController.animate.value ? 250 : -100,
              left: 150,
              child: Image(
                width: 100,
                height: 130,
                image: AssetImage(tSplashIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
