part of './app_pages.dart';

abstract class Routes {
  static const initial = '/';
  static const userSelectionScreen = '/UserSelectionScreen';
  static const feedbackScreen = '/feedbackScreen';

  /// TRUST SCREEN
  static const trustSignUpScreen =
      "/UserSelectionScreen/trusteeSignInScreen/trustSignUpScreen";
  static const trusteeSignInScreen = "/UserSelectionScreen/trusteeSignInScreen";
  static const trustDashBoardScreen =
      "/UserSelectionScreen/trusteeSignInScreen/trustDashBoardScreen";
  static const otherTrustScreen = "/trustDashBoardScreen/otherTrustScreen";
  static const trustDetailsScreen =
      "/trustDashBoardScreen/otherTrustScreen/trustDetailsScreen";
  static const trustProfileScreen = "/trustDashBoardScreen/trustProfileScreen";
  static const trustEditProfileScreen =
      "/trustDashBoardScreen/trustProfileScreen/trustEditProfileScreen";
  static const trustDonationHistoryScreen =
      "/trustDashBoardScreen/trustDonationHistoryScreen";
  static const adoptRequestScreen = "/trustDashBoardScreen/adoptRequestScreen";
  static const emergencyNeedScreen =
      "/trustDashBoardScreen/emergencyNeedScreen";

  static const trustAdoptFormScreen =
      "/trustDashBoardScreen/trustAdoptFormScreen";

  static const feedBackHistoryScreen =
      "/donorDashBoardScreen/feedBackHistoryScreen";

  /// DONOR SCREEN
  static const donorSignUpScreen =
      "/UserSelectionScreen/donorSignInScreen/donorSignUpScreen";
  static const donorSignInScreen = "/UserSelectionScreen/donorSignInScreen";
  static const donorDashBoardScreen =
      "/UserSelectionScreen/donorSignInScreen/donorDashBoardScreen";
  static const donorProfileScreen = "/donorDashBoardScreen/donorProfileScreen";
  static const doorCategoryScreen = "/donorDashBoardScreen/doorCategoryScreen";
  static const donorEditProfileScreen =
      "/donorDashBoardScreen/donorProfileScreen/donorEditProfileScreen";
  static const donorDonationHistoryScreen =
      "/donorDashBoardScreen/donorDonationHistoryScreen";
  static const notificationScreen = "/donorDashBoardScreen/notificationScreen";
  static const donorNotificationDetailsScreen =
      "/donorDashBoardScreen/notificationScreen/donorNotificationDetailsScreen";
  static const donorTrustDetailScreen =
      "/donorDashBoardScreen/donorTrustDetailScreen";
  static const donorAdoptionFormScreen =
      "/donorDashBoardScreen/donorTrustDetailScreen/donorAdoptionFormScreen";
  static const paymentInputScreen =
      "/donorDashBoardScreen/donorTrustDetailScreen/paymentInputScreen";
  static const paymentOptionScreen =
      "/donorDashBoardScreen/donorTrustDetailScreen/paymentInputScreen/paymentOptionScreen";
  static const donorCategoryScreen =
      "/donorDashBoardScreen/donorCategoryScreen";
  static const trustListByCategoryScreen =
      "/donorDashBoardScreen/donorCategoryScreen/trustListByCategoryScreen";

  /// ADMIN SCREENS
  static const adminLogInScreen = "/UserSelectionScreen/adminLogInScreen";

  static const adminDashBoardScreen =
      "/UserSelectionScreen/adminLogInScreen/adminDashBoardScreen";

  static const adminTrustDetailScreen =
      "/adminDashBoardScreen/adminTrustDetailScreen";

  static const adminFeedBackHistoryScreen =
      "/adminDashBoardScreen/adminFeedBackHistoryScreen";
}
