import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = Get.put(DialogController());

    return Center(
      heightFactor: 1,
      child: ElevatedButton(
        onPressed: () => dialog.open.value ? dialog.close() : dialog.show(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Dialog body'),
              ),
              TextButton(
                onPressed: () => dialog.close(),
                child: const Text('Close'),
              )
            ],
          ),
        ),
        child: const Text('Toggle dialog'),
      )
    );
  }
}
