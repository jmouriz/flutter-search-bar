import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider {
  static final ThemeProvider _singleton = ThemeProvider._internal();
  static late Brightness brightness;
  factory ThemeProvider() {
    brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
    brightness = Brightness.light; // TODO
    return _singleton;
  }
  ThemeProvider._internal();

  MaterialColor primary = Colors.purple;

  dynamic theme = ThemeData(
    primarySwatch: Colors.purple, // ThemeProvider().primary,
  );

  Color get card => brightness == Brightness.dark
    ? Colors.black
    : Colors.white;

  Color get foreground => brightness == Brightness.dark
    ? Colors.white
    : Colors.black;

  Color get background => brightness == Brightness.dark
    ? const Color.fromARGB(255, 45, 53, 65)
    // : theme.primarySwatch.shade50;
    : primary.shade50;
}