import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/models/details/description.dart';
import 'package:movie_login/src/screens/favorites_screen.dart';
import 'package:movie_login/src/widgets/moviecards.dart';

import '../../widgets/common_widget/my_SnackBar.dart';

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
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: popular.length,
        itemBuilder: ((context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Description(
                            name: popular[index]['title'],
                            bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                popular[index]['backdrop_path'],
                            posterurl: 'https://image.tmdb.org/t/p/w500' +
                                popular[index]['poster_path'],
                            description: popular[index]['overview'],
                            vote: popular[index]['vote_average'].toDouble(),
                            launch_on: popular[index]['release_date'],
                            onTab: () {
                              if (FavoritesScreen.favoritesList.contains(popular[index]['title'])) {
                                var snackBar = mySnackBar(isDarkMode, tPrimaryColor, tPrimaryDarkColor, 'ALREADY ON FAVORITES');
                                ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              }
                              else{
                                FavoritesScreen.favoritesList.add(
                                popular[index]['title'].toString(),
                              );
                                var snackBar = mySnackBar(isDarkMode, tSecundaryColor, tSecundaryDarkColor, 'ADDED TO FAVORITES');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              }                           
                            },
                          )));
            },
            child: MovieCards(
                imageName: 'https://image.tmdb.org/t/p/w500' +
                    popular[index]['poster_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  
}
