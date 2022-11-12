// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:movie_login/src/features/authentication/controllers/on_boarding_controlles.dart';

import 'on_boarding_page1.dart';
import 'on_boarding_page2.dart';
import 'on_boarding_page3.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final obController = OnBoardingController();

    return Scaffold(
      body: Stack(children: [
        LiquidSwipe(
            liquidController: obController.controller,
            onPageChangeCallback: obController.OnPageChangeCallback,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            enableSideReveal: true,
            pages: [
              OnBoarding1(screenWidth: screenWidth, obController: obController),
              OnBoarding2(screenWidth: screenWidth, obController: obController),
              OnBoarding3(screenWidth: screenWidth, obController: obController),
            ]),
      ]),
    );
  }
}
