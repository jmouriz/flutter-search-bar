import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';
import 'package:toolbar/models/models.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.items,
    this.onSelect,
  });

  final ItemsModel items;
  final Function? onSelect;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          if (item.submenu) {
            debugPrint(item.title);
            debugPrint('${widget.items[index].items}');
          }
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon),
                trailing: item.submenu ? MutableIcon(
                  duration: const Duration(milliseconds: 300),
                  startIcon: Icons.expand_more,
                  endIcon: Icons.expand_less,
                  startIconColor: Colors.black,
                  endIconColor: Colors.black,
                  controller: item.controller,
                  initFrom: item.expanded ? InitFrom.end : InitFrom.start
                ) : null,
                // const Icon(Icons.arrow_drop_up)
                // const Icon(Icons.arrow_drop_down)
                horizontalTitleGap: 0,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0
                ),
                iconColor: Colors.black,
                textColor: Colors.black,
                title: Text(item.title),
                onTap: () {
                  if (item.submenu) {
                    item.expanded
                      ? item.controller.animateToStart()
                      : item.controller.animateToEnd();
                    item.expanded = !item.expanded;
                    setState(() {});
                  } else {
                    if (widget.onSelect != null) {
                      widget.onSelect!(index);
                    }
                  }
                },
              ),
              if (item.submenu && item.expanded)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: MenuWidget(items: item.items),
                )
            ],
          );
        }).toList(),
      ),
    );
  }
}
