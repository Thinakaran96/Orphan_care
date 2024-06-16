import 'package:hive/hive.dart';

part 'donor_notification_model.g.dart';

@HiveType(typeId: 10)
class DonorDonationList extends HiveObject {
  @HiveField(0)
  List<DonorDonationModel>? donorDonationList;

  DonorDonationList({this.donorDonationList});
}

@HiveType(typeId: 11)
class DonorDonationModel extends HiveObject {
  @HiveField(0)
  String? trustName;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? donationAmount;
  @HiveField(3)
  String? location;

  DonorDonationModel({
    this.trustName,
    this.date,
    this.donationAmount,
    this.location,
  });
}
