import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toolbar = Get.put(ToolbarController());
    final bottomSheet = Get.put(BottomSheetController());

    toolbar.title.value = 'Bottom Sheet Test';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: ElevatedButton(
            onPressed: () {
              bottomSheet.open.value = !bottomSheet.open.value;
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Toggle Bottom Sheet'),
            ),
          ),
        )
      ],
    );
  }
}