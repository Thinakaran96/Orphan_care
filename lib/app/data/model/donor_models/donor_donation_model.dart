import 'package:hive/hive.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';

part 'donor_donation_model.g.dart';

@HiveType(typeId: 12)
class DonorNotificationList extends HiveObject  {
  @HiveField(0)
  List<DonorNotificationModel>? donorNotificationList;

  DonorNotificationList({this.donorNotificationList});
}

@HiveType(typeId: 13)
class DonorNotificationModel {
  @HiveField(0)
  String? requestId;
  @HiveField(1)
  String? date;
  @HiveField(2)
  bool? isAccepted;
  @HiveField(3)
  TrustProfileModel? donorNotificationTrustProfile;

  DonorNotificationModel({this.requestId, this.date, this.isAccepted,this.donorNotificationTrustProfile});
}
