import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';

// ignore: must_be_immutable
class AnimatedLikeButton extends StatefulWidget {
  final String name, description, bannerurl, posterurl, launch;
  final double vote;
  const AnimatedLikeButton({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch,
  }) : super(key: key);

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();

  // like button function
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // remove movie from firestore
    if (isLiked == true) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('favourites')
          .doc(name)
          .delete();

      // add movie to firestore

    } else {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('favourites')
          .doc(name)
          .set({
        "movie_title": name,
        "movie_banner": bannerurl,
        "movie_description": description,
        "movie_launch": launch,
        "movie_vote": vote,
        "movie_poster": posterurl,
      });
    }

    return !isLiked;
  }
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Container(
      width: 140,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        gradient: LinearGradient(
          colors: [
            isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
            isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
          ],
        ),
      ),
      child: LikeButton(
        onTap: widget.onLikeButtonTapped,
        size: 50,
        likeBuilder: (isLiked) {
          return isLiked
              ? const Icon(
                  LineAwesomeIcons.heart_1,
                  color: Colors.red,
                )
              : const Icon(LineAwesomeIcons.heart, color: Colors.white);
        },
        bubblesColor: BubblesColor(
            dotPrimaryColor: Colors.red.shade400,
            dotSecondaryColor: Colors.red.shade500,
            dotThirdColor: Colors.red.shade600,
            dotLastColor: Colors.red.shade900),
      ),
    );
  }
}
