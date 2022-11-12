import 'package:flutter/material.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/banners.dart';

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
        itemBuilder: ((context, index) => GestureDetector(
            //onTap: tv[index].onPress,
            child: Banners(
                imageName: 'https://image.tmdb.org/t/p/w500' +
                    upcoming[index]['backdrop_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}