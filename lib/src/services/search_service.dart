import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/search_screen.dart';

getMovies() async {

    //TMDB API DOESNT HAVE A LINK TO EVERY MOVIE SO I WILL CALL POPULAR ONLY 
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=ccfcb2162afe6c935d40b19d0603d0b5&language=en-US&page=1'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["results"];
    return data;
  }

  void filterMovies(value, setState) {
    setState(() {
      SearchScreenState.filteredMovies = SearchScreenState.movies
          .where((movie) => movie['original_title']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }