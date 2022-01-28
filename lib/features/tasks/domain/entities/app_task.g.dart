// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppTaskAdapter extends TypeAdapter<AppTask> {
  @override
  final int typeId = 0;

  @override
  AppTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppTask(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      isDone: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
