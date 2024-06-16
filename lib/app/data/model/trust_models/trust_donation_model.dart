import 'package:hive/hive.dart';

part 'trust_donation_model.g.dart';

@HiveType(typeId: 14)
class TrustDonationModel extends HiveObject {
  @HiveField(0)
  String? donorName;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? amount;
  @HiveField(3)
  String? contactNumber;
  @HiveField(4)
  String? base64String;

  TrustDonationModel(
      {this.donorName,
      this.date,
      this.amount,
      this.contactNumber,
      this.base64String});
}

@HiveType(typeId: 15)
class TrustDonationList extends HiveObject {
  @HiveField(0)
  List<TrustDonationModel>? trustDonationList;

  TrustDonationList({this.trustDonationList});
}

