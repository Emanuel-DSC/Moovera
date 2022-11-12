// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_top_rated.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_trendings.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_popular.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_upcoming.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/categories_text.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/searchbar.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final String apikey = 'ccfcb2162afe6c935d40b19d0603d0b5';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1YiI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';
  List trendingMovies = [];
  List topratedMovies = [];
  List upcomingMovies = [];
  List popularMovies = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map pouplarResult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map upcomingResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    print((trendingResult));
    setState(() {
      trendingMovies = trendingResult['results'];
      topratedMovies = topratedResult['results'];
      upcomingMovies = upcomingResult['results'];
      popularMovies = pouplarResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: tPadding30),

              // SEARCH BAR
              SearchBar(isDarkMode: isDarkMode),
              const SizedBox(height: tPadding16),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText2),
              const SizedBox(height: tPadding16),

              // UP COMING LIST VIEW
              UpcomingList(upcoming: upcomingMovies),
              const SizedBox(height: tPadding16),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText3),
              const SizedBox(height: tPadding16),

              // TRENDING LIST VIEW
              TrendingListWidget(trending: trendingMovies),
              const SizedBox(height: tPadding16),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText4),
              const SizedBox(height: tPadding16),

              // TOP RATED 
              TopRatedListWidget(topRated: topratedMovies),
              const SizedBox(height: tPadding16),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText5),
              const SizedBox(height: tPadding16),

              // POPULAR LIST VIEW
              PopularListWidget(popular: popularMovies),

            ],
          ),
        ),
      ),
    );
  }
}
