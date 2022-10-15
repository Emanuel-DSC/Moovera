import 'package:flutter/material.dart';

class CategoriesText extends StatelessWidget {
  const CategoriesText({Key? key, required this.categorieTitle}) : super(key: key);
  final String categorieTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child:
          Text(categorieTitle, style: Theme.of(context).textTheme.headline5),
    );
  }
}
