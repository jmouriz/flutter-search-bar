import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

class PlaceholderWidget extends StatefulWidget {
  const PlaceholderWidget({ super.key });

  @override
  State<PlaceholderWidget> createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
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
    return sidenav.open.value ? const SizedBox(
      height: 1,
      width: 240,
    ) : const SizedBox.shrink();
  }
}