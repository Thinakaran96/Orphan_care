// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_emergency_need_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyListAdapter extends TypeAdapter<EmergencyList> {
  @override
  final int typeId = 3;

  @override
  EmergencyList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyList(
      emergencyNeedList: (fields[0] as List?)?.cast<TrustEmergencyNeedModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.emergencyNeedList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrustEmergencyNeedModelAdapter
    extends TypeAdapter<TrustEmergencyNeedModel> {
  @override
  final int typeId = 4;

  @override
  TrustEmergencyNeedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustEmergencyNeedModel(
      unit: fields[2] as String?,
      productName: fields[0] as String?,
      quantity: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustEmergencyNeedModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustEmergencyNeedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
