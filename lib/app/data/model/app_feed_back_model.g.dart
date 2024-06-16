// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_feed_back_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppFeedBackListAdapter extends TypeAdapter<AppFeedBackList> {
  @override
  final int typeId = 16;

  @override
  AppFeedBackList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppFeedBackList(
      appFeedBackList: (fields[0] as List?)?.cast<AppFeedBackModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppFeedBackList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.appFeedBackList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppFeedBackListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppFeedBackModelAdapter extends TypeAdapter<AppFeedBackModel> {
  @override
  final int typeId = 17;

  @override
  AppFeedBackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppFeedBackModel(
      feedBackReview: fields[0] as String?,
      ratingValue: fields[1] as double?,
      phoneNumber: fields[2] as String?,
      averageRating: fields[3] as String?,
      name: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppFeedBackModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.feedBackReview)
      ..writeByte(1)
      ..write(obj.ratingValue)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.averageRating)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppFeedBackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
