import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // Call this Function from Design and it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  //set phoneNNo from user and pass it to Auth Repo for Firebase Auth
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}