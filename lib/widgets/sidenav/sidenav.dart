import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class SidenavWidget extends StatefulWidget {
  const SidenavWidget({ super.key });

  @override
  State<SidenavWidget> createState() => _SidenavWidgetState();
}

class _SidenavWidgetState extends State<SidenavWidget> {
  double width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;
  final sidenav = Get.put(SidenavController());

  @override
  void initState() {
    sidenav.open.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      sidenav.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        double begin = animation.isCompleted ? -1.0 : 1.0;
        if (sidenav.open.value) {
          begin *= -1;
        }
        return SlideTransition(
          position: Tween(begin: Offset(begin, 0.0), end: Offset.zero)
            .animate(animation),
          child: child
        );
      },
      child: sidenav.open.value ? Drawer(
        key: const ValueKey<String>('sidenav'),
        child: ListView.builder(
          itemCount: sidenav.items.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(sidenav.items[index].icon),
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              title: Text(sidenav.items[index].title),
              onTap: () {
                sidenav.selected.value = index;
                if (width < 550) {
                  sidenav.open.value = false;
                }
              },
            );
          },
        )
      ) : null
    );
  }
}
