import 'package:flutter/material.dart';
import 'package:toolbar/models/models.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.items,
    this.onSelect,
  });

  final ItemsModel items;
  final Function? onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(items[index].icon),
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0
          ),
          iconColor: Colors.black,
          textColor: Colors.black,
          title: Text(items[index].title),
          onTap: () {
            if (onSelect != null) {
              onSelect!(index);
            }
          },
        );
      },
    );
  }
}
