import 'dart:io';
import 'package:flutter/material.dart';
import '../models/status_model.dart';
import '../services/file_service.dart';
import '../services/hive_service.dart';
import 'package:path/path.dart' as p;

class StatusController extends ChangeNotifier {
  List<StatusModel> saved = [];

  StatusController() {
    _loadSaved();
  }

  void _loadSaved() {
    final box = HiveService.box();
    saved = [];

    for (final k in box.keys) {
      final StatusModel? st = box.get(k);
      if (st != null) saved.add(st);
    }

    notifyListeners();
  }

  Future<List<File>> scan() async {
    final files = await FileService.scanWhatsAppStatuses();
    return files;
  }

  Future<StatusModel?> saveFile(File file) async {
    final destPath = await FileService.saveToAppFolder(file);
    if (destPath == null) return null;
    final model = StatusModel(
      path: destPath,
      filename: p.basename(destPath),
      savedAt: DateTime.now(),
      isVideo: p.extension(destPath).toLowerCase() == '.mp4',
    );
    final box = HiveService.box();
    await box.add(model);
    _loadSaved();
    return model;
  }

  Future<bool> deleteSaved(StatusModel model) async {
    try {
      await FileService.deleteFile(model.path);
      await model.delete();
      _loadSaved();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> togglePin(StatusModel model) async {
    model.pinned = !model.pinned;
    await model.save();
    _loadSaved();
  }
}
