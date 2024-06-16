// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_adopt_request_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdoptRequestListAdapter extends TypeAdapter<AdoptRequestList> {
  @override
  final int typeId = 5;

  @override
  AdoptRequestList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdoptRequestList()
      ..adoptRequestList = (fields[0] as List?)?.cast<TrustAdoptRequestModel>();
  }

  @override
  void write(BinaryWriter writer, AdoptRequestList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.adoptRequestList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdoptRequestListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrustAdoptRequestModelAdapter
    extends TypeAdapter<TrustAdoptRequestModel> {
  @override
  final int typeId = 6;

  @override
  TrustAdoptRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustAdoptRequestModel(
      firstName: fields[11] as String?,
      lastName: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      address: fields[3] as String?,
      gender: fields[4] as String?,
      dob: fields[5] as String?,
      city: fields[6] as String?,
      annualIncome: fields[7] as String?,
      occupation: fields[8] as String?,
      maritalStatus: fields[9] as String?,
      drivingLic: fields[10] as String?,
      whomAdopt: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustAdoptRequestModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.lastName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.annualIncome)
      ..writeByte(8)
      ..write(obj.occupation)
      ..writeByte(9)
      ..write(obj.maritalStatus)
      ..writeByte(10)
      ..write(obj.drivingLic)
      ..writeByte(11)
      ..write(obj.firstName)
      ..writeByte(12)
      ..write(obj.whomAdopt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustAdoptRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
