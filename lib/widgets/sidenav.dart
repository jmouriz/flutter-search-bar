import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';

class SidenavWidget extends StatefulWidget {
  const SidenavWidget({ super.key });

  @override
  State<SidenavWidget> createState() => _SidenavWidgetState();
}

class _SidenavWidgetState extends State<SidenavWidget> {
  double width =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;
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
        width: 240,
        key: const ValueKey<String>('sidenav'),
        child: Column(
          children: [
            const UserBar(),
            Expanded(
              child: MenuWidget(
                items: sidenav.items,
                onSelect: (index) {
                  if (sidenav.items[index].target == null) {
                    exit(0);
                  }
                  sidenav.selected.value = index;
                  if (width < 550) {
                    sidenav.open.value = false;
                  }
                },
              ),
            ),
          ],
        )
      ) : null
    );
  }
}

class UserBar extends StatelessWidget {
  const UserBar({ super.key });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Material(
        color: Colors.blue,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                child: Icon(Icons.person)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('Description',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}