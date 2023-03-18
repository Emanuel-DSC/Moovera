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

  saveChanges() {
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': emailController.text,
    });
  }
  
  cancelChanges(x) {
    FirebaseFirestore.instance.collection('Users').doc(user).set({
      'Email': x,
    });
  }

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
                      // const SizedBox(height: 40),
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
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MyAlertDialog(
                                        message: 'error',
                                        message2: 'Field is empty', onTap: () { Navigator.of(context).pop();  },);
                                  })
                              : Get.to(const ProfileScreen());
                          saveChanges();
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                        cancelChanges(data['Email']);
                        Get.to(() => const ProfileScreen());
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red.shade300),
                            ),
                          ),
                        ),
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
