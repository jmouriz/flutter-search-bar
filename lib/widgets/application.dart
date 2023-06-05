import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toolbar/providers/providers.dart';
import 'package:toolbar/widgets/widgets.dart';

class ScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class Application extends StatelessWidget {
  const Application({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeProvider().theme,
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      scrollBehavior: ScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:  const [
        Locale('es', 'AR'),
        Locale('en'),
      ],
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ThemeProvider().background,
        body: const BodyWidget(),
      )
    );
  }
}