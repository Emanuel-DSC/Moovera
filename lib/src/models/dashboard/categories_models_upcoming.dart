import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/banners.dart';
import '../../constants/colors.dart';
import '../../widgets/common_widget/my_SnackBar.dart';

class UpComingMovies extends StatelessWidget {
  final List upcoming;

  const UpComingMovies({required Key key, required this.upcoming})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UpcomingList(upcoming: upcoming);
  }
}

class UpcomingList extends StatelessWidget {
  const UpcomingList({
    Key? key,
    required this.upcoming,
  }) : super(key: key);

  final List upcoming;

  @override
  Widget build(BuildContext context) {
    return UpcomingListWidget(upcoming: upcoming);
  }
}

class UpcomingListWidget extends StatelessWidget {
  const UpcomingListWidget({
    Key? key,
    required this.upcoming,
  }) : super(key: key);

  final List upcoming;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    int count = 0;

    return SizedBox(
      height: 200,
      width: 400,
      child: ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          var kUpComing = upcoming[index];
          String title = kUpComing['title'].toString();
          String bannerUrl =
              'https://image.tmdb.org/t/p/w500' + kUpComing['backdrop_path'];
          String posterUrl =
              'https://image.tmdb.org/t/p/w500' + kUpComing['poster_path'];
          String description = kUpComing['overview'];
          double vote = kUpComing['vote_average'].toDouble();
          String launchOn = kUpComing['release_date'];

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
                              onTabAdd: () {

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
                              }, onTabDelete: () {  },
                            )));
              },
              child: Banners(imageName: bannerUrl));
        },
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
