import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/models/models.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final toolbar = Get.put(ToolbarController());
  final application = Get.put(ApplicationController());
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
    const headingRowHeight = 56.0;
    final safe = media.size.height -
        media.padding.top -
        media.padding.bottom -
        kToolbarHeight -
        2 * headingRowHeight;
    int rows = (safe / kMinInteractiveDimension).floor();
    final DataTableSource data = DataSource();

    if (PlatformDetails().isMobile) {
      rows -= 2;
    }

    application.title = 'Search Test';
    application.search = true;

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

    int sortColumnIndex = 1;
    bool sortAscending = true;

    void sort<T>(Comparable<T> Function(dynamic d) getField, int columnIndex, bool ascending) {
      //_data._sort<T>(getField, ascending);
      setState(() {
        sortColumnIndex = columnIndex;
        sortAscending = ascending;
      });
    }

    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: const CardTheme(elevation: 0)
      ),
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          headingRowHeight: headingRowHeight,
          source: data,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          rowsPerPage: rows,
          showCheckboxColumn: false,
          columns: [
            const DataColumn(label: Text('#')),
            DataColumn(
              label: const Text('User'),
              onSort: (int columnIndex, bool ascending) => sort<String>((d) => d, columnIndex, ascending)
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: (int columnIndex, bool ascending) => sort<String>((d) => d, columnIndex, ascending)
            ),
            const DataColumn(label: Text('Price')),
            const DataColumn(label: Text('')),
          ],
        ),
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
    }
  );

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
