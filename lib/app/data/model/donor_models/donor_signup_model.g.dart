// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_signup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonorSignUPModelAdapter extends TypeAdapter<DonorSignUPModel> {
  @override
  final int typeId = 9;

  @override
  DonorSignUPModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorSignUPModel(
      donorName: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      password: fields[3] as String?,
      confirmPassword: fields[4] as String?,
      base64String: fields[5] as String?,
      stateName: fields[7] as String?,
      gender: fields[6] as String?,
      dob: fields[9] as String?,
      maritalStatus: fields[10] as String?,
      occupation: fields[8] as String?,
      address: fields[11] as String?,
      livesIn: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DonorSignUPModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.donorName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.confirmPassword)
      ..writeByte(5)
      ..write(obj.base64String)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.stateName)
      ..writeByte(8)
      ..write(obj.occupation)
      ..writeByte(9)
      ..write(obj.dob)
      ..writeByte(10)
      ..write(obj.maritalStatus)
      ..writeByte(11)
      ..write(obj.address)
      ..writeByte(12)
      ..write(obj.livesIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorSignUPModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
