import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.isDarkMode,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.imageDark,
  }) : super(key: key);

  final bool isDarkMode;
  final Size size;
  final String title, subtitle, image, imageDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50.0),
        isDarkMode
            ? Image(
                image: AssetImage(image),
                height: size.height * 0.2)
            : Image(
                image: AssetImage(imageDark),
                height: size.height * 0.2),
        const SizedBox(height: 30),
        Text(title, style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(height: 10),
        Text(subtitle, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,),
      ],
    );
  }
}
