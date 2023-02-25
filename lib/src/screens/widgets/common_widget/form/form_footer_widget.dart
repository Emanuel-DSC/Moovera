import 'package:flutter/material.dart';
import 'package:movie_login/src/authentication/auth_services.dart';
import 'package:movie_login/src/constants/images.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    Key? key,
    required this.buttonTitle1,
    required this.buttonTitle2,
    required this.buttonTitle3,
    required this.onTap,
  }) : super(key: key);

  final String buttonTitle1, buttonTitle2, buttonTitle3;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: BorderSide(
                width: 2,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            icon: const Image(
              image: AssetImage(tGoogleImage),
              width: 20.0,
            ),
            label: Text(
              buttonTitle1,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            onPressed: () {
              AuthService().signInWithGoogle();
            },
          ),
        ),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: onTap,
          child: Text.rich(
            TextSpan(
              text: buttonTitle2,
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(
                  text: buttonTitle3,
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
