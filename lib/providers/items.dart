import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mutable_icon/mutable_icon.dart';

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
    final MutableIconController controller = MutableIconController();
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
        title: 'Paginator',
        icon: Icons.insert_page_break_outlined,
        target: const PaginatorPage()
      ),
      ItemModel(
        title: 'Form Test',
        icon: Icons.edit,
        target: const FormPage()
      ),
      ItemModel(
        title: 'Stepper Form Test',
        icon: Icons.edit,
        target: const StepperPage()
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
            icon: MutableIcon(
              duration: const Duration(milliseconds: 300),
              startIcon: Icons.star_border,
              endIcon: Icons.star,
              startIconColor: Colors.black,
              endIconColor: Colors.black,
              controller: controller,
            ),
            setup: (item, context) {
              item.setted 
                ? controller.setToStart()
                : controller.setToEnd();
            },
            callback: (item, context) {
              Future.delayed(const Duration(milliseconds: 100), () {
                item.setted
                  ? controller.animateToStart()
                  : controller.animateToEnd();
                  item.setted = !item.setted;
              });
              return true;
            }
          ),
          ItemModel(
            title: 'A normal suboption',
            icon: Icons.star_border,
            callback: (item, context) {
              debugPrint('Click on ${item.title}');
              return false;
            }
          ),
          ItemModel(
            title: 'A navigation suboption',
            icon: Icons.star_border,
            callback: (item, context) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              debugPrint('Click on ${item.title}');
            }
          ),
          ItemModel(
            title: 'A suboption',
            icon: Icons.star_border
          ),
        ]),
      ),
      ItemModel(
        title: 'More options adv.',
        icon: Icons.more_vert,
        mode: Mode.replace,
        items: ItemsModel(items: [
          ItemModel(
            title: 'A magic suboption',
            icon: MutableIcon(
              duration: const Duration(milliseconds: 300),
              startIcon: Icons.star_border,
              endIcon: Icons.star,
              startIconColor: Colors.black,
              endIconColor: Colors.black,
              controller: controller,
            ),
            setup: (item, context) {
              item.setted 
                ? controller.setToStart()
                : controller.setToEnd();
            },
            callback: (item, context) {
              Future.delayed(const Duration(milliseconds: 100), () {
                item.setted
                  ? controller.animateToStart()
                  : controller.animateToEnd();
                  item.setted = !item.setted;
              });
              return false;
            }
          ),
          ItemModel(
            title: 'A normal suboption',
            icon: Icons.star_border,
            callback: (item, context) {
              debugPrint('Click on ${item.title}');
              return false;
            }
          ),
          ItemModel(
            title: 'A navigation suboption',
            icon: Icons.star_border,
            callback: (item, context) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              debugPrint('Click on ${item.title}');
            }
          ),
          ItemModel(
            title: 'A suboption',
            icon: Icons.star_border
          ),
        ]),
      ),
      ItemModel(
        title: 'Exit',
        icon: Icons.exit_to_app,
        //visible: PlatformDetails().isDesktop,
        show: (item) => PlatformDetails().isDesktop,
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