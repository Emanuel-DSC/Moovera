import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';

class AnimatedLikeButton extends StatelessWidget {
  const AnimatedLikeButton({
    Key? key,
    required this.isDarkMode,
    required this.onTabAdd,
    required this.onTabDelete,
  }) : super(key: key);

  final bool isDarkMode;
  final VoidCallback onTabAdd;
  final VoidCallback onTabDelete;

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    isLiked ? onTabAdd : onTabDelete;

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        gradient: LinearGradient(
          colors: [
            isDarkMode ? tPrimaryColor : tPrimaryDarkColor,
            isDarkMode ? tSecundaryColor : tSecundaryDarkColor,
          ],
        ),
      ),
      child: LikeButton(
        size: 50,
        onTap: (isLiked) {
          return onLikeButtonTapped(isLiked);
        },
        likeBuilder: (isLiked) {
          return isLiked
              ? const Icon(LineAwesomeIcons.heart_1, color: Colors.white)
              : const Icon(LineAwesomeIcons.heart, color: Colors.white);
        },
      ),
    );
  }
}
