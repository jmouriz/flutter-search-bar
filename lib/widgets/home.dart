import 'package:flutter/material.dart';
import 'package:toolbar/widgets/widgets.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;

    print(width);

    List<Widget> children = const [
      //DrawerWidget(), // TODO
      BodyWidget(),
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
