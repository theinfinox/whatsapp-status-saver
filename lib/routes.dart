import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/preview_screen.dart';
import 'ui/screens/settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const HomeScreen(),
  '/preview': (_) => const PreviewScreen(),
  '/settings': (_) => const SettingsScreen(),
};