import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/cards/movie_cards.dart';

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
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: trending.length,
        itemBuilder: (context, index) {
          var kTrending = trending[index];
          String? title , posterUrl, description, launchOn ;
          
          title = kTrending['title'];
          posterUrl = 'https://image.tmdb.org/t/p/w500' + kTrending['poster_path'];
          description = kTrending['overview'];
          double vote = kTrending['vote_average'].toDouble();
          launchOn = kTrending['release_date'];

          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Description(
                              name: title ?? 'failed to load movie title'.toUpperCase(),
                              bannerurl: posterUrl ?? 'failed to load movie cover',
                              posterurl: posterUrl ?? 'failed to load movie cover' ,
                              description: description ?? 'failed to load movie description',
                              vote: vote,
                              launch_on: launchOn ?? 'failed to load',
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
