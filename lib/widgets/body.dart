import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final toolbar = Get.put(ToolbarController());
  final sidenav = Get.put(SidenavController());
  final query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static const padding = 10.0;

  @override
  void initState() {
    sidenav.selected.listen((value) {
      toolbar.search.value = false;
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
    //final query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    //double width = query.size.shortestSide;
    final width = query.size.shortestSide;

    return Stack(children: width < 550 ? mobile : desktop);
  }

  List<Widget> get mobile {
    return [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: sidenav.items[sidenav.selected.value].target,
          ),
        ),
        Positioned(
          top: query.padding.top + kToolbarHeight + padding,
          child: const AlertWidget(),
        ),
        Positioned(
          bottom: query.padding.bottom,
          child: const BottomSheetWidget(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: kToolbarHeight),
          child: SidenavWidget(),
        ),
        const AppBarWidget(),
      ];
  }

  List<Widget> get desktop {
    return [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Row(
              children: [
                const SidenavWidget(),
                Expanded(child: sidenav.items[sidenav.selected.value].target),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          child: BottomSheetWidget(),
        ),
        Positioned(
          top: query.padding.top + kToolbarHeight + padding,
          child: const AlertWidget(),
        ),
        const AppBarWidget(),
      ];
  }
}
