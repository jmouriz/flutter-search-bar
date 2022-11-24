import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarMainWidget extends StatelessWidget {
  SearchBarMainWidget({super.key});

  final _controller = Get.put(AppBarController());
  final _searchbar = Get.put(SearchBarController());

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
              Timer(Duration(milliseconds: 35 * _searchbar.rows.value), () {
                _controller.searching.value = !_controller.searching.value;
              });
              _searchbar.rows.value = 1;
            },
          ),
        ],
      ),
    );
  }
}
