import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_feedback_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_donation_history_screen.dart';
import 'package:orphan_care/app/ui/screens/trustee_screens/trust_profile_screen.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_drawer.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_nav_bar.dart';

class TrustDashBoardScreen extends StatefulWidget {
  const TrustDashBoardScreen({super.key});

  @override
  State<TrustDashBoardScreen> createState() => _TrustDashBoardScreenState();
}

class _TrustDashBoardScreenState extends State<TrustDashBoardScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    if (trustController.trustProfileModel.base64String != null) {
      decodedBytes =
          base64.decode(trustController.trustProfileModel.base64String!);
    }
    return Scaffold(
      body: CustomNavBar(
        isTrust: true,
        screens: [
          trustDashBoard(),
          const TrustDonationHistoryScreen(),
          const TrustProfileScreen()
        ],
      ),
    );
  }

  Uint8List? decodedBytes;
  var dataBase = Hive.box(Constants.orphanDataBase);

  getProfileData() async {
    try {
      trustController.getProfileLoading = true;

      trustController.trustProfileModel = Get.arguments["trustProfileModel"];
      if (trustController.trustProfileModel.base64String != null) {
        decodedBytes =
            base64.decode(trustController.trustProfileModel.base64String!);
      }
      trustController.getProfileLoading = false;
    } catch (err) {
      trustController.getProfileLoading = false;
      CommonFunctions.customToast(Constants.errorMessage);
      print(err);
    }
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  Widget trustDashBoard() {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: trustController.trustProfileModel.trustName,
          actionWidget: IconButton(
            onPressed: () {
              CommonFunctions.navigateScreen(
                  context, Routes.feedBackHistoryScreen, arguments: {
                "isTrustDashBoard": true,
                "trustData": trustController.trustProfileModel
              });
            },
            icon: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[700],
                ),
                Text("${trustController.trustProfileModel.averageStarRating ?? 0.0}"
                     )
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(drawerType: Constants.trustee),
        body: trustController.getProfileLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  children: [
                    trustImageWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    trustDataWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomLoginButtonWidget(
                        elevatedButtonStyle: loginButtonStyle,
                        height: 30.h,
                        width: 140.w,
                        buttonFunction: () => CommonFunctions.navigateScreen(
                            context, Routes.otherTrustScreen),
                        buttonText: Constants.showOtherTrust)
                  ],
                ),
              ),
      );
    });
  }

  trustImageWidget() {
    if (trustController.trustProfileModel.base64String != null) {
      decodedBytes =
          base64.decode(trustController.trustProfileModel.base64String!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        decodedBytes != null
            ? Container(
                width: 0.75.sw,
                height: 0.17.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: MemoryImage(decodedBytes!))),
              )
            : const SizedBox(),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 0.3.sw,
              child: Text(
                trustController.trustProfileModel.trustName!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            trustController.trustProfileModel.stateName == null
                ? const SizedBox()
                : Icon(
                    Icons.location_pin,
                    size: 15.sp,
                  ),
            SizedBox(
                width: trustController.trustProfileModel.stateName == null
                    ? 0.01.sw
                    : 0.3.sw,
                child: Text(
                  trustController.trustProfileModel.stateName ?? "",
                  overflow: TextOverflow.ellipsis,
                )),
            Text(trustController.trustProfileModel.status ?? "")
          ],
        )
      ],
    );
  }

  trustDataWidget() {
    return Container(
      height: 0.46.sh,
      width: double.infinity.w,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: buttonColor)),
      child: SizedBox(
        width: 0.5.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Constants.name, style: editButtonTextStyle),
                Text(Constants.category, style: editButtonTextStyle),
                Text(Constants.onlyFor, style: editButtonTextStyle),
                Text(Constants.mobNumber, style: editButtonTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(Constants.careTaker, style: editButtonTextStyle),
                Text(Constants.members, style: editButtonTextStyle),
                Text(Constants.uPIId, style: editButtonTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(Constants.email, style: editButtonTextStyle),
                Text(Constants.accountNumber, style: editButtonTextStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                const SizedBox(
                  height: 5,
                ),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                const SizedBox(height: 5),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustController.trustProfileModel.trustName!,
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        trustController.trustProfileModel.category ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        trustController.trustProfileModel.onlyFor ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        CommonFunctions.formatPhoneNumber(
                            trustController.trustProfileModel.mobNumber!),
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        trustController.trustProfileModel.careTakerName ?? "-",
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        trustController.trustProfileModel.membersCount ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustController.trustProfileModel.uPIId ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustController.trustProfileModel.email!,
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        trustController.trustProfileModel.accountNumber ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
