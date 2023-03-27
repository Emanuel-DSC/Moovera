import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/constants/text_string.dart';
import '../../services/login_services.dart';
import '../forget_password/forget_password_email/forget_password_model_bottom_sheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
// text editing controllers
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  bool _obscureTextController = true;
  FocusNode textFieldFocusPassword = FocusNode();

  void _toggleObscureText() {
    setState(() {
      _obscureTextController = !_obscureTextController;
    });
  }
  
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
            // onFieldSumbitted go to password text field
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(textFieldFocusPassword),
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              labelText: tLoginText3,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: textFieldFocusPassword,
            obscureText: _obscureTextController,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              labelText: tLoginText4,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: _obscureTextController ? const Icon(LineAwesomeIcons.eye_slash_1)  
                : const Icon(LineAwesomeIcons.eye),
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
            onTab: () {
              signUserIn(context);
            },
          ),
        ],
      ),
    );
  }
}

