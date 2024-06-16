import 'package:hive/hive.dart';

part 'trust_adopt_request_model.g.dart';

@HiveType(typeId: 5)
class AdoptRequestList extends HiveObject {
  @HiveField(0)
  List<TrustAdoptRequestModel>? adoptRequestList;
}

@HiveType(typeId: 6)
class TrustAdoptRequestModel extends HiveObject {
  @HiveField(0)
  String? lastName;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? dob;
  @HiveField(6)
  String? city;
  @HiveField(7)
  String? annualIncome;
  @HiveField(8)
  String? occupation;
  @HiveField(9)
  String? maritalStatus;
  @HiveField(10)
  String? drivingLic;
  @HiveField(11)
  String? firstName;
  @HiveField(12)
  String? whomAdopt;

  TrustAdoptRequestModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.address,
      this.gender,
      this.dob,
      this.city,
      this.annualIncome,
      this.occupation,
      this.maritalStatus,
      this.drivingLic,
      this.whomAdopt});
}
