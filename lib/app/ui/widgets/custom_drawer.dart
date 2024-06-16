import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';

class CustomDrawer extends StatefulWidget {
  final String? drawerType;

  const CustomDrawer({super.key, this.drawerType});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  TrustController trustController = Get.find<TrustController>();
  DonorController donorController = Get.find<DonorController>();
  Map<String, Map<String, dynamic>> listTileList = {
    Constants.trustee: {
      Constants.profile: const Icon(Icons.arrow_forward_ios),
      Constants.requestDetails: const Icon(Icons.arrow_forward_ios),
      Constants.emergencyNeeds: const Icon(Icons.arrow_forward_ios),
      Constants.feedback: const Icon(Icons.arrow_forward_ios),
      Constants.logout: const Icon(Icons.logout),
    },
    Constants.donor: {
      Constants.profile: const Icon(Icons.arrow_forward_ios),
      Constants.notification: const Icon(Icons.arrow_forward_ios),
      Constants.donationDetails: const Icon(Icons.arrow_forward_ios),
      Constants.feedback: const Icon(Icons.arrow_forward_ios),
      Constants.logout: const Icon(Icons.logout),
    },
    Constants.admin: {
      Constants.feedback: const Icon(Icons.arrow_forward_ios),
      Constants.logout: const Icon(Icons.logout),
    }
  };
  Map<String, dynamic>? selectedDrawer;

  @override
  void initState() {
    selectDrawerType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBackgroundColor.withOpacity(0.8),
      child: Column(
        children: [
          SizedBox(height: 0.05.sh),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedDrawer!.keys.toList().length,
            itemBuilder: (context, index) => ListTile(
              leading: Text(selectedDrawer!.keys.toList()[index],
                  style: labelTextStyle),
              trailing: selectedDrawer!.values.toList()[index],
              onTap: () async {
                if (widget.drawerType == Constants.trustee) {
                  if (selectedDrawer!.keys.toList()[index] ==
                      Constants.profile) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.trustProfileScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.requestDetails) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.adoptRequestScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.emergencyNeeds) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.emergencyNeedScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.feedback) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.feedbackScreen,
                        arguments: {
                          "trustData": trustController.trustProfileModel,
                          "isTrust": true,
                        });
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.logout) {
                    await callLogoutAlert();
                  }
                } else if (widget.drawerType == Constants.donor) {
                  if (selectedDrawer!.keys.toList()[index] ==
                      Constants.profile) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.donorProfileScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.notification) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.notificationScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.donationDetails) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.donorDonationHistoryScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.feedback) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.feedbackScreen, arguments: {
                      "donorData": donorController.donorSignUPModel
                    });
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.logout) {
                    await callLogoutAlert();
                  }
                } else if (widget.drawerType == Constants.admin) {
                  if (selectedDrawer!.keys.toList()[index] ==
                      Constants.feedback) {
                    await CommonFunctions.navigateScreen(
                        context, Routes.adminFeedBackHistoryScreen);
                  } else if (selectedDrawer!.keys.toList()[index] ==
                      Constants.logout) {
                    await callLogoutAlert();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void selectDrawerType() {
    if (widget.drawerType == Constants.donor) {
      selectedDrawer = listTileList[Constants.donor];
    } else if (widget.drawerType == Constants.trustee) {
      selectedDrawer = listTileList[Constants.trustee];
    } else if (widget.drawerType == Constants.admin) {
      selectedDrawer = listTileList[Constants.admin];
    }
  }

  Future<void> logOut() async {
    await Get.offAllNamed(Routes.userSelectionScreen);
  }

  Future callLogoutAlert() async {
    await Get.defaultDialog(
        content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              Constants.logoutAlertText,
              style: commonTextStyle,
            )),
        contentPadding: const EdgeInsets.all(16.0).r,
        title: Constants.alert,
        titlePadding: const EdgeInsets.all(16.0).r,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        confirm: CustomLoginButtonWidget(
            elevatedButtonStyle: loginButtonStyle,
            height: 20.h,
            width: 60.w,
            buttonFunction: () async => await logOut(),
            buttonText: Constants.yes),
        cancel: TextButton(
            onPressed: () => Get.back(),
            child: Text(
              Constants.no,
              style: commonTextStyle,
            )));
  }
}
