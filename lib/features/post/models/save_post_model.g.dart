// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavePostModelAdapter extends TypeAdapter<SavePostModel> {
  @override
  final int typeId = 0;

  @override
  SavePostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavePostModel(
      id: fields[0] as String,
      post_id: fields[1] as String,
      user_id: fields[2] as String,
      created_at: fields[3] as DateTime,
      updated_at: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SavePostModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.post_id)
      ..writeByte(2)
      ..write(obj.user_id)
      ..writeByte(3)
      ..write(obj.created_at)
      ..writeByte(4)
      ..write(obj.updated_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavePostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
