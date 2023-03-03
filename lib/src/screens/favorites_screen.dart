import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/description.dart';
import 'package:movie_login/src/screens/welcome_screen.dart';
import 'package:movie_login/src/widgets/favourites_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static List favoritesList = [];

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
  var mediaQuery = MediaQuery.of(context);
  var brightness = mediaQuery.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
    return Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [isDarkMode ? tPrimaryColor : tPrimaryDarkColor, 
                       isDarkMode ? tSecundaryColor: tSecundaryDarkColor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('favourites')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //checking connection state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs
                          .map((favourite) => favouritesCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WelcomeScreen(),
                                    ));
                              }, favourite, context))
                          .toList(),
                    );
                  }
                  return Text("There's no favourites",
                      style: GoogleFonts.nunito(color: Colors.white));
                }),
          ),
          // child: ListView.builder(
          //         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          //         itemCount: FavoritesScreen.favoritesList.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             tileColor: Colors.blue,
          //             title: Text(FavoritesScreen.favoritesList[index]),
          //             trailing: IconButton(
          //               onPressed: () {

          //               },
          //               icon: const Icon(
          //                 Icons.favorite,
          //                 color: Colors.red,
          //               ),
          //             ),
          //           );
          //         }
          // ),
        ),
      ),
    );
  }
}
