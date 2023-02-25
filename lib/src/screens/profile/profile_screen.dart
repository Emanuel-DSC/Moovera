import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/authentication/auth_services.dart';
import 'package:movie_login/src/screens/widgets/common_widget/button/degrade_button.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/screens/widgets/profile_menu_widget.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
            titleSpacing: mediaQuery.size.width * 0.25,
            elevation: 0,
            backgroundColor: isDarkMode ? tDarkBackground : tWhiteColor,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(LineAwesomeIcons.angle_left)),
            title: const Text(
              "Profile",
              style: TextStyle(
                fontSize: 24,
                color: tWhiteColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(isDarkMode
                      ? LineAwesomeIcons.sun
                      : LineAwesomeIcons.moon)),
            ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Expanded(
            child: Center(
              child: Column(children: [
                const SizedBox(height: 20),
                Text("Jason", style: Theme.of(context).textTheme.headline4),
                Text("jason51@gmail.com",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 30),
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
                      Get.to(const ProfileScreen());
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
