import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final dialog = Get.put(DialogController());

  @override
  void initState() {
    dialog.open.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      dialog.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: dialog.body,
          ),
        ),
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child
        );
      },
      child: dialog.open.value ? container : null,
    );
  }
}
