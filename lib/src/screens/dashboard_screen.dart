// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/models/dashboard/categories_models_popular.dart';
import 'package:movie_login/src/models/dashboard/categories_models_top_rated.dart';
import 'package:movie_login/src/models/dashboard/categories_models_trendings.dart';
import 'package:movie_login/src/models/dashboard/categories_models_upcoming.dart';
import 'package:movie_login/src/services/api_services.dart';
import 'package:movie_login/src/widgets/categories_text.dart';
import 'package:movie_login/src/widgets/searchbar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    loadmovies(setState);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: trendingMovies.isNotEmpty &&
              topratedMovies.isNotEmpty &&
              upcomingMovies.isNotEmpty &&
              popularMovies.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: tPadding30),

                    // SEARCH BAR
                    SearchBar(isDarkMode: isDarkMode, pad: 30),
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
            )
          : Center(
              child: CircularProgressIndicator(
              color: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
            )),
    );
  }
}
