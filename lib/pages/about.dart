import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());

    application.title = 'About this App';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text('About this App'),
          LinkWidget(
            label: 'Show licenses',
            callback: (_) => showLicensePage(context: context),
          ),
        ],
      ),
    );
  }
}