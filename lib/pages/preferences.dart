import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolbar/controllers/controllers.dart';

enum ThemeLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  purple('Purple', Colors.purple);

  const ThemeLabel(this.label, this.color);
  final String label;
  final Color color;
}

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({ super.key });

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late ThemeLabel selected;

  @override
  void initState() {
    selected = ThemeLabel.blue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final application = Get.put(ApplicationController());
    // final TextEditingController controller = TextEditingController();

    application.title = 'Preferences';

    final List<DropdownMenuItem<ThemeLabel>> themes =
      <DropdownMenuItem<ThemeLabel>>[];
    for (final ThemeLabel color in ThemeLabel.values) {
      themes.add(DropdownMenuItem<ThemeLabel>(
        value: color,
        child: Text(color.label),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<ThemeLabel>(
              value: selected,
              items: themes,
              onChanged: (ThemeLabel? theme) =>
                setState(() => selected = theme!),
            ),
          ],
        ),
      ) 
    );
  }
}