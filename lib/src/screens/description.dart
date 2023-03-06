// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/widgets/common_widget/button/my_elevated_button.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, launch_on;
  final double vote;
  final VoidCallback onTab;

  const Description({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch_on,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tDarkBackground : tWhiteColor,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: isDarkMode ? tDarkBackground : tWhiteColor,
          ),
          Image.network(bannerurl,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(LineAwesomeIcons.angle_left,
                      color: tWhiteColor)),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDarkMode ? tDarkBackground : tWhiteColor
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.3, 0.5],
              ),
            )),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.49,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? tWhiteColor : Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    launch_on,
                    style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? tWhiteColor : Colors.black),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: vote / 2,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 20,
                    unratedColor: tThirdDarkColor,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, index) {
                      return Icon(
                        LineAwesomeIcons.star_1,
                        color: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
                      );
                    },
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      description,
                      style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? tWhiteColor : Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyElevatedButton(
                        isDarkMode: isDarkMode,
                        icon: LineAwesomeIcons.play,
                        onTap: () {},
                      ),
                      MyElevatedButton(
                          isDarkMode: isDarkMode,
                          icon: LineAwesomeIcons.plus,
                          onTap: onTab),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
