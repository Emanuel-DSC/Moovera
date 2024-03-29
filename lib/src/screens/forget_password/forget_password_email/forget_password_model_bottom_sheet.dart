import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movie_login/src/constants/text_string.dart';
import 'forget_password_mail.dart';
import '../../../widgets/button/forget_password_button_widget.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tForgetPasswordText,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    tForgetPasswordText2,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 30.0),
                  ForgetPasswordWidget(
                    icon: Icons.mail_outline_rounded,
                    title: tLoginText3,
                    subTitle: tForgetPasswordText3,
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const ForgetPasswordMailScreen());
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ForgetPasswordWidget(
                    icon: Icons.phone_iphone_rounded,
                    title: tForgetPasswordText5,
                    subTitle: tForgetPasswordText4,
                    onTap: (() {}),
                  ),
                ],
              ),
            ));
  }
}
