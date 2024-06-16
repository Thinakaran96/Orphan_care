// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_feedback_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrustFeedBackModelAdapter extends TypeAdapter<TrustFeedBackModel> {
  @override
  final int typeId = 7;

  @override
  TrustFeedBackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustFeedBackModel(
      feedBackReview: fields[0] as String?,
      ratingValue: fields[1] as double?,
      trustPhoneNumber: fields[2] as String?,
      averageRating: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrustFeedBackModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.feedBackReview)
      ..writeByte(1)
      ..write(obj.ratingValue)
      ..writeByte(2)
      ..write(obj.trustPhoneNumber)
      ..writeByte(3)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustFeedBackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrustFeedBackListAdapter extends TypeAdapter<TrustFeedBackList> {
  @override
  final int typeId = 8;

  @override
  TrustFeedBackList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrustFeedBackList(
      feedBackList: (fields[0] as List?)?.cast<TrustFeedBackModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrustFeedBackList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.feedBackList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrustFeedBackListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
