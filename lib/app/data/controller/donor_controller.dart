import 'package:get/get.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_donation_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_notification_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_feedback_model.dart';

class DonorController extends GetxController {
  final _donorSignUpLoading = false.obs;

  bool get donorSignUpLoading => _donorSignUpLoading.value;

  set donorSignUpLoading(bool value) => _donorSignUpLoading.value = value;

  final _donorSignInLoading = false.obs;

  bool get donorSignInLoading => _donorSignInLoading.value;

  set donorSignInLoading(bool value) => _donorSignInLoading.value = value;

  final _donorDonationList = DonorDonationList().obs;

  DonorDonationList get donorDonationList => _donorDonationList.value;

  set donorDonationList(DonorDonationList value) =>
      _donorDonationList.value = value;

  final _donorSignUPModel = DonorSignUPModel().obs;

  DonorSignUPModel get donorSignUPModel => _donorSignUPModel.value;

  set donorSignUPModel(DonorSignUPModel value) =>
      _donorSignUPModel.value = value;

  final _donorNotificationList = <DonorNotificationModel>[].obs;

  List<DonorNotificationModel> get donorNotificationList =>
      _donorNotificationList;

  set donorNotificationList(List<DonorNotificationModel> value) =>
      _donorNotificationList.value = value;

  final _donorDonationHistoryList = <DonorDonationModel>[].obs;

  List<DonorDonationModel> get donorDonationHistoryList =>
      _donorDonationHistoryList;

  set donorDonationHistoryList(List<DonorDonationModel> value) =>
      _donorDonationHistoryList.value = value;

  final _getDonorDonationHistoryLoading = false.obs;

  bool get getDonorDonationHistoryLoading =>
      _getDonorDonationHistoryLoading.value;

  set getDonorDonationHistoryLoading(bool value) =>
      _getDonorDonationHistoryLoading.value = value;


}
