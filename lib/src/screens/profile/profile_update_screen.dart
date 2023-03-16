import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/profile/profile_screen.dart';
import 'package:movie_login/src/widgets/alert_dialog.dart';

import '../../widgets/button/degrade_button.dart';

class ProfileScreeenUpdate extends StatelessWidget {
  ProfileScreeenUpdate({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser?.uid;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  saveChanges() {
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': emailController.text,
      'Password': passwordController.text,
      'ConfirmPassword': passwordController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: mediaQuery.size.width * 0.25,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: isDarkMode ? tWhiteColor : tDarkBackground,
            )),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 24,
            color: isDarkMode ? tWhiteColor : tDarkBackground,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Expanded(
            child: SizedBox(
              height: size.height,
              width: size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user)
                          .get(),
                      builder: (context, snapshot) {
                        // if (snapshot.hasError) {
                        //   return Text('Error = ${snapshot.error}');
                        // }
                        // if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return Center(
                        //           child: Center(
                        //               child: CircularProgressIndicator(
                        //         color:
                        //             isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                        //         strokeWidth: 3,
                        //       )));
                        //     }

                        Map<String, dynamic> data = snapshot.data!.data()!;
                        return Column(
                          children: [
                            const SizedBox(height: 40),
                            Stack(
                              children: [
                                const SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: CircleAvatar(
                                      radius: 150,
                                      backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80')),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                            const SizedBox(height: 50),
                            TextFormField(
                              onFieldSubmitted: (value) {
                                emailController.text.isEmpty
                                    ? MyAlertDialog(
                                        message: 'error',
                                        message2: 'Field is empty')
                                    : saveChanges();
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                label: Text(data['Email']),
                                prefixIcon:
                                    const Icon(Icons.mail_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              onFieldSubmitted: (value) {
                                saveChanges();
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                label: Text(data['Password']),
                                prefixIcon: const Icon(Icons.fingerprint),
                              ),
                            ),
                            const SizedBox(height: 20),
                            DegradeButton(
                              buttonText: 'SAVE',
                              isDarkMode: isDarkMode,
                              border: 5,
                              onTab: () {
                                Get.to(const ProfileScreen());
                              },
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text.rich(
                                    TextSpan(
                                      text: 'joined',
                                      style: TextStyle(fontSize: 12),
                                      children: [
                                        TextSpan(
                                            text: '12 october 2022',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none,
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
