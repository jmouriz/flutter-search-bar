import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/app_bar/search_bar/search_bar.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _searchBar = Get.put(SearchBarController());

  @override
  void initState() {
    _searchBar.rows.listen((value) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      _searchBar.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: (1 + _searchBar.rows.value) * kToolbarHeight,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarMainWidget(),
            ...List.generate(_searchBar.rows.value, (index) {
              return SearchBarRowWidget();
            }).toList(),
          ]
        ),
      )
    );
  }
}
