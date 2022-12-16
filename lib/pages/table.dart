import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Data Table',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        )
      )
    );
  }
}
