import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.isDarkMode,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final bool isDarkMode;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
        onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? tPrimaryColor : tSecundaryDarkColor,
        elevation: 5,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          gradient: LinearGradient(
            colors: [
              isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
              isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
            ],
          ),
        ),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          child: Icon(icon),
        ),
      ),
    );
  }
}
