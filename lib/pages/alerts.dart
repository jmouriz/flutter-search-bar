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

    final label = 'Open Auto Close Alert ($timeout seconds)';
    final title = "Won't worry";
    final message = "Hi! I'm a test alert\nline2\nline3\nline4";
    final type = AlertType.error;

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Center(
        child: Column(
          children: [
            alertButton(
              'Open Success Alert',
              "Hi! I'm a test alert",
              AlertType.success,
            ),
            const SizedBox(height: 16),
            alertButton(
              'Open Error Alert',
              "Hi! I'm a test alert",
              AlertType.error,
            ),
            const SizedBox(height: 16),
            alertButton(
              'Open Warning Alert',
              "Hi! I'm a test alert",
              AlertType.warning,
            ),
            const SizedBox(height: 16),
            alertButton(
              'Open Info Alert',
              "Hi! I'm a test alert",
              AlertType.info,
            ),
            const SizedBox(height: 16),
            alertButton(
              'Open Normal Alert',
              "Hi! I'm a test alert",
              AlertType.normal,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => alert.show(
                title: "Won't worry",
                message: "Hi! I'm a test alert\nline2\nline3\nline4",
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

  ElevatedButton alertButton(
    String label,
    String message,
    AlertType type,
  ) {
    final alert = Get.put(AlertController());

    return ElevatedButton(
      onPressed: () => alert.show(
        message: message,
        type: type
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(label),
      ),
    );
  }
}