import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/screens/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/on_boarding_controllers.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({
    Key? key,
    required this.screenWidth,
    required this.obController,
  }) : super(key: key);

  final double screenWidth;
  final OnBoardingController obController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(tSequence1),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 350,
          ),
          Text(tOnBoardingText1.toUpperCase(),
              style: Theme.of(context).textTheme.headline3),
          Text(tOnBoardingText11.toUpperCase(),
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(
            height: 130,
          ),
          Obx(
            () => AnimatedSmoothIndicator(
              activeIndex: obController.currentPage.value,
              count: 3,
              effect: SwapEffect(
                dotColor: Colors.grey.shade500,
                activeDotColor: Colors.white,
                dotWidth: 24.0,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            width: 190,
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                side: const BorderSide(width: 2, color: Colors.white),
              ),
              onPressed: () {
                obController.animateToNextSlide();
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              // dont let back to onBoarding
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                  (Route<dynamic> route) => false);
            },
            child: const SizedBox(
              width: 190,
              height: 50,
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
