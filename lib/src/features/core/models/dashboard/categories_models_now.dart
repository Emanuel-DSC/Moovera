import 'package:flutter/animation.dart';
import 'package:movie_login/src/constants/text_string.dart';

class DashBoardNowMovies {
  final String movieTitle;
  final VoidCallback? onPress;

  DashBoardNowMovies(this.movieTitle, this.onPress);

  static List<DashBoardNowMovies> list = [
    DashBoardNowMovies(tMovie1, null),
    DashBoardNowMovies(tMovie2, null),
    DashBoardNowMovies(tMovie3, null),
    DashBoardNowMovies(tMovie4, null),
    DashBoardNowMovies(tMovie5, null),
    DashBoardNowMovies(tMovie6, null),
    DashBoardNowMovies(tMovie7, null),
    DashBoardNowMovies(tMovie8, null),
  ];
}
