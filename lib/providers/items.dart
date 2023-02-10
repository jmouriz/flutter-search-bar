import 'package:flutter/material.dart';

import 'package:toolbar/models/models.dart';
import 'package:toolbar/pages/pages.dart';
import 'package:toolbar/providers/providers.dart';

class ItemsProvider {
  static final ItemsProvider _singleton = ItemsProvider._internal();
  static final ItemsModel _items = ItemsModel();
  /*
  static final ItemsModel _items = ItemsModel(items: [
    ItemModel(
      title: 'Home',
      icon: Icons.home,
      target: const HomePage()
    ),
    ItemModel(
      title: 'Search Test',
      icon: Icons.list,
      target: const TablePage()
    ),
    ItemModel(
      title: 'Bottom Sheet Test',
      icon: Icons.keyboard_capslock,
      target: const BottomSheetPage()
    ),
    ItemModel(
      title: 'Alerts Test',
      icon: Icons.notifications,
      target: const AlertsPage()
    ),
    ItemModel(
      title: 'Large Text Test',
      icon: Icons.text_snippet,
      target: const InfoPage()
    ),
    ItemModel(
      title: 'About This App',
      icon: Icons.info,
      target: const AboutPage()
    ),
    ItemModel(
      title: 'More options',
      icon: Icons.more_vert,
      items: ItemsModel(items: [
        ItemModel(
          title: 'A suboption',
          icon: Icons.star_border
        ),
        ItemModel(
          title: 'A suboption',
          icon: Icons.star_border
        ),
        ItemModel(
          title: 'A suboption',
          icon: Icons.star_border
        ),
        ItemModel(
          title: 'A suboption',
          icon: Icons.star_border
        ),
      ]),
    ),
    if (PlatformDetails().isDesktop) ItemModel(
      title: 'Exit',
      icon: Icons.exit_to_app,
    ),
    ItemModel(title: 'Another option', icon: Icons.star),
    ItemModel(title: 'Another option', icon: Icons.star),
    ItemModel(title: 'Another option', icon: Icons.star),
    ItemModel(title: 'Another option', icon: Icons.star),
    ItemModel(title: 'Another option', icon: Icons.star),
  ]);
  */
  factory ItemsProvider() {
    _items.clear();
    _items.addAll([
      ItemModel(
        title: 'Home',
        icon: Icons.home,
        target: const HomePage()
      ),
      ItemModel(
        title: 'Search Test',
        icon: Icons.list,
        target: const TablePage()
      ),
      ItemModel(
        title: 'Bottom Sheet Test',
        icon: Icons.keyboard_capslock,
        target: const BottomSheetPage()
      ),
      ItemModel(
        title: 'Alerts Test',
        icon: Icons.notifications,
        badge: 2,
        target: const AlertsPage()
      ),
      ItemModel(
        title: 'Large Text Test',
        icon: Icons.text_snippet,
        target: const InfoPage()
      ),
      ItemModel(
        title: 'About This App',
        icon: Icons.info,
        target: const AboutPage()
      ),
      ItemModel(
        title: 'More options',
        icon: Icons.more_vert,
        items: ItemsModel(items: [
          ItemModel(
            title: 'A magic suboption',
            icon: Icons.star_border,
            callback: (item) {
              if (item.icon == Icons.star) {
                item.icon = Icons.star_border;
              } else {
                item.icon = Icons.star;
              }
              return true;
            }
          ),
          ItemModel(
            title: 'A normal suboption',
            icon: Icons.star_border,
            callback: (item) {
              debugPrint('Click on ${item.title}');
              return false;
            }
          ),
          ItemModel(
            title: 'A error suboption',
            icon: Icons.star_border,
            callback: (item) {
              debugPrint('Click on ${item.title}');
            }
          ),
          ItemModel(
            title: 'A suboption',
            icon: Icons.star_border
          ),
        ]),
      ),
      if (PlatformDetails().isDesktop) ItemModel(
        title: 'Exit',
        icon: Icons.exit_to_app,
      ),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
      ItemModel(title: 'Another option', icon: Icons.star),
    ]);
    return _singleton;
  }
  ItemsProvider._internal();
  ItemsModel get items => _items;
}