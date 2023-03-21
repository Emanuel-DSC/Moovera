import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/authentication/google_auth_services.dart';
import 'package:movie_login/src/screens/profile/profile_update_screen.dart';
import 'package:movie_login/src/widgets/button/degrade_button.dart';
import 'package:movie_login/src/widgets/profile/profile_menu_widget.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    var user = FirebaseAuth.instance.currentUser?.uid ?? 'No user found';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('Users').doc(user).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
      
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Text('no data');
      
                } else {
      
                  Map<String, dynamic> data = snapshot.data!.data()!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Center(
                      child: Column(children: [
                        Container(
                        height: height * 0.3,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(data['ProfilePicture']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                        const SizedBox(height: 30),
                        Text(data['Email'], style: Theme.of(context).textTheme.headline4),
                        const SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: 'Settings',
                            icon: LineAwesomeIcons.cog,
                            onPress: () {}),
                        ProfileMenuWidget(
                            title: 'User Management',
                            icon: LineAwesomeIcons.user,
                            onPress: () {}),
                        ProfileMenuWidget(
                            title: 'Information',
                            icon: LineAwesomeIcons.info,
                            onPress: () {}),
                        ProfileMenuWidget(
                            title: 'Logout',
                            icon: Icons.logout,
                            onPress: () {
                              AuthenticationRepository.instance.logout();
                              AuthService().signOutWithGoogle();
                            },
                            textColor: Colors.red,
                            endIcon: false),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DegradeButton(
                            buttonText: 'Edit Profile',
                            isDarkMode: isDarkMode,
                            border: 20,
                            onTab: () {
                              Get.to(() => const ProfileScreeenUpdate());
                            },
                          ),
                        )
                      ]),
                    ),
                  );
                }
      
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
                // error
              } else {
                return const Text('Error'); // loading
              }
            }),
      ),
    );
  }
}
