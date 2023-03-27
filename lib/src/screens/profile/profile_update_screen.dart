import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/services/profile_services.dart';
import 'package:movie_login/src/widgets/gnav_bottom_bar.dart';
import '../../widgets/button/cancel_button.dart';
import '../../widgets/button/degrade_button.dart';

class ProfileScreeenUpdate extends StatefulWidget {
  const ProfileScreeenUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileScreeenUpdate> createState() => ProfileScreeenUpdateState();
}

class ProfileScreeenUpdateState extends State<ProfileScreeenUpdate> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  static final emailController = TextEditingController();

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
                              child: UploadImage != null
                                  ? ClipOval(
                                      child: SizedBox.fromSize(
                                        size:
                                            const Size.fromRadius(48), // Image radius
                                        child: (Image.file(UploadImage!,
                                            fit: BoxFit.cover)),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 150,
                                      backgroundImage: NetworkImage(
                                          data['ProfilePicture'].toString())),
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
                          if (emailController.text.isEmpty) {
                            emailController.text = data['Email'];
                            saveChanges(UploadImage!);
                          }
                          saveChanges(UploadImage!);
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
