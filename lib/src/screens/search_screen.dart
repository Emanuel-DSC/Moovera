import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_login/src/widgets/moviecards.dart';
import 'package:movie_login/src/widgets/search_cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List movies = [];
  List filteredMovies = [];
  bool isSearching = true;
  final _textController = TextEditingController();

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _textController,
          onChanged: (value) {
            _filterMovies(value);
            if (value.isEmpty) {
              _textController.clear();
              filteredMovies = [];
            }
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  filteredMovies = movies;
                  _textController.clear();
                });
              },
            ),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'searchHereText',
            hintStyle: const TextStyle(color: Colors.white),
          ),
          cursorWidth: 2,
          cursorColor: Colors.red.shade800,
          cursorRadius: const Radius.circular(3),
        ),
      ),
      body: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: filteredMovies.length,
            itemBuilder: (BuildContext context, int index) {
              var moviesInfo = filteredMovies[index];
              String name = moviesInfo['original_title'].toString();
              String launch = moviesInfo['release_date'].toString();
              double vote = moviesInfo['vote_average'];
              String description = moviesInfo['overview'].toString();
              String poster =
                  'https://image.tmdb.org/t/p/w500' + moviesInfo['poster_path'];
              String banner = 'https://image.tmdb.org/t/p/w500' +
                  moviesInfo['backdrop_path'];
              return SearchCards(
                  banner: banner,
                  description: description,
                  launch: launch,
                  name: name,
                  poster: poster,
                  vote: vote);
            }),
    );
  }
}
