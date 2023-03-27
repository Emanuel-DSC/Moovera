import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/screens/profile/profile_update_screen.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';

Future<CroppedFile?> getImage() async {
  // pick image
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //crop image
  CroppedFile? croppedImage =
      await ImageCropper().cropImage(sourcePath: image!.path, aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 4));
  return croppedImage;
}

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

cancelChanges(email, image) {
    final user = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': email,
      'ProfilePicture': image,
    });
  }

