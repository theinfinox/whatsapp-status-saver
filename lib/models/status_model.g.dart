// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusModelAdapter extends TypeAdapter<StatusModel> {
  @override
  final int typeId = 0;

  @override
  StatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusModel(
      path: fields[0] as String,
      filename: fields[1] as String,
      savedAt: fields[2] as DateTime,
      pinned: fields[3] as bool,
      isVideo: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StatusModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.filename)
      ..writeByte(2)
      ..write(obj.savedAt)
      ..writeByte(3)
      ..write(obj.pinned)
      ..writeByte(4)
      ..write(obj.isVideo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
