import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/model/app_feed_back_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_donation_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_notification_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_adopt_request_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_donation_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_feedback_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:path_provider/path_provider.dart';

class CommonController extends GetxController {
  Future initializeHive() async {
    await Hive.initFlutter();
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter<DonorDonationList>(DonorDonationListAdapter());
    Hive.registerAdapter<DonorNotificationList>(DonorNotificationListAdapter());
    Hive.registerAdapter<DonorNotificationModel>(
        DonorNotificationModelAdapter());
    Hive.registerAdapter<DonorDonationModel>(DonorDonationModelAdapter());
    Hive.registerAdapter<DonorSignUPModel>(DonorSignUPModelAdapter());
    Hive.registerAdapter<AdoptRequestList>(AdoptRequestListAdapter());
    Hive.registerAdapter<EmergencyList>(EmergencyListAdapter());
    Hive.registerAdapter<TrustProfileModel>(TrustProfileModelAdapter());
    Hive.registerAdapter<TrustEmergencyNeedModel>(
        TrustEmergencyNeedModelAdapter());
    Hive.registerAdapter<TrustDonationModel>(TrustDonationModelAdapter());
    Hive.registerAdapter<TrustAdoptRequestModel>(
        TrustAdoptRequestModelAdapter());
    Hive.registerAdapter<TrustFeedBackModel>(TrustFeedBackModelAdapter());
    Hive.registerAdapter<TrustDonationList>(TrustDonationListAdapter());
    Hive.registerAdapter<TrustFeedBackList>(TrustFeedBackListAdapter());
    Hive.registerAdapter<AppFeedBackList>(AppFeedBackListAdapter());
    Hive.registerAdapter<AppFeedBackModel>(AppFeedBackModelAdapter());
    await openDataBase(Constants.orphanDataBase);
  }

  final _ratingValue = 1.0.obs;

  double get ratingValue => _ratingValue.value;

  set ratingValue(double value) => _ratingValue.value = value;

  Future openDataBase(String dataBaseName) async =>
      await Hive.openBox(dataBaseName);

  Future<void> addDataToDataBase(var data, String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.add(data);
  }

  Future<void> putDataBaseByKey(
      var data, String dataBaseName, String keyValue) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.put(keyValue, data);
  }

  getDataBaseByKey(String dataBaseName, String keyValue) {
    dynamic value;
    var dataBase = Hive.box(dataBaseName);
    try {
      if (dataBase.containsKey(keyValue)) {
        value = dataBase.get(keyValue);
      } else {
        return;
      }
    } catch (err) {
      return;
    }

    return value;
  }

  bool checkKeyContainsInDataBase(String dataBaseName, String keyValue) {
    var dataBase = Hive.box(dataBaseName);
    return dataBase.containsKey(keyValue);
  }

  Future<void> putAtDataBaseIndex(
      var data, String dataBaseName, int index) async {
    var dataBase = Hive.box(dataBaseName);

    await dataBase.putAt(0, data);
  }

  Future<void> deleteValueDataBaseIndexByKey(
      String dataBaseName, String keyValue) async {
    var dataBase = Hive.box(dataBaseName);

    await dataBase.delete(keyValue);
  }

  Future<void> closeDataBase(String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.close();
  }

  Future<void> clearDataBase(String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.clear();
  }
}
