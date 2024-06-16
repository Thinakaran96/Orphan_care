import 'package:get/get.dart';
import 'package:orphan_care/app/data/model/app_feed_back_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_adopt_request_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_donation_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_feedback_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';

class TrustController extends GetxController {
  final _trustProfileImageValue = "".obs;

  String get trustProfileImageValue => _trustProfileImageValue.value;

  set trustProfileImageValue(String value) =>
      _trustProfileImageValue.value = value;

  final _getEmergencyDataLoading = false.obs;

  bool get getEmergencyDataLoading => _getEmergencyDataLoading.value;

  set getEmergencyDataLoading(bool value) =>
      _getEmergencyDataLoading.value = value;

  final _trustSignInLoading = false.obs;

  bool get trustSignInLoading => _trustSignInLoading.value;

  set trustSignInLoading(bool value) => _trustSignInLoading.value = value;

  final _getProfileLoading = false.obs;

  bool get getProfileLoading => _getProfileLoading.value;

  set getProfileLoading(bool value) => _getProfileLoading.value = value;

  final _trustUpdateLoading = false.obs;

  bool get trustUpdateLoading => _trustUpdateLoading.value;

  set trustUpdateLoading(bool value) => _trustUpdateLoading.value = value;

  final _notificationUpdateLoading = false.obs;

  bool get notificationUpdateLoading => _notificationUpdateLoading.value;

  set notificationUpdateLoading(bool value) =>
      _notificationUpdateLoading.value = value;

  final _trustProfileModel = TrustProfileModel().obs;

  TrustProfileModel get trustProfileModel => _trustProfileModel.value;

  set trustProfileModel(TrustProfileModel value) =>
      _trustProfileModel.value = value;

  final _emergencyList = EmergencyList().obs;

  EmergencyList get emergencyList => _emergencyList.value;

  set emergencyList(EmergencyList value) => _emergencyList.value = value;

  final _getTrustAdoptRequestLoading = false.obs;

  bool get getTrustAdoptRequestLoading => _getTrustAdoptRequestLoading.value;

  set getTrustAdoptRequestLoading(bool value) =>
      _getTrustAdoptRequestLoading.value = value;

  final _trustAdoptRequestModel = TrustAdoptRequestModel().obs;

  TrustAdoptRequestModel get trustAdoptRequestModel =>
      _trustAdoptRequestModel.value;

  set trustAdoptRequestModel(TrustAdoptRequestModel value) =>
      _trustAdoptRequestModel.value = value;

  final _localTrustList = <TrustProfileModel>[].obs;

  List<TrustProfileModel> get localTrustList => _localTrustList;

  set localTrustList(List<TrustProfileModel> value) =>
      _localTrustList.value = value;

  final _trustAdoptRequestList = <TrustAdoptRequestModel>[].obs;

  List<TrustAdoptRequestModel> get trustAdoptRequestList =>
      _trustAdoptRequestList;

  set trustAdoptRequestList(List<TrustAdoptRequestModel> value) =>
      _trustAdoptRequestList.value = value;

  final _trustDonationHistoryList = <TrustDonationModel>[].obs;

  List<TrustDonationModel> get trustDonationHistoryList =>
      _trustDonationHistoryList;

  set trustDonationHistoryList(List<TrustDonationModel> value) =>
      _trustDonationHistoryList.value = value;

  final _getTrustDonationHistoryLoading = false.obs;

  bool get getTrustDonationHistoryLoading =>
      _getTrustDonationHistoryLoading.value;

  set getTrustDonationHistoryLoading(bool value) =>
      _getTrustDonationHistoryLoading.value = value;

  final _getTrustLoading = false.obs;

  bool get getTrustLoading => _getTrustLoading.value;

  set getTrustLoading(bool value) => _getTrustLoading.value = value;

  final _categoryByTrustList = <TrustProfileModel>[].obs;

  List<TrustProfileModel> get categoryByTrustList => _categoryByTrustList;

  set categoryByTrustList(List<TrustProfileModel> value) =>
      _categoryByTrustList.value = value;

  final _trustFeedBackHistoryList = <TrustFeedBackModel>[].obs;

  List<TrustFeedBackModel> get trustFeedBackHistoryList =>
      _trustFeedBackHistoryList;

  set trustFeedBackHistoryList(List<TrustFeedBackModel> value) =>
      _trustFeedBackHistoryList.value = value;

  final _getTrustFeedBackHistoryLoading = false.obs;

  bool get getTrustFeedBackHistoryLoading =>
      _getTrustFeedBackHistoryLoading.value;

  set getTrustFeedBackHistoryLoading(bool value) =>
      _getTrustFeedBackHistoryLoading.value = value;

  final _putFeedBackLoading = false.obs;

  bool get putFeedBackLoading => _putFeedBackLoading.value;

  set putFeedBackLoading(bool value) => _putFeedBackLoading.value = value;

  final _trustDeleteLoading = false.obs;

  bool get trustDeleteLoading => _trustDeleteLoading.value;

  set trustDeleteLoading(bool value) => _trustDeleteLoading.value = value;

  final _appFeedBackHistoryList = <TrustFeedBackModel>[].obs;

  List<TrustFeedBackModel> get appFeedBackHistoryList =>
      _appFeedBackHistoryList;

  set appFeedBackHistoryList(List<TrustFeedBackModel> value) =>
      _appFeedBackHistoryList.value = value;

  final _appFeedBackList = AppFeedBackList().obs;

  AppFeedBackList get appFeedBackList => _appFeedBackList.value;

  set appFeedBackList(AppFeedBackList value) => _appFeedBackList.value = value;

  final _getAppFeedBackLoading = false.obs;

  bool get getAppFeedBackLoading => _getAppFeedBackLoading.value;

  set getAppFeedBackLoading(bool value) => _getAppFeedBackLoading.value = value;
}
