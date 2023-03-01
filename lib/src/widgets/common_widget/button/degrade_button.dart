import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';

class DegradeButton extends StatelessWidget {
  const DegradeButton({
    Key? key,
    required this.buttonText,
    required this.isDarkMode,
    required this.border,
    required this.onTab,
  }) : super(key: key);

  final bool isDarkMode;
  final String buttonText;
  final double border;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(border))),
        gradient: LinearGradient(
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
            isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onTab,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: Colors.transparent,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
}

