import 'package:flutter/material.dart';
import 'routes.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Saver',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _mode,
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}