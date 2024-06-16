import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';

class AdminTrustDetailsScreen extends StatefulWidget {
  const AdminTrustDetailsScreen({super.key});

  @override
  State<AdminTrustDetailsScreen> createState() =>
      _AdminTrustDetailsScreenState();
}

class _AdminTrustDetailsScreenState extends State<AdminTrustDetailsScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  TrustProfileModel trustData = Get.arguments["trustData"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: trustData.trustName, actionWidget: const SizedBox()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            trustImageWidget(),
            const SizedBox(
              height: 20,
            ),
            trustDataWidget(),
            const SizedBox(height: 20),
            CustomLoginButtonWidget(
              height: 0.005.sh,
              width: 0.2.sw,
              buttonFunction: () async {
                callDeleteAlertDialog();
              },
              buttonText: Constants.delete,
              buttonTextStyle: const TextStyle(color: Colors.white),
              elevatedButtonStyle: adoptFormButtonStyle,
            )
          ],
        ),
      ),
    );
  }

  Future callDeleteAlertDialog() async {
    await Get.defaultDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          Constants.trustDeleteAlertText,
          style: commonTextStyle,
        ),
      ),
      contentPadding: const EdgeInsets.all(16.0).r,
      title: Constants.alert,
      titlePadding: const EdgeInsets.all(16.0).r,
      titleStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      confirm: CustomLoginButtonWidget(
        elevatedButtonStyle: loginButtonStyle,
        isLoading: trustController.trustDeleteLoading,
        height: 20.h,
        width: 60.w,
        buttonFunction: () => deleteTrustData(),
        buttonText: Constants.yes,
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          Constants.no,
          style: commonTextStyle,
        ),
      ),
    );
  }

  deleteTrustData() {
    try {
      trustController.trustDeleteLoading = true;
      commonController.deleteValueDataBaseIndexByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}${Constants.trustProfileDataKey}");
      commonController.deleteValueDataBaseIndexByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustEmergencyNeedDataKey}");
      commonController.deleteValueDataBaseIndexByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustDonationHistoryKey}");
      commonController.deleteValueDataBaseIndexByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustFeedBackKey}");
      getAllTrustDetails(Constants.orphanDataBase);
      trustController.trustDeleteLoading = false;
      Get.back();
      Get.back();
    } catch (err) {
      trustController.trustDeleteLoading = false;
      print(err);
    }
  }

  Future getAllTrustDetails(String dataBaseName) async {
    try {
      trustController.getTrustLoading = true;
      var dataBase = Hive.box(dataBaseName);
      trustController.localTrustList = <TrustProfileModel>[];
      for (var element in dataBase.keys) {
        if (element.contains(Constants.trustProfileDataKey)) {
          trustController.localTrustList
              .add(commonController.getDataBaseByKey(dataBaseName, element));
        }
      }
      trustController.getTrustLoading = false;

      return trustController.localTrustList;

    } catch (err) {
      print(err);
      trustController.getTrustLoading = false;
      CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  Uint8List? decodedBytes;

  trustImageWidget() {
    if (trustData.base64String != null) {
      decodedBytes = base64.decode(trustData.base64String!);
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
                trustData.trustName!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            trustData.stateName == null
                ? const SizedBox()
                : Icon(
                    Icons.location_pin,
                    size: 15.sp,
                  ),
            SizedBox(
                width: trustData.stateName == null ? 0.01.sw : 0.3.sw,
                child: Text(
                  trustData.stateName ?? "",
                  overflow: TextOverflow.ellipsis,
                )),
            Text(trustData.status ?? "")
          ],
        )
      ],
    );
  }

  trustDataWidget() {
    return Container(
      height: 0.38.sh,
      width: 0.85.sw,
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
                Text(Constants.careTaker, style: editButtonTextStyle),
                Text(Constants.members, style: editButtonTextStyle),
                Text(Constants.uPIId, style: editButtonTextStyle),
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
                Text(":", style: commonTextStyle),
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
                    child: Text(trustData.trustName!,
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.category ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.onlyFor ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        CommonFunctions.formatPhoneNumber(trustData.mobNumber!),
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.careTakerName ?? "-",
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.membersCount ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.uPIId ?? "-",
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
