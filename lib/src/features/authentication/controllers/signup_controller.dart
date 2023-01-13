import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/features/authentication/models/user_models.dart';
import 'package:movie_login/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';
import 'package:movie_login/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // Call this Function from Design and it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    Get.showSnackbar(GetSnackBar(
      message: error.toString(),
    ));
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
    Get.to(const OTPSreen());
  }

  //set phoneNNo from user and pass it to Auth Repo for Firebase Auth
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
