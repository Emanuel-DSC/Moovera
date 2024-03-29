import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/widgets/cards/favourites_cards.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

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
          body: Container(
            padding: const EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
                stream:    
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
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
                          .map(
                              (favourite) => favouritesCard(favourite, context))
                          .toList(),
                    );
                  }
                  return Center(
                    child: Text("There's no favourites",
                        style: GoogleFonts.nunito(color: Colors.white)),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
