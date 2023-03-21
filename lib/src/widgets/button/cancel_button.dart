import 'package:flutter/material.dart';

class CancelButtonStyle extends StatelessWidget {
  const CancelButtonStyle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.red.shade900,
        borderRadius: const BorderRadius.all(
            Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          'CANCEL',
          style: TextStyle(
              fontSize: 16,
              color: Colors.red.shade300),
        ),
      ),
    );
  }
}