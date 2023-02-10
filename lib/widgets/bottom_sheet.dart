import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';

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
    final screen = query.size.height -
      query.padding.top - bottom - kToolbarHeight;
    final EdgeInsets padding;
    int items = bottomSheet.items.length;
    double height = bottomSheet.items.length * kMinInteractiveDimension;
    const value = 10.0; // padding

    while (screen * 3/4 - height < 0) {
      height = (1 + --items) * kMinInteractiveDimension;
    }

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
      child: SizedBox(
        width: width - 2 * value,
        height: height,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          child: MenuWidget(
            items: bottomSheet.items,
            // onSelect: (index) {
            //   if (bottomSheet.items[index].target == null) {
            //     exit(0);
            //   }
            //   if (width < 550) {
            //     bottomSheet.open.value = false;
            //   }
            // },
          ),
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
          child: child
        );
      },
      child: bottomSheet.open.value ? container : null,
    );
  }
}
