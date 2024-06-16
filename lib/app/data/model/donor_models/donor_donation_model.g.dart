// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_donation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonorNotificationListAdapter extends TypeAdapter<DonorNotificationList> {
  @override
  final int typeId = 12;

  @override
  DonorNotificationList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorNotificationList(
      donorNotificationList:
          (fields[0] as List?)?.cast<DonorNotificationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DonorNotificationList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.donorNotificationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorNotificationListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DonorNotificationModelAdapter
    extends TypeAdapter<DonorNotificationModel> {
  @override
  final int typeId = 13;

  @override
  DonorNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorNotificationModel(
      requestId: fields[0] as String?,
      date: fields[1] as String?,
      isAccepted: fields[2] as bool?,
      donorNotificationTrustProfile: fields[3] as TrustProfileModel?,
    );
  }

  @override
  void write(BinaryWriter writer, DonorNotificationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.requestId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isAccepted)
      ..writeByte(3)
      ..write(obj.donorNotificationTrustProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
