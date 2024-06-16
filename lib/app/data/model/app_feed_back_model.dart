import 'package:hive/hive.dart';

part 'app_feed_back_model.g.dart';

@HiveType(typeId: 16)
class AppFeedBackList extends HiveObject {
  @HiveField(0)
  List<AppFeedBackModel>? appFeedBackList;

  AppFeedBackList({this.appFeedBackList});
}

@HiveType(typeId: 17)
class AppFeedBackModel extends HiveObject {
  @HiveField(0)
  String? feedBackReview;
  @HiveField(1)
  double? ratingValue;
  @HiveField(2)
  String? phoneNumber;
  @HiveField(3)
  String? averageRating;
  @HiveField(4)
  String? name;

  AppFeedBackModel({
    this.feedBackReview,
    this.ratingValue,
    this.phoneNumber,
    this.averageRating,
    this.name,
  });
}
