import 'package:tmdb_api/tmdb_api.dart';

const String apikey = 'ccfcb2162afe6c935d40b19d0603d0b5';
const String readaccesstoken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1YiI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';
List trendingMovies = [];
List topratedMovies = [];
List upcomingMovies = [];
List popularMovies = [];

loadmovies(setState) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
  Map topratedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
  Map popularResult = await tmdbWithCustomLogs.v3.movies.getPopular();
  Map upcomingResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();

  setState(() {
    trendingMovies = trendingResult['results'];
    topratedMovies = topratedResult['results'];
    upcomingMovies = upcomingResult['results'];
    popularMovies = popularResult['results'];
  });
}
