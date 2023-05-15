import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());
    final bottomSheet = Get.put(BottomSheetController());

    application.title = 'Bottom Sheet Test';

    return Center(
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => bottomSheet.open.value = !bottomSheet.open.value,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Toggle Bottom Sheet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}