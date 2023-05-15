import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/widgets/widgets.dart';

class PaginatorPage extends StatelessWidget {
  const PaginatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());

    application.title = 'Paginator Test';

    return const PaginatorWidget(
      child: Placeholder()
    );
  }
}
