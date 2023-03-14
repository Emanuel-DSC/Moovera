import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/cards/movie_cards.dart';

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
                              
                            )));
              },
              child: MovieCards(imageName: posterUrl));
        },
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
