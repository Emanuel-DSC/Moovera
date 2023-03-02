import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';

Widget favouritesCard(Function()? onTap, QueryDocumentSnapshot doc , context) {
  var mediaQuery = MediaQuery.of(context);
  var brightness = mediaQuery.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.amber
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(doc['movie_title'], 
            style: const TextStyle(fontSize: 32)), 
            const SizedBox(height: tPadding10),
            RatingBar.builder(
                      initialRating: doc['movie_vote'] / 2,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 25,
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
            const SizedBox(height: tPadding10),
            Text(doc['movie_launch'], 
            style: const TextStyle(fontSize: 18)), 
        ]),
      ),
    ),
  );
}
