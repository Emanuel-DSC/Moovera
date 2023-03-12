import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';
import '../screens/description.dart';
import 'common_widget/my_SnackBar.dart';

Widget favouritesCard(QueryDocumentSnapshot doc, context) {
  var mediaQuery = MediaQuery.of(context);
  var brightness = mediaQuery.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
        // go to favourite clicked movie
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Description(
                  bannerurl: doc['movie_banner'],
                  description: doc['movie_description'],
                  launch_on: doc['movie_launch'],
                  name: doc['movie_title'],
                  posterurl: doc['movie_poster'],
                  vote: doc['movie_vote'],
                  onTabAdd: () {
                    var snackBar = mySnackBar(isDarkMode, tPrimaryColor,
                        tPrimaryDarkColor, 'ALREADY ON FAVORITES');
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, onTabDelete: () {  },
                ),
              ));
        },
        // favourite card design
        child: Row(
          children: [
            Container(
              height: 182,
              width: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                child: Image.network(doc['movie_poster'], fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.red.shade900,
                      backgroundColor: Colors.grey.shade600,
                    ));
                  }
                }),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 182,
                width: 215,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc['movie_title'],
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: tPadding10),
                      RatingBar.builder(
                        initialRating: doc['movie_vote'] / 2,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 25,
                        unratedColor: Colors.grey.withOpacity(0.3),
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, index) {
                          return Icon(
                            LineAwesomeIcons.star_1,
                            color: isDarkMode
                                ? tPrimaryColor
                                : tSecundaryDarkColor,
                          );
                        },
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(height: tPadding10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(doc['movie_launch'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          GestureDetector(
                              onTap: () {
                                //remove movie from Firebase and consequently from favourites list
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('favourites')
                                    .doc(doc['movie_title'])
                                    .delete();
                              },
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
  );
}
