import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final toolbar = Get.put(ToolbarController());
  final searchBar = Get.put(SearchBarController());

  @override
  void initState() {
    searchBar.version.listen((value) {
      print(jsonEncode(searchBar.getConditions()));
    });
    super.initState();
  }

  @override
  void dispose() {
    //toolbar.dispose();
    //searchBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final safe = media.size.height - media.padding.top - media.padding.bottom -
      kToolbarHeight - 2 * 56;
    final rows = (safe / kMinInteractiveDimension).floor() - 2;
    final DataTableSource data = DataSource();

    toolbar.title.value = 'Search Test';
    toolbar.search.value = true;

    searchBar.conditions.clear();
    searchBar.conditions.addAll({
      'date': ConditionModel(
        label: 'Date',
        name: 'date',
        type: Type.date,
      ),
      'email': ConditionModel(
        label: 'Email',
        name: 'email',
        operator: Operator.contain,
      ),
      'min-amount': ConditionModel(
        label: 'Min Amount',
        name: 'amount',
        operator: Operator.greater,
      ),
      'max-amount': ConditionModel(
        label: 'Max Amount',
        name: 'amount',
        operator: Operator.less,
      ),
      'checked': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      // SCROLL TEST
      // 'checked1': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked2': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked3': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked4': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked5': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked6': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked7': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked8': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked9': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked10': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked11': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
      // 'checked12': ConditionModel(
      //   label: 'Checked',
      //   name: 'checked',
      //   type: Type.boolean,
      // ),
    });

    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: const CardTheme(
          elevation: 0,
        )
      ),
      child: PaginatedDataTable(
        headingRowHeight: 56.0,
        source: data,
        sortColumnIndex: 0,
        rowsPerPage: rows,
        showCheckboxColumn: false,
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('User')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('')),
        ],
      ),
    );
  }
}

class DataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      1000,
      (index) => {
            'id': index,
            'user': 'user$index@domain.com',
            'vendor': 'vendor$index@domain.com',
            'price': Random().nextDouble() * 500,
          });

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['user'])),
      DataCell(Text(_data[index]['vendor'])),
      DataCell(Text(_data[index]['price'].toStringAsFixed(2))),
      const DataCell(Icon(Icons.delete)),
    ]);
  }
}
