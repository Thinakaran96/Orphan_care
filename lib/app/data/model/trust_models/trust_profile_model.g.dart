// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrustProfileModelAdapter extends TypeAdapter<TrustProfileModel> {
  @override
  final int typeId = 2;

  @override
  TrustProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustProfileModel(
      trustName: fields[0] as String?,
      mobNumber: fields[1] as String?,
      email: fields[2] as String?,
      careTakerName: fields[3] as String?,
      onlyFor: fields[4] as String?,
      category: fields[5] as String?,
      membersCount: fields[6] as String?,
      uPIId: fields[7] as String?,
      address: fields[8] as String?,
      stateName: fields[9] as String?,
      status: fields[10] as String?,
      accountNumber: fields[11] as String?,
      base64String: fields[12] as String?,
      password: fields[13] as String?,
      confirmPassword: fields[14] as String?,
      averageStarRating: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustProfileModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.trustName)
      ..writeByte(1)
      ..write(obj.mobNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.careTakerName)
      ..writeByte(4)
      ..write(obj.onlyFor)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.membersCount)
      ..writeByte(7)
      ..write(obj.uPIId)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.stateName)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.accountNumber)
      ..writeByte(12)
      ..write(obj.base64String)
      ..writeByte(13)
      ..write(obj.password)
      ..writeByte(14)
      ..write(obj.confirmPassword)
      ..writeByte(15)
      ..write(obj.averageStarRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
