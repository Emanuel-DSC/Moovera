import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/custom_icon_icons.dart';
import 'package:movie_login/src/constants/text_string.dart';

import '../screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.to(const SearchScreen());
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 400,
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode ? tBottomDarkColor : tThirdDarkColor,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  tDashboardText,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? tThirdColor : tWhiteColor,
                  ),
                ),
                Icon(CustomIcon.search,
                    color: isDarkMode ? tThirdColor : tWhiteColor,
                    size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
