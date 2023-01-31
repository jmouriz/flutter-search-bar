import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/app_bar.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final controller = Get.put(AppBarController());

  @override
  void initState() {
    controller.searching.listen((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotchWidget(),
        Material(
          elevation: 2,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              double begin = animation.isCompleted ? 1.0 : -1.0;
              if (controller.searching.value) {
                begin *= -1;
              }
              return SlideTransition(
                position: Tween(begin: Offset(begin, 0.0), end: Offset.zero)
                  .animate(animation),
                child: child,
              );
            },
            child: controller.searching.value
              ? const SearchBarWidget(key: ValueKey<String>('searchbar'))
              : const ToolbarWidget(key: ValueKey<String>('toolbar'))
          ),
        ),
      ],
    );
  }
}