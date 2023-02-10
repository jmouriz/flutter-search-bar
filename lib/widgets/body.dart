import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/app_bar.dart';
import 'package:toolbar/widgets/widgets.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final sidenav = Get.put(SidenavController());
  final query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  Widget target = const SizedBox.shrink();
  static const padding = 10.0;

  @override
  void initState() {
    target = sidenav.items[sidenav.selected.value].target;
    sidenav.selected.listen((value) {
      target = sidenav.items[value].target;
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
    double width = query.size.shortestSide;

    return Stack(children: width < 550 ? mobile : desktop);
  }

  List<Widget> get mobile {
    return [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: SingleChildScrollView(child: target),
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
      const AppBarWidget(),
      Padding(
        padding: EdgeInsets.only(top: query.padding.top + kToolbarHeight),
        child: const SidenavWidget(),
      ),
    ];
  }

  List<Widget> get desktop {
    return [
      const AppBarWidget(),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: Row(
            children: [
              const SidenavWidget(),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: target
                  ),
                ),
              ),
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
    ];
  }
}
