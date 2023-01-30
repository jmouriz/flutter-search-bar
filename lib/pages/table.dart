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
  final controller = ScrollController();
  //   initialScrollOffset: double.infinity,
  //   keepScrollOffset: true,
  // );

  @override
  void initState() {
    searchBar.rows.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut
          );
          setState(() {});
        });
      }
    });
    searchBar.version.listen((value) {
      print(jsonEncode(searchBar.getConditions()));
    });
    super.initState();
  }

  @override
  void dispose() {
    toolbar.dispose();
    searchBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(searchBar.visibles);

    double safeHeight() {
      final media = MediaQuery.of(context);
      final height =
        media.size.height - media.padding.top - media.padding.bottom;
      const padding = 8.0; // XXX
      return height - 2 * padding -
        kToolbarHeight * (searchBar.visibles + 1);
    }

    final count = (safeHeight() / kMinInteractiveDimension).floor() - 1;
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
      'checked1': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked2': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked3': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked4': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked5': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked6': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked7': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked8': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked9': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked10': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked11': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
      'checked12': ConditionModel(
        label: 'Checked',
        name: 'checked',
        type: Type.boolean,
      ),
    });

    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: const CardTheme(
          elevation: 0,
        )
      ),
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          controller: controller,
          //controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: PaginatedDataTable(
            source: data,
            sortColumnIndex: 0,
            rowsPerPage: count,
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('')),
            ],
          ),
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
