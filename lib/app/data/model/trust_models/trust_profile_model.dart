import 'package:hive/hive.dart';

part 'trust_profile_model.g.dart';

@HiveType(typeId: 2)
class TrustProfileModel extends HiveObject {
  @HiveField(0)
  String? trustName;
  @HiveField(1)
  String? mobNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? careTakerName;
  @HiveField(4)
  String? onlyFor;
  @HiveField(5)
  String? category;
  @HiveField(6)
  String? membersCount;
  @HiveField(7)
  String? uPIId;
  @HiveField(8)
  String? address;
  @HiveField(9)
  String? stateName;
  @HiveField(10)
  String? status;
  @HiveField(11)
  String? accountNumber;
  @HiveField(12)
  String? base64String;
  @HiveField(13)
  String? password;
  @HiveField(14)
  String? confirmPassword;
  @HiveField(15)
  String? averageStarRating;

  TrustProfileModel(
      {this.trustName,
      this.mobNumber,
      this.email,
      this.careTakerName,
      this.onlyFor,
      this.category,
      this.membersCount,
      this.uPIId,
      this.address,
      this.stateName,
      this.status,
      this.accountNumber,
      this.base64String,
      this.password,
      this.confirmPassword,
      this.averageStarRating});
}
