import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'SearchBar Demo',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        )
      )
    );
  }
}
