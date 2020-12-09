// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopListItemAdapter extends TypeAdapter<ShopListItem> {
  @override
  final typeId = 0;

  @override
  ShopListItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopListItem(
      isDone: fields[0] as bool,
      name: fields[2] as String,
    )..id = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, ShopListItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isDone)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }
}
