// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 8;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      orderNo: fields[0] as String,
      selectedItems: fields[1] as int,
      total: fields[2] as double,
      createAt: fields[3] as DateTime,
      status: fields[4] as String,
      items: (fields[5] as List).cast<CartItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.orderNo)
      ..writeByte(1)
      ..write(obj.selectedItems)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.createAt)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OrderModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
