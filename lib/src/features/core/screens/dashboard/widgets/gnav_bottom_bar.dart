import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/custom_icon_icons.dart';
import 'package:movie_login/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:movie_login/src/features/authentication/screens/signup_screen/signup_screen.dart';
import 'package:movie_login/src/features/core/screens/dashboard/dashboard.dart';
import 'package:movie_login/src/features/core/screens/profile_sreen.dart';

class GnavBottomBar extends StatefulWidget {
  const GnavBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<GnavBottomBar> createState() => _GnavBottomBarState();
}

class _GnavBottomBarState extends State<GnavBottomBar> {
  int _currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const DashBoard(),
    const LoginScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 95,
        decoration: BoxDecoration(
          color: isDarkMode ? tDarkBackground : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.3),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: GNav(
              onTabChange: _navigateBottomBar,
              selectedIndex: _currentIndex,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              backgroundColor:
                  isDarkMode ? tDarkBackground : Colors.white,
              gap: 8,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              tabBorderRadius: 18,
              tabBackgroundGradient: LinearGradient(
                colors: [
                  isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                  isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
                ],
              ),

              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const GButton(
                    icon: CustomIcon.fill_1,
                    iconSize: 35,
                    text: 'Home',
                    iconActiveColor: Colors.white,
                    iconColor: tThirdColor,
                    textSize: 12,
                    textColor: Colors.white),
                const GButton(
                    icon: CustomIcon.favorite,
                    iconSize: 35,
                    text: 'Favorites',
                    iconActiveColor: Colors.white,
                    iconColor: tThirdColor,
                    textSize: 12,
                    textColor: Colors.white),
                const GButton(
                    icon: CustomIcon.user,
                    iconSize: 35,
                    text: 'Profile',
                    iconActiveColor: Colors.white,
                    iconColor: tThirdColor,
                    textSize: 12,
                    textColor: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
