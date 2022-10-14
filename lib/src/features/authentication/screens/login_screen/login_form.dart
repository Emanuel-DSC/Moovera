import 'package:flutter/material.dart';
import 'package:movie_login/src/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/constants/text_string.dart';

import '../forget_password/forget_password_option/forget_password_model_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: tLoginText3,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.fingerprint),
              labelText: tLoginText4,
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: null,
                icon: Icon(Icons.remove_red_eye_outlined),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                //cria um container pop up inferior
                ForgetPasswordScreen.buildShowModalBottomSheet(context);
              },
              child: const Text(tLoginText5),
            ),
          ),
          const SizedBox(height: 10),
          DegradeButton(
              buttonText: 'SIGN IN',
              isDarkMode: isDarkMode,
              border: 10,
              screenName: 'Dashboard'),
        ],
      ),
    );
  }
}


