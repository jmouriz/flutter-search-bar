import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolbar = Get.put(ToolbarController());
    final _searchBar = Get.put(SearchBarController());

    _toolbar.search.value = true;
    _searchBar.conditions.clear();
    _searchBar.conditions.addAll([
      Condition(
        label: 'Date',
        name: 'date',
        type: Type.date
      ),
      Condition(
        label: 'Email',
        name: 'email',
        operator: Operator.contain
      ),
      Condition(
        label: 'Min Amount',
        name: 'amount',
        operator: Operator.greater
      ),
      Condition(
        label: 'Max Amount',
        name: 'amount',
        operator: Operator.less
      ),
      Condition(
        label: 'Checked',
        name: 'chacked'
      ),
    ]);

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
