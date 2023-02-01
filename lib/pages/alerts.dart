import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toolbar = Get.put(ToolbarController());
    final alert = Get.put(AlertController());

    toolbar.title.value = 'Alerts Test';

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ElevatedButton(
          onPressed: () => alert.open.value = true,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Open Alert'),
          ),
        ),
      ),
    );
  }
}