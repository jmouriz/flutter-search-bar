import 'package:flutter/material.dart';
import 'package:toolbar/providers/providers.dart';

class TopNotchWidget extends StatelessWidget {
  const TopNotchWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container( // NotchWidget
      height: MediaQuery.of(context).padding.top,
      width: double.infinity,
      color: ThemeProvider().primary.shade700,
    );
  }
}