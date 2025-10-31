import 'package:hive/hive.dart';

part 'status_model.g.dart';

@HiveType(typeId: 0)
class StatusModel extends HiveObject {
  @HiveField(0)
  String path;

  @HiveField(1)
  String filename;

  @HiveField(2)
  DateTime savedAt;

  @HiveField(3)
  bool pinned;

  @HiveField(4)
  bool isVideo;

  StatusModel({
    required this.path,
    required this.filename,
    required this.savedAt,
    this.pinned = false,
    this.isVideo = false,
  });
}
