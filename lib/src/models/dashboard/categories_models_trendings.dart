import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/moviecards.dart';

import '../../widgets/common_widget/my_SnackBar.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({required Key key, required this.trending})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TrendingList(trending: trending);
  }
}

class TrendingList extends StatelessWidget {
  const TrendingList({
    Key? key,
    required this.trending,
  }) : super(key: key);

  final List trending;

  @override
  Widget build(BuildContext context) {
    return TrendingListWidget(trending: trending);
  }
}

class TrendingListWidget extends StatelessWidget {
  const TrendingListWidget({
    Key? key,
    required this.trending,
  }) : super(key: key);

  final List trending;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    int count = 0;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: trending.length,
        itemBuilder: (context, index) {

          var kTrending = trending[index];
          String title = kTrending['title'].toString();
          String bannerUrl =
              'https://image.tmdb.org/t/p/w500' + kTrending['backdrop_path'];
          String posterUrl =
              'https://image.tmdb.org/t/p/w500' + kTrending['poster_path'];
          String description = kTrending['overview'];
          double vote = kTrending['vote_average'].toDouble();
          String launchOn = kTrending['release_date'];

          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Description(
                              name: title,
                              bannerurl: bannerUrl,
                              posterurl: posterUrl,
                              description: description,
                              vote: vote,
                              launch_on: launchOn,
                              onTab: () {
                                count += 1;

                                //add movie name to a key in firebase so it
                                // wont duplicate 
                                // add movie inside favourites collection, inside
                                // user collection so every user has his own list
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('favourites').doc(title)
                                    .set({
                                  "movie_title": title,
                                  "movie_banner": bannerUrl,
                                  "movie_description": description,
                                  "movie_launch": launchOn,
                                  "movie_vote": vote,
                                  "movie_poster": posterUrl,
                                });
                                
                                if (count >= 2) {
                                  var snackBar = mySnackBar(
                                      isDarkMode,
                                      tPrimaryColor,
                                      tPrimaryDarkColor,
                                      'ALREADY ON FAVORITES');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  var snackBar = mySnackBar(
                                      isDarkMode,
                                      tSecundaryColor,
                                      tSecundaryDarkColor,
                                      'ADDED TO FAVORITES');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                            )));
              },
              child: MovieCards(
                  imageName: posterUrl));
        },
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
