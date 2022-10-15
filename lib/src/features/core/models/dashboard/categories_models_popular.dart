import 'package:flutter/animation.dart';
import 'package:movie_login/src/constants/text_string.dart';

class DashBoardPopularMovies {
  final String movieTitle;
  final VoidCallback? onPress;

  DashBoardPopularMovies(this.movieTitle, this.onPress);

  static List<DashBoardPopularMovies> list = [
    DashBoardPopularMovies(tMovie9, null),
    DashBoardPopularMovies(tMovie10, null),
    DashBoardPopularMovies(tMovie11, null),
    DashBoardPopularMovies(tMovie12, null),
    DashBoardPopularMovies(tMovie13, null),
    DashBoardPopularMovies(tMovie14, null),
    DashBoardPopularMovies(tMovie15, null),
    DashBoardPopularMovies(tMovie16, null),
  ];
}
