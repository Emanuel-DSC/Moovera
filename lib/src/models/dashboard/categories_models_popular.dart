import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/common_widget/my_SnackBar.dart';
import 'package:movie_login/src/widgets/moviecards.dart';


class PopularMovies extends StatelessWidget {
  final List popular;

  const PopularMovies({required Key key, required this.popular})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopularList(popular: popular);
  }
}

class PopularList extends StatelessWidget {
  const PopularList({
    Key? key,
    required this.popular,
  }) : super(key: key);

  final List popular;

  @override
  Widget build(BuildContext context) {
    return PopularListWidget(popular: popular);
  }
}

class PopularListWidget extends StatelessWidget {
  const PopularListWidget({
    Key? key,
    required this.popular,
  }) : super(key: key);

  final List popular;

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
        itemCount: popular.length,
        itemBuilder: (context, index) {
          var kPopular = popular[index];
          String title = kPopular['title'].toString();
          String bannerUrl =
              'https://image.tmdb.org/t/p/w500' + kPopular['backdrop_path'];
          String posterUrl =
              'https://image.tmdb.org/t/p/w500' + kPopular['poster_path'];
          String description = kPopular['overview'];
          double vote = kPopular['vote_average'].toDouble();
          String launchOn = kPopular['release_date'];
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
                                FirebaseFirestore.instance
                                    .collection("favourites")
                                    .doc(title)
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
