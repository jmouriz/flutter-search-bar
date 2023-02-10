import 'package:flutter/material.dart';

class NotchWidget extends StatelessWidget {
  const NotchWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container( // NotchWidget
      height: MediaQuery.of(context).padding.top,
      width: double.infinity,
      color: Colors.blue.shade700,
    );
  }
}