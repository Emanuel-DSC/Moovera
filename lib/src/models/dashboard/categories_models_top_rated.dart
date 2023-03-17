import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/cards/movie_cards.dart';


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
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        itemCount: topRated.length,
        itemBuilder: (context, index) {

          var kTopRated = topRated[index];
          String? title , posterUrl, description, launchOn ;

          title = kTopRated['title'];
           posterUrl =
              'https://image.tmdb.org/t/p/w500' + kTopRated['poster_path'];
           description = kTopRated['overview'];
          double vote = kTopRated['vote_average'].toDouble();
           launchOn = kTopRated['release_date'];

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
              child: MovieCards(
                  imageName: posterUrl));
        },
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
