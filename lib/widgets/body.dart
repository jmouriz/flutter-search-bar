import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/widgets/notch/notch.dart';
import 'package:toolbar/widgets/widgets.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final sidenav = Get.put(SidenavController());
  final application = Get.put(ApplicationController());
  final bottomSheet = Get.put(BottomSheetController());
  final query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  Widget target = const SizedBox.shrink();
  static const padding = 10.0;

  @override
  void initState() {
    target = sidenav.items[sidenav.selected.value].target;
    if (PlatformDetails().isMobile) {
      sidenav.open.listen((value) => setState(() {}));
    }
    bottomSheet.open.listen((value) => setState(() {}));
    application.notch.listen((value) =>
      Future.delayed(Duration.zero, () => setState(() {}))
    );
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
      bottomSheet.dispose();
      application.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = query.size.shortestSide;

    return Stack(children: width < 550 ? mobile : desktop);
  }

  List<Widget> get mobile {
    return [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          //child: SingleChildScrollView(child: target),
          child: target
        ),
      ),
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GestureDetector(
          behavior: (sidenav.open.value || bottomSheet.open.value)
            ? HitTestBehavior.opaque
            : HitTestBehavior.deferToChild,
          onTap: () {
            sidenav.close();
            bottomSheet.close();
          },
        )
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
      application.notch.value
        ? const BottomNotchWidget()
        : const Text(''), // todo
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
                child: Stack(children: [
                  SizedBox(
                    height: double.infinity,
                    //child: SingleChildScrollView(child: target),
                    child: target,
                  ),
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: GestureDetector(
                        behavior: bottomSheet.open.value
                          ? HitTestBehavior.opaque
                          : HitTestBehavior.deferToChild,
                        onTap: () {
                          bottomSheet.close();
                        },
                      )),
                ]),
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
