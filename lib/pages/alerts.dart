import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    final alert = Get.put(AlertController());
    const timeout = 5;

    application.title = 'Alerts Test';

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => alert.show(message: "Hi! I'm a test alert"),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Open Alert'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => alert.show(
                message: "Hi! I'm a test alert",
                timeout: timeout,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Open Auto Close Alert ($timeout seconds)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}