import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/screens/profile/profile_update_screen.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

Future<bool> saveChanges(File image) async {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseStorage storage = FirebaseStorage.instance;

  //upload image
  final String nameFile = image.path.split("/").last;
  final Reference ref = storage.ref().child("images").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  String url = await snapshot.ref.getDownloadURL();

  // save changes
  FirebaseFirestore.instance.collection('Users').doc(user).set({
    'ProfilePicture': url,
    'Email': ProfileScreeenUpdateState.emailController.text.toUpperCase(),
  });

  Get.to(() => const GnavBottomBar());
  return false;
}
