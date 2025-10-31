import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/hive_service.dart';
import 'controllers/status_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => StatusController())],
    child: const App(),
  ));
}