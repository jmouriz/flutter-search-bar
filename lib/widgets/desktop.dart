import 'package:flutter/material.dart';
import 'package:toolbar/models/models.dart';
import 'package:toolbar/providers/providers.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    ItemsModel items = DesktopProvider().items;

    return Center(
      child: GridView.extent(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200.0,
        children: [
          ...List.generate(items.length, (index) {
            ItemModel item = items[index];
            // bool call = true;
            return item.visible ? InkWell(
              onTap: () {
                // if (item.setup != null) {
                //   call = item.setup!(item, context);
                // }
                // if (call && item.callback != null) {
                //   debugPrint('X');
                //   item.callback!(item, context);
                // }
              },
              child: DekstopItem(icon: item.icon, label: item.title)
            ) : const SizedBox.shrink();
          }),
        ],
      )
    );
  }
}

class DekstopItem extends StatelessWidget {
  const DekstopItem({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.labelMedium;

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      color: ThemeProvider().card,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 64.0, color: style!.color),
            Text(label, style: style),
          ]
        ),
      )
    );
  }
}