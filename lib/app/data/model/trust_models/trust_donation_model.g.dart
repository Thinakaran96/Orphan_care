// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_donation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrustDonationModelAdapter extends TypeAdapter<TrustDonationModel> {
  @override
  final int typeId = 14;

  @override
  TrustDonationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustDonationModel(
      donorName: fields[0] as String?,
      date: fields[1] as String?,
      amount: fields[2] as String?,
      contactNumber: fields[3] as String?,
      base64String: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustDonationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.donorName)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.contactNumber)
      ..writeByte(4)
      ..write(obj.base64String);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustDonationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrustDonationListAdapter extends TypeAdapter<TrustDonationList> {
  @override
  final int typeId = 15;

  @override
  TrustDonationList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustDonationList(
      trustDonationList: (fields[0] as List?)?.cast<TrustDonationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrustDonationList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.trustDonationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustDonationListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
