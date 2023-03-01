import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,

  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    
    var isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isDarkMode? tThirdDarkColor.withOpacity(0.1) : tThirdDarkColor.withOpacity(0.2)),
          child: Icon(icon, color: isDarkMode ? tSecundaryColor : tSecundaryDarkColor)),
      title: Text (title, style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular (100), 
        color: isDarkMode ? Colors.grey.withOpacity(0.1) : tThirdDarkColor.withOpacity(0.2)),
        child: Icon(LineAwesomeIcons.angle_right, size: 18.0, color: isDarkMode ? tSecundaryColor : tSecundaryDarkColor)) : null,
      );
  }
}
