import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_login/src/constants/colors.dart';
import 'dart:convert';
import 'package:movie_login/src/widgets/cards/search_cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List movies = [];
  List filteredMovies = [];
  final _textController = TextEditingController();
  bool _searchIconController = true;
  FocusNode textFieldFocus = FocusNode();

  getMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=ccfcb2162afe6c935d40b19d0603d0b5&language=en-US&page=1'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["results"];
    return data;
  }

  @override
  void initState() {
    getMovies().then((data) {
      setState(() {
        movies = filteredMovies = data;
      });
    });
    super.initState();    

    //focus on searchbar after layout is built
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FocusScope.of(context).requestFocus(textFieldFocus));
  }

  void _filterMovies(value) {
    setState(() {
      filteredMovies = movies
          .where((movie) => movie['original_title']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              isDarkMode ? favouritesBgDarkColor : favouritesBgLightColor,
              isDarkMode ? Colors.black : favouritesBgDarkColor
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.grey,
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          focusNode: textFieldFocus,
                          controller: _textController,
                          onChanged: (value) {
                            _filterMovies(value);
                            _searchIconController = true;
                            if (value.isEmpty) {
                              _textController.clear();
                              filteredMovies = movies;
                              _searchIconController = false;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: isDarkMode
                                ? tBottomDarkColor.withOpacity(0.5)
                                : tThirdDarkColor,
                          ),
                          cursorWidth: 3,
                          cursorColor:
                              isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                          cursorRadius: const Radius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // if contains text, icon = X , else = search
                      _searchIconController
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  filteredMovies = movies;
                                  _textController.clear();
                                  _searchIconController = false;
                                });
                              },
                              child: const Icon(
                                Icons.clear_rounded,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400, childAspectRatio: 5 / 3),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: filteredMovies.length,
                      itemBuilder: (BuildContext context, int index) {
                        var moviesInfo = filteredMovies[index];
                        String name = moviesInfo['original_title'].toString();
                        String launch = moviesInfo['release_date'].toString();
                        var vote = moviesInfo['vote_average'];
                        String description = moviesInfo['overview'].toString();
                        String poster = 'https://image.tmdb.org/t/p/w500' +
                            moviesInfo['poster_path'];
                        String banner = 'https://image.tmdb.org/t/p/w500' +
                            moviesInfo['backdrop_path'];

                        return SearchCards(
                            banner: banner,
                            description: description,
                            launch: launch,
                            name: name,
                            poster: poster,
                            vote: vote);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
