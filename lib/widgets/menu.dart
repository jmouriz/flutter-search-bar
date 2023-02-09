import 'package:flutter/material.dart';
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
    return ListView.builder(
      itemCount: widget.items.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: Icon(widget.items[index].icon),
              trailing: widget.items[index].submenu
                ? const Icon(Icons.arrow_drop_down)
                : null,
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              title: Text(widget.items[index].title),
              onTap: () {
                if (widget.items[index].submenu) {
                  widget.items[index].expanded = !widget.items[index].expanded;
                  setState(() {});
                } else {
                  if (widget.onSelect != null) {
                    widget.onSelect!(index);
                  }
                }
              },
            ),
            if (widget.items[index].submenu && widget.items[index].expanded)
              const Text('Submenu')
          ],
        );
      },
    );
  }
}
