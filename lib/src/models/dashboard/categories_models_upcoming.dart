import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/models/details/description.dart';
import 'package:movie_login/src/screens/favorites_screen.dart';
import 'package:movie_login/src/widgets/banners.dart';

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
        itemBuilder: ((context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Description(
                            name: upcoming[index]['title'],
                            bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                upcoming[index]['backdrop_path'],
                            posterurl: 'https://image.tmdb.org/t/p/w500' +
                                upcoming[index]['poster_path'],
                            description: upcoming[index]['overview'],
                            vote: upcoming[index]['vote_average'].toDouble(),
                            launch_on: upcoming[index]['release_date'], 
                            onTab: () { 
                              FavoritesScreen.favoritesList.add(upcoming[index]['title'].toString(),); 
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
            child: Banners(
                imageName: 'https://image.tmdb.org/t/p/w500' +
                    upcoming[index]['backdrop_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
