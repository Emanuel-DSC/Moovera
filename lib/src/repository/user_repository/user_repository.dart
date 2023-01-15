import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/features/authentication/models/user_models.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar('Success', 'Your account has been created.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.transparent,
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong. Try again',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<UserModel> getUserDetails(String phoneNo) async {
    final snapshot = await _db.collection("Users").where("Phone", isEqualTo: phoneNo).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
}
