import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:window_manager/window_manager.dart';
import 'package:toolbar/widgets/widgets.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark
    )
  );
  if (!PlatformDetails().isWeb) {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      WidgetsFlutterBinding.ensureInitialized();
      await windowManager.ensureInitialized();
      WindowOptions options = const WindowOptions(
        size: Size(800, 600),
        minimumSize: Size(400, 400),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
        title: 'Demo',
      );
      windowManager.waitUntilReadyToShow(options, () async {
        await windowManager.setAsFrameless();
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
  runApp(const Application(title: 'Demo'));
}