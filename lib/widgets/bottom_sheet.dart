import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final bottomSheet = Get.put(BottomSheetController());

  @override
  void initState() {
    bottomSheet.open.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      bottomSheet.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    final width = query.size.width;
    final bottom = query.padding.bottom;
    final EdgeInsets padding;
    const value = 10.0;

    if (bottom > 0) {
      padding = const EdgeInsets.only(
        left: value,
        right: value,
      );
    } else {
      padding = const EdgeInsets.only(
        left: value,
        right: value,
        bottom: value,
      );
    }

    final container = Padding(
      padding: padding,
      child: Container(
        width: width - 2 * value,
        height: 150.0,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          child: const FlutterLogo(size: 64.0)
        )
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        double begin = animation.isCompleted ? 1.0 : -1.0;
        if (bottomSheet.open.value) {
          begin *= -1;
        }
        return SlideTransition(
            position: Tween(begin: Offset(0.0, begin), end: Offset.zero)
                .animate(animation),
            child: child);
      },
      child: bottomSheet.open.value ? container : null,
    );
  }
}
