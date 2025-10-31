import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import '../utils/constants.dart';

class FileService {
  /// Returns list of found files in WhatsApp statuses directories.
  static Future<List<File>> scanWhatsAppStatuses() async {
    final List<File> found = [];

    // Request storage permission if needed
    final status = await Permission.storage.request();
    if (!status.isGranted && !status.isLimited) return found;

    // Attempt to scan predefined paths
    for (final pth in Constants.whatsappPaths) {
      try {
        final dir = Directory('/storage/emulated/0$pth');
        if (await dir.exists()) {
          final list = dir.listSync().whereType<File>().toList();
          found.addAll(list);
        }
      } catch (_) {
        // ignore path errors
      }
    }

    // Fallback paths (if necessary)
    for (final pth in Constants.whatsappPaths) {
      try {
        final dir = Directory('/storage/emulated/0/$pth');
        if (await dir.exists()) {
          final list = dir.listSync().whereType<File>().toList();
          found.addAll(list);
        }
      } catch (_) {}
    }

    // Filter duplicates and only images/videos
    final filtered = found.where((f) {
      final ext = p.extension(f.path).toLowerCase();
      return ['.jpg', '.jpeg', '.png', '.mp4', '.mov', '.gif', '.webp'].contains(ext);
    }).toList();

    return filtered;
  }

  /// Copies file to app folder and returns destination path
  static Future<String?> saveToAppFolder(File source) async {
    try {
      final targetDir = Directory(Constants.appSaveFolder);
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final filename = p.basename(source.path);
      final dest = File(p.join(targetDir.path, filename));
      if (await dest.exists()) {
        // add suffix
        final name = p.basenameWithoutExtension(filename);
        final ext = p.extension(filename);
        final newName = '${name}_${DateTime.now().millisecondsSinceEpoch}$ext';
        return (await source.copy(p.join(targetDir.path, newName))).path;
      } else {
        return (await source.copy(dest.path)).path;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteFile(String path) async {
    try {
      final f = File(path);
      if (await f.exists()) {
        await f.delete();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
