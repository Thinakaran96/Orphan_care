import 'package:hive/hive.dart';

part 'trust_emergency_need_model.g.dart';

@HiveType(typeId: 3)
class EmergencyList extends HiveObject {
  @HiveField(0)
  List<TrustEmergencyNeedModel>? emergencyNeedList;

  EmergencyList({this.emergencyNeedList});
}

@HiveType(typeId: 4)
class TrustEmergencyNeedModel extends HiveObject {
  @HiveField(0)
  String? productName;
  @HiveField(1)
  int? quantity;
  @HiveField(2)
  String? unit;

  TrustEmergencyNeedModel({this.unit, this.productName, this.quantity});
}
