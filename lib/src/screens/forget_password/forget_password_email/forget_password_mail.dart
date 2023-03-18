import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/screens/login_screen/login_screen.dart';
import 'package:movie_login/src/widgets/alert_dialog.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/widgets/form/form_header_widget.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';

class ForgetPasswordMailScreen extends StatefulWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordMailScreen> createState() =>
      _ForgetPasswordMailScreenState();
}

class _ForgetPasswordMailScreenState extends State<ForgetPasswordMailScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(message: tEmailSent2, message2: tEmailSent, 
            onTap: () { 
              Navigator.of(context).pop(); 
              Get.to(() => const LoginScreen());
              });
          });
          
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog(
                message: 'error', message2: e.message.toString(), 
                onTap: () => Navigator.of(context).pop());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(icon: Icon(LineAwesomeIcons.angle_left, color: isDarkMode ? Colors.white : Colors.black), 
          onPressed: () => Navigator.of(context).pop()),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.04),
                Center(
                    child: FormHeaderWidget(
                        isDarkMode: isDarkMode,
                        size: size,
                        title: tForgetPasswordText6,
                        subtitle: tForgetPasswordText7,
                        image: tWelcomeImage_dark,
                        imageDark: tWelcomeImage)),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: tLoginText3,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DegradeButton(
                  buttonText: tResetPassword.toUpperCase(),
                  isDarkMode: isDarkMode,
                  border: 8,
                  onTab: () {
                    passwordReset();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
