import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';

class Banners extends StatelessWidget {
  const Banners({
    Key? key,
    required this.imageName,
    required this.bannerText,
  }) : super(key: key);

  final String imageName;
  final String bannerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(imageName), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(2, 5), // Shadow position
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              bannerText,
              style: const TextStyle(
                fontSize: 16,
                color: tWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
