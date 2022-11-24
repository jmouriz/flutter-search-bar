import 'package:flutter/material.dart';
import 'package:toolbar/widgets/widgets.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).padding.top,
        width: double.infinity,
        color: Colors.blue,
      ),
      const AppBarWidget(),
      const BodyWidget(),
    ]);
  }
}