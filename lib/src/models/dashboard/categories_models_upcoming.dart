import 'package:flutter/material.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/widgets/cards/banners_cards.dart';

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
    return SizedBox(
      height: 200,
      width: 400,
      child: ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          var kUpComing = upcoming[index];
          String? title , bannerUrl, posterUrl, description, launchOn ;
           title = kUpComing['title'].toString();
           bannerUrl =
              'https://image.tmdb.org/t/p/w500' + kUpComing['backdrop_path'];
           posterUrl =
              'https://image.tmdb.org/t/p/w500' + kUpComing['poster_path'];
           description = kUpComing['overview'];
          double vote = kUpComing['vote_average'].toDouble();
           launchOn = kUpComing['release_date'];

          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Description(
                              name: title ?? 'failed to load movie title'.toUpperCase(),
                              bannerurl: bannerUrl ?? 'failed to load movie cover',
                              posterurl: posterUrl ?? 'failed to load movie cover' ,
                              description: description ?? 'failed to load movie description',
                              vote: vote,
                              launch_on: launchOn ?? 'failed to load',
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
