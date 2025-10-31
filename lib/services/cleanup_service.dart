import 'dart:io';
import '../models/status_model.dart'; // ✅ Needed import
import '../utils/constants.dart';
import 'hive_service.dart';

class CleanupService {
  static Future<void> runCleanupTask() async {
    final box = HiveService.box();
    final now = DateTime.now();
    final keysToDelete = <dynamic>[];

    for (final key in box.keys) {
      final StatusModel st = box.get(key) as StatusModel;
      if (st.pinned) continue;

      final diff = now.difference(st.savedAt).inDays;
      if (diff >= Constants.retentionDays) {
        // Delete file from disk
        final f = File(st.path);
        if (f.existsSync()) {
          try {
            f.deleteSync();
          } catch (_) {}
        }
        keysToDelete.add(key);
      }
    }

    for (final k in keysToDelete) {
      box.delete(k);
    }
  }
}
