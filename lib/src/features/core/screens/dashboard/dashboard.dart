// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_login/src/features/core/screens/dashboard/widgets/gnavbar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNavBar(),
    );
  }
}

