import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';
import '../../services/select_image.dart';
import '../../widgets/button/cancel_button.dart';
import '../../widgets/button/degrade_button.dart';

class ProfileScreeenUpdate extends StatefulWidget {
  const ProfileScreeenUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileScreeenUpdate> createState() => _ProfileScreeenUpdateState();
}

class _ProfileScreeenUpdateState extends State<ProfileScreeenUpdate> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final emailController = TextEditingController();

  cancelChanges(email , image) {
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': email,
      'ProfilePicture' : image,
    });
  }

  Future<bool> saveChanges(File image) async {
    //upload image
    final String nameFile = image.path.split("/").last;
    final Reference ref = storage.ref().child("images").child(nameFile);
    final UploadTask uploadTask = ref.putFile(image);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    String url = await snapshot.ref.getDownloadURL();
    // save changes
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'ProfilePicture': url,
      'Email': emailController.text.toUpperCase(),
    });
    return false;
  }

  // ignore: non_constant_identifier_names
  File? UploadImage;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: mediaQuery.size.width * 0.25,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 24,
            color: isDarkMode ? tWhiteColor : tDarkBackground,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error = ${snapshot.error}');
                }
                Map<String, dynamic> data = snapshot.data!.data()!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final picture = await getImage();
                          setState(() {
                            UploadImage = File(picture!.path);
                          });
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: data['ProfilePicture'] != null
                                  ? CircleAvatar(
                                      radius: 150,
                                      backgroundImage: NetworkImage(data['ProfilePicture']))
                                  : const CircleAvatar(
                                      radius: 150,
                                      backgroundImage: NetworkImage(
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png')),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: isDarkMode
                                        ? tPrimaryColor
                                        : tSecundaryDarkColor),
                                child: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  color: tWhiteColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text(data['Email']),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 30),
                      DegradeButton(
                        buttonText: 'SAVE CHANGES',
                        isDarkMode: isDarkMode,
                        border: 5,
                        onTab: () {
                          emailController.text.isEmpty
                              ? emailController.text = data['Email']
                              : saveChanges(UploadImage!);
                          Get.to(() => const GnavBottomBar());
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          cancelChanges(data['Email'], data['ProfilePicture']);
                          Get.to(() => const GnavBottomBar());
                        },
                        child: const CancelButtonStyle(),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
