import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/ui/widgets/adopt_request_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';

class AdoptRequestScreen extends StatefulWidget {
  const AdoptRequestScreen({super.key});

  @override
  State<AdoptRequestScreen> createState() => _AdoptRequestScreenState();
}

class _AdoptRequestScreenState extends State<AdoptRequestScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorController donorController = Get.find<DonorController>();

  getAdoptRequestData() async {
    var dataBase = Hive.box(Constants.orphanDataBase);
    trustController.trustAdoptRequestList = [];
    try {
      trustController.getTrustAdoptRequestLoading = true;
      for (var element in dataBase.keys) {
        if (element.contains(
            "${trustController.trustProfileModel.mobNumber}-${Constants.donorAdoptionRequestDataKey}")) {
          trustController.trustAdoptRequestList.add(commonController
              .getDataBaseByKey(Constants.orphanDataBase, element));
        }
      }
      trustController.getTrustAdoptRequestLoading = false;
      return trustController.trustAdoptRequestList;
    } catch (err) {
      CommonFunctions.customToast(Constants.errorMessage);
      trustController.getTrustAdoptRequestLoading = false;
      print(err);
    }
  }

  @override
  void initState() {
    getAdoptRequestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(
          title: Constants.adoptRequests,
          actionWidget: SizedBox(),
        ),
        body: trustController.getTrustAdoptRequestLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : trustController.trustAdoptRequestList.isEmpty
                ? Center(
                    child: Text(
                      "You don't have any request ",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 0.8.sh,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          border: Border.all(color: buttonColor),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: ListView.separated(
                          padding: EdgeInsets.all(10.r),
                          itemCount:
                              trustController.trustAdoptRequestList.length,
                          separatorBuilder: (context, integer) {
                            return const SizedBox(height: 5);
                          },
                          itemBuilder: (context, index) {
                            return AdoptRequestComponent(
                              adopterName: trustController
                                  .trustAdoptRequestList[index].firstName!,
                              whoseAdopt: trustController
                                      .trustAdoptRequestList[index].whomAdopt ??
                                  "",
                              onTap: () {
                                CommonFunctions.navigateScreen(
                                    context, Routes.trustAdoptFormScreen,
                                    arguments: {
                                      "adoptRequesterDetails": trustController
                                          .trustAdoptRequestList[index]
                                    });
                              },
                            );
                          }),
                    ),
                  ),
      );
    });
  }
}
