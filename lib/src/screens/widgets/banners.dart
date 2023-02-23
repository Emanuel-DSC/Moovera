import 'package:flutter/material.dart';

class Banners extends StatelessWidget {
  const Banners({
    Key? key,
    required this.imageName,
  }) : super(key: key);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageName), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(2, 5), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
