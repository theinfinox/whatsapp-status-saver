import 'package:hive_flutter/hive_flutter.dart';
import '../models/status_model.dart';
import '../utils/constants.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StatusModelAdapter());
    await Hive.openBox<StatusModel>(Constants.hiveBoxName);
  }

  static Box<StatusModel> box() => Hive.box<StatusModel>(Constants.hiveBoxName);
}
