import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';

import '../../widgets/moviecards.dart';

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
    return SizedBox(
      height: 200,
      width: 400,
      child: ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {

          var kUpComing = upcoming[index];
          String title = kUpComing['title'].toString();
          String banner = 'https://image.tmdb.org/t/p/w500' + kUpComing['backdrop_path'];
          String posterurl = 'https://image.tmdb.org/t/p/w500' + kUpComing['poster_path'];
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
                              bannerurl: banner,
                              posterurl: posterurl,
                              description: description,
                              vote: vote,
                              launch_on: launchOn,
                              onTab: () {
                                FirebaseFirestore.instance
                                    .collection("favourites")
                                    .add({
                                  "movie_title": title,
                                  "movie_banner": banner,
                                  "movie_description": description,
                                  "movie_launch": launchOn,
                                  "movie_vote": vote,
                                  "movie_poster": posterurl,
                                });
                                // if (FavoritesScreen.favoritesList
                                //     .contains(title)) {
                                //   var snackBar = mySnackBar(
                                //       isDarkMode,
                                //       tPrimaryColor,
                                //       tPrimaryDarkColor,
                                //       'ALREADY ON FAVORITES');
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(snackBar);
                                // } else {
                                //   FavoritesScreen.favoritesList.add(
                                //     title,
                                //   );
                                //   var snackBar = mySnackBar(
                                //       isDarkMode,
                                //       tSecundaryColor,
                                //       tSecundaryDarkColor,
                                //       'ADDED TO FAVORITES');
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(snackBar);
                                // }
                              },
                            )));
              },
              child: MovieCards(
                  imageName: 'https://image.tmdb.org/t/p/w500' +
                      upcoming[index]['poster_path']));
        },
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
