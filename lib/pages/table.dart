import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/types/types.dart';
import 'package:toolbar/widgets/widgets.dart';

class TablePage extends StatefulWidget {
  const TablePage({ super.key });

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final toolbar = Get.put(ToolbarController());
  final application = Get.put(ApplicationController());
  final paginator = Get.put(PaginatorController());
  final searchBar = Get.put(SearchBarController());
  int sortColumnIndex = 1;
  bool sortAscending = false;

  @override
  void initState() {
    paginator.page.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    paginator.rows.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    searchBar.version.listen((value) {
      debugPrint(jsonEncode(searchBar.getConditions()));
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
    application.title = 'Search Test';
    application.search = true;
    // final DataTableSource data = DataSource();
    const double headingRowHeight = 56.0;
    const double paginatorHeight = 42.0;
    const double padding = 0.0;
    int rows;

    final List<Map<String, String>> data = List.generate(10000, (index) => {
      'id': index.toString(),
      'user': 'user$index@domain.com',
      'vendor': 'vendor$index@domain.com',
      'price': (Random().nextDouble() * 500).toStringAsFixed(2)
    });

    paginator.count.value = data.length;

    List<Map<String, String>> getData() {
      return [{
        'id': '0'
      }];
    }

    if (paginator.touched) {
      rows = paginator.rows.value;
    } else {
      final MediaQueryData media = MediaQueryData.fromView(View.of(context));
      final double height = media.size.height - media.padding.top -
        kToolbarHeight - 2 * padding - headingRowHeight -
        media.padding.bottom - paginatorHeight;
      rows = (height / kMinInteractiveDimension).round();

      // if (PlatformDetails().isMobile) {
      //   rows -= 2;
      // }
      paginator.rows.value = rows;
      paginator.touched = true;
    }

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

    void sort<T>(Comparable<T> Function(dynamic) field, int column, bool ascending) {
      // debugPrint('sort');
      // debugPrint('$ascending');
      data.sort((a, b) => ascending
        ? a['id']!.compareTo(b['id']!)
        : b['id']!.compareTo(a['id']!));
      debugPrint('$field');
      sortColumnIndex = column;
      sortAscending = ascending;
      setState(() {});
    }

    return PaginatorWidget(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          //child: PaginatedDataTable(
            //rowsPerPage: rows,
          child: DataTable(
            headingRowHeight: headingRowHeight,
            //source: data,
            rows: List.generate(paginator.rows.value, (index) {
              final int row =
                index + (paginator.page.value - 1) * paginator.rows.value;
              Map<String, String> item = data[row];
              return DataRow(cells: [
                DataCell(Text(item['id']!)),
                DataCell(Text(item['user']!)),
                DataCell(Text(item['vendor']!)),
                DataCell(Text(item['price']!)),
                DataCell(IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => debugPrint('Pressed on $index'),
                ))
              ]);
            }),
            sortColumnIndex: sortColumnIndex,
            sortAscending: sortAscending,
            showCheckboxColumn: false,
            columns: [
              const DataColumn(label: Text('#')),
              DataColumn(
                label: const Text('User'),
                onSort: (int columnIndex, bool ascending) =>
                  sort<String>((data) => data, columnIndex, ascending),
                // onSort: (int columnIndex, bool ascending) {
                //   debugPrint('click on sort');
                //   debugPrint('$ascending');
                //   sort<String>((d) => d, columnIndex, ascending);
                // }
              ),
              DataColumn(
                label: const Text('Date'),
                onSort: (int columnIndex, bool ascending) =>
                  sort<String>((data) => data, columnIndex, ascending)
              ),
              const DataColumn(label: Text('Price')),
              const DataColumn(label: Text('')),
            ],
          ),
        ),
      ),
    );
  }
}