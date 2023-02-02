import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    Size size = MediaQuery.of(context).size;

    application.title = 'Home';

    return Center(
      child: FlutterLogo(
        size: min(size.width, size.height) * 3/4
      ),
    );
  }
}
