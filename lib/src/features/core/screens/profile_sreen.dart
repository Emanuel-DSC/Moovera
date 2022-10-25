import 'package:flutter/material.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/images.dart';
import 'package:movie_login/src/repository/auth_repository/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Expanded(
            child: Column(children: [
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                              isDarkMode ? tProfileBgDark : tProfileBg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundColor:
                            isDarkMode ? tDarkBackground : tWhiteColor,
                        child: const CircleAvatar(
                          radius: 90,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 30,
                                color: tWhiteColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 230),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: IconButton(
                              icon: const Icon(Icons.logout),
                              color: tWhiteColor,
                              onPressed: () {
                                AuthenticationRepository.instance.logout();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ]),
          ),
        ),
      ),
    );
  }
}
