import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/on_boarding_controlles.dart';
import '../welcome_screen.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({
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
          image: AssetImage(tSequence3),
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
          Text(tOnBoardingText3.toUpperCase(),
              style: Theme.of(context).textTheme.headline3),
          Text(tOnBoardingText33.toUpperCase(),
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
          Container(
            width: 190,
            height: 50,
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28))),
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.shade200,
                  Colors.orangeAccent.shade700,
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () async {
                // dont let back to onBoarding
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                'GET STARTED',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.transparent,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
