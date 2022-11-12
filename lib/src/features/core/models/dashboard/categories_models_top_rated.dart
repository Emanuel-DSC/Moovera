import 'package:flutter/material.dart';
import '../../screens/dashboard/widgets/moviecards.dart';

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
        itemBuilder: ((context, index) => GestureDetector(
            //onTap: tv[index].onPress,
            child: MovieCards(
                imageName: 'https://image.tmdb.org/t/p/w500' +
                topRated[index]['poster_path']))),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
