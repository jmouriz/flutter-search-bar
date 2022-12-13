import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarMainWidget extends StatelessWidget {
  SearchBarMainWidget({super.key});

  final _appBar = Get.put(AppBarController());
  final _searchBar = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          SearchBarPopupWidget(),
          const Expanded(
            child: SearchBarInputWidget(),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              int duration = (1 + _searchBar.rows.value) * 32;
              Timer(Duration(milliseconds: duration), () {
                _appBar.searching.value = false;
              });
              _searchBar.rows.value = 0;
            },
          ),
        ],
      ),
    );
  }
}
