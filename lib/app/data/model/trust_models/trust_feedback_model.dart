import 'package:hive/hive.dart';

part 'trust_feedback_model.g.dart';

@HiveType(typeId: 7)
class TrustFeedBackModel extends HiveObject{
  @HiveField(0)
  String? feedBackReview;
  @HiveField(1)
  double? ratingValue;
  @HiveField(2)
  String? trustPhoneNumber;
  @HiveField(3)
  String? averageRating;

  TrustFeedBackModel({
    this.feedBackReview,
    this.ratingValue,
    this.trustPhoneNumber,
    this.averageRating,
  });
}

@HiveType(typeId: 8)
class TrustFeedBackList extends HiveObject {
  @HiveField(0)
  List<TrustFeedBackModel>? feedBackList;

  TrustFeedBackList({this.feedBackList});
}
