import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';
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

    if (paginator.touched) {
      rows = paginator.rows.value;
    } else {
      final MediaQueryData media = MediaQuery.of(context);
      final double height = media.size.height - media.padding.top -
        kToolbarHeight - 2 * padding - headingRowHeight -
        media.padding.bottom - paginatorHeight;
      rows = (height / kMinInteractiveDimension).floor();

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

    int sortColumnIndex = 1;
    bool sortAscending = true;

    void sort<T>(Comparable<T> Function(dynamic d) getField, int columnIndex, bool ascending) {
      //_data._sort<T>(getField, ascending);
      setState(() {
        sortColumnIndex = columnIndex;
        sortAscending = ascending;
      });
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
              final int id =
                index + (paginator.page.value - 1) * paginator.rows.value;
              final String price =
                (Random().nextDouble() * 500).toStringAsFixed(2);
              return DataRow(cells: [
                DataCell(Text('$id')),
                DataCell(Text('user$id@domain.com')),
                DataCell(Text('vendor$id@domain.com')),
                DataCell(Text(price)),
                DataCell(IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    debugPrint('Pressed on $index');
                  },
                )),
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
                  sort<String>((d) => d, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Date'),
                onSort: (int columnIndex, bool ascending) =>
                  sort<String>((d) => d, columnIndex, ascending)
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

// class DataSource extends DataTableSource {
//   final List<Map<String, dynamic>> _data = List.generate(
//     1000,
//     (index) => {
//       'id': index,
//       'user': 'user$index@domain.com',
//       'vendor': 'vendor$index@domain.com',
//       'price': Random().nextDouble() * 500,
//     }
//   );

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => _data.length;

//   @override
//   int get selectedRowCount => 0;

//   @override
//   DataRow getRow(int index) {
//     return DataRow(cells: [
//       DataCell(Text(_data[index]['id'].toString())),
//       DataCell(Text(_data[index]['user'])),
//       DataCell(Text(_data[index]['vendor'])),
//       DataCell(Text(_data[index]['price'].toStringAsFixed(2))),
//       DataCell(
//         IconButton(
//           icon: const Icon(Icons.more_vert),
//           onPressed:() {
//             debugPrint('Pressed on $index');
//           },
//         )
//       ),
//     ]);
//   }
// }
