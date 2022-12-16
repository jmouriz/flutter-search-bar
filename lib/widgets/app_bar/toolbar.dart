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
  final _appBar = Get.put(AppBarController());
  final _toolbar = Get.put(ToolbarController());
  final _sidenav = Get.put(SidenavController());
  final MutableIconController _icon = MutableIconController();
  
  @override
  void initState() {
    _toolbar.search.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    });
    _sidenav.open.listen((value) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          if (_sidenav.open.value) {
            _icon.animateToEnd();
          } else {
            _icon.animateToStart();
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
      _appBar.dispose();
      _toolbar.dispose();
      _sidenav.dispose();
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
              controller: _icon,
              size: 28.0,
              duration: const Duration(milliseconds: 400),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              clockwise: false,
              initFrom: InitFrom.start,
            ),
            onPressed: () {
              _sidenav.open.value = !_sidenav.open.value;
            },
          ),
          const Expanded(
            child: Text(
              'SearchBar Widget Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          if (_toolbar.search.value) IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              _appBar.searching.value = true;
            },
          ) else const SizedBox(
            width: 48.0,
          ),
        ],
      ),
    );
  }
}
