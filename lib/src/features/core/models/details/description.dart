// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description({Key? key,required this.name,required this.description,
  required this.bannerurl,required this.posterurl,required this.vote,
  required this.launch_on}): super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tDarkBackground : tWhiteColor,
      body: ListView(children: [
        Container(
            height: 250,
            child: Stack(children: [
              Positioned(
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    posterurl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(bottom: 10, child: Text('⭐ Average Rating - ' + vote)),
            ])),
        const SizedBox(height: 15),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              name,
            )),
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Releasing On - ' + launch_on,
            )),
        Row(
          children: [
            Container(
              height: 200,
              width: 100,
              child: Image.network(posterurl),
            ),
            Flexible(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    description,
                  )),
            ),
          ],
        )
      ]),
    );
  }
}
