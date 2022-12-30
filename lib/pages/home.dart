import 'dart:math';

import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: FlutterLogo(
        size: min(size.width, size.height) * 3/4
      ),
    );
  }
}
