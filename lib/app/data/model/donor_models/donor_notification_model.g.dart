// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonorDonationListAdapter extends TypeAdapter<DonorDonationList> {
  @override
  final int typeId = 10;

  @override
  DonorDonationList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorDonationList(
      donorDonationList: (fields[0] as List?)?.cast<DonorDonationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DonorDonationList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.donorDonationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorDonationListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DonorDonationModelAdapter extends TypeAdapter<DonorDonationModel> {
  @override
  final int typeId = 11;

  @override
  DonorDonationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorDonationModel(
      trustName: fields[0] as String?,
      date: fields[1] as String?,
      donationAmount: fields[2] as String?,
      location: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DonorDonationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trustName)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.donationAmount)
      ..writeByte(3)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorDonationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
