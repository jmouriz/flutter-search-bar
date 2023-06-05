import 'package:flutter/material.dart';
import 'package:toolbar/providers/providers.dart';

class BottomNotchWidget extends StatelessWidget {
  const BottomNotchWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container( // NotchWidget
        height: MediaQuery.of(context).padding.bottom,
        color: ThemeProvider().primary.shade700,
      ),
    );
  }
}