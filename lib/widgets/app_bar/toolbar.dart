import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutable_icon/mutable_icon.dart';
import 'package:toolbar/controllers/controllers.dart';

class ToolbarWidget extends StatefulWidget {
  const ToolbarWidget({ super.key });

  @override
  State<ToolbarWidget> createState() => _ToolbarWidgetState();
}

class _ToolbarWidgetState extends State<ToolbarWidget> {
  final appBar = Get.put(AppBarController());
  final toolbar = Get.put(ToolbarController());
  final sidenav = Get.put(SidenavController());
  final MutableIconController icon = MutableIconController();
  
  @override
  void initState() {
    toolbar.title.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    });
    toolbar.valid.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    });
    toolbar.busy.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    });
    toolbar.search.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    });
    sidenav.open.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          if (sidenav.open.value) {
            icon.animateToEnd();
          } else {
            icon.animateToStart();
          }
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      appBar.dispose();
      toolbar.dispose();
      sidenav.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
            icon: MutableIcon(
              startIcon: Icons.menu,
              endIcon: Icons.close,
              controller: icon,
              size: 28.0,
              duration: const Duration(milliseconds: 400),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              clockwise: false,
              initFrom: sidenav.open.value ? InitFrom.end : InitFrom.start,
            ),
            onPressed: () {
              sidenav.open.value = !sidenav.open.value;
            },
          ),
          Expanded(
            child: Text(
              toolbar.title.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          if (toolbar.busy.value) Padding(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: Colors.grey.shade400,
                //color: Colors.white,
              ),
            ),
          ) else if (toolbar.search.value) IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              appBar.searching.value = true;
            },
          ) else if (toolbar.next != null) IconButton(
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: toolbar.valid.value
                ? Colors.white
                : Colors.grey.shade400,
            ),
            onPressed: toolbar.valid.value ? () {
              toolbar.next!();
            } : null,
          ) else if (toolbar.done != null) IconButton(
            icon: Icon(
              Icons.done,
              color: toolbar.valid.value
                ? Colors.white
                : Colors.grey.shade400,
            ),
            onPressed: toolbar.valid.value ? () {
              toolbar.done!();
            } : null,
          ) else if (toolbar.add != null) IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white
            ),
            onPressed: () => toolbar.add!(),
          ) else const SizedBox(
            width: 48.0,
          ),
        ],
      ),
    );
  }
}