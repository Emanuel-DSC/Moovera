// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_login/src/constants/custom_icon_icons.dart';
import 'package:movie_login/src/constants/colors.dart';


class GNavBar extends StatelessWidget {
  const GNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
        // body: Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),
        bottomNavigationBar: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: GNav(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              backgroundColor: isDarkMode ? tDarkBackground : Colors.white,
              gap: 8,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              tabBorderRadius: 30,
              tabBackgroundGradient: LinearGradient(colors: [
                  isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
                  isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
                ],
              ),
        
            
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                GButton(
                  icon: CustomIcon.fill_1, 
                  text: 'Home',
                  iconActiveColor: Colors.white,
                  iconColor: tThirdDarkColor,
                  textSize: 12,
                  textColor: Colors.white),
                GButton(
                  icon: CustomIcon.favorite, 
                  text: 'Favorites',
                  iconActiveColor: Colors.white,
                  iconColor: tThirdDarkColor,
                  textSize: 12,
                  textColor: Colors.white),
                GButton(
                  icon: CustomIcon.user, 
                  text: 'Profile',
                  iconActiveColor: Colors.white,
                  iconColor: tThirdDarkColor,
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