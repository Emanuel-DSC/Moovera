// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_banners.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_now.dart';
import 'package:movie_login/src/features/core/models/dashboard/categories_models_popular.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/banners.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/categories_text.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/gnav_bottom_bar.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/moviecards.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/searchbar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listNow = DashBoardNowMovies.list;
    final listPopular = DashBoardPopularMovies.list;
    final listBanner = DashBoardBanners.list;
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
              const SizedBox(height: tPadding20),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText2),
              const SizedBox(height: tPadding20),

              // BANNER LIST VIEW
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listBanner.length,
                  itemBuilder: ((context, index) => GestureDetector(
                      onTap: listBanner[index].onPress,
                      child: Banners(
                        imageName: listBanner[index].bannerNumber,
                        bannerText: listBanner[index].bannerTitle,
                      ))),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: tPadding20),

              // TEXT
              CategoriesText(categorieTitle: tDashboardText3),
              const SizedBox(height: tPadding20),

              // NOW LIST VIEW
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listNow.length,
                  itemBuilder: ((context, index) => GestureDetector(
                      onTap: listNow[index].onPress,
                      child: MovieCards(imageName: listNow[index].movieTitle))),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: tPadding20),
              // TEXT
              CategoriesText(categorieTitle: tDashboardText4),
              const SizedBox(height: tPadding20),

              // POPULAR LIST VIEW
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listPopular.length,
                  itemBuilder: ((context, index) => GestureDetector(
                      onTap: listPopular[index].onPress,
                      child: MovieCards(
                          imageName: listPopular[index].movieTitle))),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
