// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimateOrderCart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EstimateOrderCartAdapter extends TypeAdapter<EstimateOrderCart> {
  @override
  final int typeId = 4;

  @override
  EstimateOrderCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EstimateOrderCart(
      id: fields[0] as int?,
      name: fields[1] as String?,
      received: fields[4] as int?,
      netUnitCost: fields[3] as int?,
      discount: fields[7] as int?,
      quantity: fields[2] == null ? 1 : fields[2] as int?,
      batchNo: fields[5] as String?,
      expireDate: fields[6] as String?,
      imeiNumber: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EstimateOrderCart obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.netUnitCost)
      ..writeByte(4)
      ..write(obj.received)
      ..writeByte(5)
      ..write(obj.batchNo)
      ..writeByte(6)
      ..write(obj.expireDate)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.imeiNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstimateOrderCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
