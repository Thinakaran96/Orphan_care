import 'package:get/get.dart';
import 'package:orphan_care/app/data/binding/common_bindings.dart';
import 'package:orphan_care/app/ui/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:orphan_care/app/ui/screens/admin_screens/admin_feedback_history_screen.dart';
import 'package:orphan_care/app/ui/screens/admin_screens/admin_login_screen.dart';
import 'package:orphan_care/app/ui/screens/admin_screens/admin_trust_details_screen.dart';
import 'package:orphan_care/app/ui/screens/common_screens/feedback_screen.dart';
import 'package:orphan_care/app/ui/screens/common_screens/splash_screen.dart';
import 'package:orphan_care/app/ui/screens/common_screens/user_selection_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_adoption_form_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_category_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_dashboard_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_donation_history_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_edit_profile_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_notification_details_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_profile_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_sign_in_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_signup_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_trust_details_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/notification_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/payment_input_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/payment_option_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/trust_list_by_category_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/adopt_request_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/emergency_need_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/other_trust_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_adopt_form_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_dashboard_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_details_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_donation_history_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_edit_profile_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/feedback_history_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_profile_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trustee_sign_in_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trustee_signup_screen.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';

part './app_routes.dart';

class AppPages {
  static bool showCupertinoAnimation = false;
  static final pages = [
    GetPage(
        name: Routes.initial,
        page: () => const SplashScreen(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.userSelectionScreen,
        page: () => const UserSelectionScreen(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.feedbackScreen,
        page: () => const FeedBackScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),

    // TRUST SCREENS

    GetPage(
        name: Routes.trustSignUpScreen,
        page: () => const TrusteeSignUpScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trusteeSignInScreen,
        page: () => const TrusteeSignInScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustDashBoardScreen,
        page: () => const TrustDashBoardScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.otherTrustScreen,
        page: () => const OtherTrustScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustDetailsScreen,
        page: () => const TrustDetailsScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustProfileScreen,
        page: () => const TrustProfileScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustEditProfileScreen,
        page: () => const TrustEditProfileScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustDonationHistoryScreen,
        page: () => const TrustDonationHistoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.adoptRequestScreen,
        page: () => const AdoptRequestScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.emergencyNeedScreen,
        page: () => const EmergencyNeedScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustAdoptFormScreen,
        page: () => const TrustAdoptFormScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.feedBackHistoryScreen,
        page: () => const FeedBackHistoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),

    // DONOR SCREENS

    GetPage(
        name: Routes.donorSignUpScreen,
        page: () => const DonorSignUpScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorSignInScreen,
        page: () => const DonorSignInScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorDashBoardScreen,
        page: () => const DonorDashBoardScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.doorCategoryScreen,
        page: () => const DonorCategoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorProfileScreen,
        page: () => const DonorProfileScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorEditProfileScreen,
        page: () => const DonorEditProfileScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorDonationHistoryScreen,
        page: () => const DonorDonationHistoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.notificationScreen,
        page: () => const NotificationScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.notificationScreen,
        page: () => const NotificationScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorNotificationDetailsScreen,
        page: () => const DonorNotificationDetailsScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorTrustDetailScreen,
        page: () => const DonorTrustDetailScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorAdoptionFormScreen,
        page: () => const DonorAdoptionFormScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.paymentInputScreen,
        page: () => const PaymentInputScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.paymentOptionScreen,
        page: () => const PaymentOptionScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.donorCategoryScreen,
        page: () => const DonorCategoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.trustListByCategoryScreen,
        page: () => const TrustListByCategoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.adminLogInScreen,
        page: () => const AdminLogInScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.adminDashBoardScreen,
        page: () => const AdminDashBoardScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.adminTrustDetailScreen,
        page: () => const AdminTrustDetailsScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),
    GetPage(
        name: Routes.adminFeedBackHistoryScreen,
        page: () => const AdminFeedBackHistoryScreen(),
        binding: CommonBindings(),
        showCupertinoParallax: showCupertinoAnimation),

    // COMMON SCREEN
  ];
}
