import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';
import 'package:toolbar/pages/pages.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final _toolbar = Get.put(ToolbarController());
  final _sidenav = Get.put(SidenavController());

  @override
  void initState() {
    _sidenav.selected.listen((value) {
      _toolbar.search.value = false;
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
    double width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;

    List<Widget> children = [
      const SidenavWidget(),
      _sidenav.items[_sidenav.selected.value].target,
    ];

    return Column(
      children: [
        const AppBarWidget(),
        Expanded(
          child: width < 550
            ? Stack(children: children.reversed.toList())
            : Row(children: children)
        ),
      ]
    );
  }
}
