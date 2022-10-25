import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/common_widget/form_footer_widget.dart';
import 'package:movie_login/src/common_widget/form_header_widget.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'package:movie_login/src/features/authentication/controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
    required this.isDarkMode,
    required this.size,
  }) : super(key: key);

  final bool isDarkMode;
  final Size size;
  //backend
  static final controller = Get.put(SignUpController());
  static final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Form(
           key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // theme on image
                FormHeaderWidget(
                    isDarkMode: isDarkMode,
                    size: size,
                    title: tSignUpText,
                    subtitle: tSignUpText2,
                    image: tWelcomeImage_dark,
                    imageDark: tWelcomeImage),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.fullName,
                  decoration: const InputDecoration(
                    label: Text(tSignUpText3),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text(tLoginText3),
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: const InputDecoration(
                    label: Text(tSignUpText4),
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.password,
                  decoration: const InputDecoration(
                    label: Text(tLoginText4),
                    prefixIcon: Icon(Icons.fingerprint),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    gradient: LinearGradient(
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: [
                        isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                        isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SignUpController.instance.registerUser(
                            controller.email.text.trim(),
                            controller.password.text.trim());
                      }
                    },
                    child: const Text(
                      tSignUpText,
                      style: TextStyle(
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
                ),
                const FormFooter(
                    buttonTitle1: tLoginText6,
                    buttonTitle2: tSignUpText5,
                    buttonTitle3: tLoginText8)
              ],
        ),
      ),
    );
  }
}
