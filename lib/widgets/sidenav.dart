import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class SidenavWidget extends StatefulWidget {
  const SidenavWidget({super.key});

  @override
  State<SidenavWidget> createState() => _SidenavWidgetState();
}

class _SidenavWidgetState extends State<SidenavWidget> {
  final _sidenav = Get.put(SidenavController());

  @override
  void initState() {
    _sidenav.open.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _sidenav.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        double begin = animation.isCompleted ? -1.0 : 1.0;
        if (_sidenav.open.value) {
          begin *= -1;
        }
        return SlideTransition(
          position: Tween(
            begin: Offset(begin, 0.0),
            end: Offset.zero
          ).animate(animation),
          child: child
        );
      },
      child: _sidenav.open.value ? const Drawer(
        key: ValueKey<String>('sidenav'),
        child: Center(
          child: Text('Sidenav')
        ),
      ) : null
    );
  }
}