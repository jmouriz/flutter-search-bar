import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarMainWidget extends StatelessWidget {
  SearchBarMainWidget({ super.key });

  final appBar = Get.put(AppBarController());
  final searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          SearchBarPopupWidget(index: 0),
          Expanded(
            child: SearchBarInputWidget(condition: searchBar.getCondition(0)!),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              int duration = (1 + searchBar.rows.value) * 32;
              Timer(Duration(milliseconds: duration), () {
                appBar.searching.value = false;
              });
              searchBar.rows.value = 0;
              //_searchBar.init();
            },
          ),
        ],
      ),
    );
  }
}
