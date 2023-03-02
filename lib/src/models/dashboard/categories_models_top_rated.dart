import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/models/details/description.dart';
import 'package:movie_login/src/screens/favorites_screen.dart';
import 'package:movie_login/src/widgets/moviecards.dart';

class TopRatedMovies extends StatelessWidget {
  final List topRated;

  const TopRatedMovies({required Key key, required this.topRated})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TopRatedList(topRated: topRated);
  }
}

class TopRatedList extends StatelessWidget {
  const TopRatedList({
    Key? key,
    required this.topRated,
  }) : super(key: key);

  final List topRated;

  @override
  Widget build(BuildContext context) {
    return TopRatedListWidget(topRated: topRated);
  }
}

class TopRatedListWidget extends StatelessWidget {
  const TopRatedListWidget({
    Key? key,
    required this.topRated,
  }) : super(key: key);

  final List topRated;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: topRated.length,
                itemBuilder: ((context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => 
                      Description(
                        name: topRated[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500' + topRated[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500' + topRated[index]['poster_path'],
                        description: topRated[index]['overview'],
                        vote: topRated[index]['vote_average'].toDouble(),
                        launch_on: topRated[index]['release_date'], 
                        onTab: () {
                              FavoritesScreen.favoritesList.add(topRated[index]['title'].toString(),); 
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
                    topRated[index]['poster_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
