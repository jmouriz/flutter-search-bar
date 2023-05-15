import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    final dialog = Get.put(DialogController());

    application.title = 'Dialog Test';

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => dialog.open.value ? dialog.close() : dialog.show(
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                    ),
                    TextButton(
                      onPressed: () => dialog.close(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Toggle dialog'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
