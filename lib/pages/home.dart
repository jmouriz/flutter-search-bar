import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());

    application.title = 'Home';

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: FlutterLogo(
              size: 64,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Flutter ${application.version}',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const Text('A long description of this app'),
            ],
          ),
        ],
      ),
    );
  }
}
