import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';

class DonorTrustDetailScreen extends StatefulWidget {
  const DonorTrustDetailScreen({super.key});

  @override
  State<DonorTrustDetailScreen> createState() => _DonorTrustDetailScreenState();
}

class _DonorTrustDetailScreenState extends State<DonorTrustDetailScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  Uint8List? decodedBytes;
  TrustProfileModel trustData = Get.arguments["trustData"];
  EmergencyList emergencyData = EmergencyList();
  List<String> dropDownList = [];
  String? currentItem;

  @override
  void initState() {
    getEmergencyData();
    super.initState();
  }

  getEmergencyData() async {
    try {
      trustController.getEmergencyDataLoading = true;
      if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustEmergencyNeedDataKey}")) {
        emergencyData = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${trustData.mobNumber}-${Constants.trustEmergencyNeedDataKey}");
        for (var element in emergencyData.emergencyNeedList!) {
          dropDownList.add(
              "${element.productName!} - ${element.quantity} ${element.unit}");
        }
        trustController.getEmergencyDataLoading = false;
      } else {
        trustController.getEmergencyDataLoading = false;
      }
    } catch (err) {
      trustController.getEmergencyDataLoading = false;
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: trustData.trustName, actionWidget: const SizedBox()),
      body: Obx(
        () => trustController.getEmergencyDataLoading
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
                    const SizedBox(height: 20),
                    dropDownList.isEmpty
                        ? const SizedBox()
                        : CustomDropDown(
                            isEnabled: true,
                            labelText: Constants.needs,
                            width: 250.w,
                            height: 45.h,
                            currentItem: currentItem,
                            emptyValidation: true,
                            chosenValue: (value) {

                            },
                            requiredValidationText: "Category",
                            dropDownItems: dropDownList,
                            hintText: "Needs",
                            emptyValidationText: "select a category",
                          ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 0.8.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLoginButtonWidget(
                            height: 0.005.sh,
                            width: 0.2.sw,
                            buttonFunction: () {
                              CommonFunctions.navigateScreen(
                                  context, Routes.paymentInputScreen,
                                  arguments: {"trustData": trustData});
                            },
                            buttonText: Constants.donate,
                            buttonTextStyle:
                                const TextStyle(color: Colors.white),
                            elevatedButtonStyle: adoptFormButtonStyle,
                          ),
                          CustomLoginButtonWidget(
                            height: 0.005.sh,
                            width: 0.2.sw,
                            buttonFunction: () {
                              CommonFunctions.navigateScreen(
                                  context, Routes.donorAdoptionFormScreen,
                                  arguments: {"trustData": trustData});
                            },
                            buttonText: Constants.adopt,
                            buttonTextStyle:
                                const TextStyle(color: Colors.white),
                            elevatedButtonStyle: adoptFormButtonStyle,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

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
