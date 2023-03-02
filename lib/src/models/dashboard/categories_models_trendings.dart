import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/models/details/description.dart';
import 'package:movie_login/src/screens/favorites_screen.dart';
import 'package:movie_login/src/widgets/moviecards.dart';

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
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: trending.length,
                       itemBuilder: ((context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => 
                      Description(
                        name: trending[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500' + trending[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500' + trending[index]['poster_path'],
                        description: trending[index]['overview'],
                        vote: trending[index]['vote_average'].toDouble(),
                        launch_on: trending[index]['release_date'],
                        onTab: () { 
                              FavoritesScreen.favoritesList.add(trending[index]['title'].toString(),); 
                              var snackBar = SnackBar(
                                content: 
                                const Text('ADDED TO LIST', 
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: tWhiteColor, 
                                      fontSize: 16, )),
                                backgroundColor: isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              },
                        )));
            },
            child: MovieCards(
                imageName: 'https://image.tmdb.org/t/p/w500' +
                    trending[index]['poster_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}