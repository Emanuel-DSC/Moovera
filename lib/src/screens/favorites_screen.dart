import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static List favoritesList = [];

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // List heroes = [];
  // List filteredHeroes = [];
  // bool isSearching = true;
  // final _textController = TextEditingController();

  // getHeroes() async {
  //   var response =
  //       await Dio().get('https://api.themoviedb.org/3/movie/popular?api_key=ccfcb2162afe6c935d40b19d0603d0b5&language=en-US&page=1');
  //   return response.data;
  // }

  // @override
  // void initState() {
  //   getHeroes().then((data) {
  //     setState(() {
  //       heroes = filteredHeroes = data;
  //     });
  //   });
  //   super.initState();
  // }

  // void _filterHeroes(value) {
  //   setState(() {
  //     filteredHeroes = heroes
  //         .where((hero) =>
  //             hero['name'].toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tThirdColor,
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
        // title: TextField(
        //   // controller: _textController,
        //   onChanged: (value) {
        //     // _filterHeroes(value);
        //     if (value.isEmpty) {
        //       _textController.clear();
        //       filteredHeroes = [];
        //     }
        //   },
        //   style: const TextStyle(color: Colors.white),
        //   decoration: InputDecoration(
        //     suffixIcon: IconButton(
        //       icon: const Icon(
        //         Icons.clear_rounded,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           print(filteredHeroes);
        //           //filteredHeroes = [];
        //           _textController.clear();
        //         });
        //       },
        //     ),
        //     border: const OutlineInputBorder(borderSide: BorderSide.none),
        //     hintText: 'searchHereText',
        //     hintStyle: const TextStyle(color: Colors.white),
        //   ),
        //   cursorWidth: 2,
        //   cursorColor: Colors.red.shade800,
        //   cursorRadius: const Radius.circular(3),
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: FavoritesScreen.favoritesList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                tileColor: Colors.red,
                title: Text(FavoritesScreen.favoritesList[index]),
              );
            }),
      ),
    );
  }
}

// TextField(
//               controller: TextEditingController(),
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isDarkMode ? tWhiteColor : tThirdColor,
//               ),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: isDarkMode ? tBottomDarkColor : tThirdDarkColor,
//                 border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                     borderSide: BorderSide.none),
//                 hintText: tDashboardText,
//                 suffixIcon: GestureDetector(
//                     onTap: () {}, child: const Icon(CustomIcon.search)),
//                 suffixIconColor: isDarkMode ? tThirdColor : tWhiteColor,
//               ),
//             ),