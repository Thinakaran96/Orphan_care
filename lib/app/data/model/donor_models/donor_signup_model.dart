import 'package:hive/hive.dart';

part 'donor_signup_model.g.dart';

@HiveType(typeId: 9)
class DonorSignUPModel extends HiveObject {
  @HiveField(0)
  String? donorName;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? confirmPassword;
  @HiveField(5)
  String? base64String;
  @HiveField(6)
  String? gender;
  @HiveField(7)
  String? stateName;
  @HiveField(8)
  String? occupation;
  @HiveField(9)
  String? dob;
  @HiveField(10)
  String? maritalStatus;
  @HiveField(11)
  String? address;
  @HiveField(12)
  String? livesIn;

  DonorSignUPModel(
      {this.donorName,
      this.phoneNumber,
      this.email,
      this.password,
      this.confirmPassword,
      this.base64String,
      this.stateName,
      this.gender,
      this.dob,
      this.maritalStatus,
      this.occupation,
      this.address,
      this.livesIn});
}
