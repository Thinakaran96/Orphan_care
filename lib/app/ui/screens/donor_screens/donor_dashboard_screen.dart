import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_category_screen.dart';
import 'package:orphan_care/app/ui/screens/donor_screens/donor_profile_screen.dart';
import 'package:orphan_care/app/ui/widgets/common_trust_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_drawer.dart';
import 'package:orphan_care/app/ui/widgets/custom_nav_bar.dart';

class DonorDashBoardScreen extends StatefulWidget {
  const DonorDashBoardScreen({super.key});

  @override
  State<DonorDashBoardScreen> createState() => _DonorDashBoardScreenState();
}

class _DonorDashBoardScreenState extends State<DonorDashBoardScreen> {
  DonorController donorController = Get.find<DonorController>();
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorSignUPModel donorData = Get.arguments["donorSignUPModel"];

  @override
  void initState() {
    getAllTrustDetails(Constants.orphanDataBase);
    donorController.donorSignUPModel = donorData;
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNavBar(
        isTrust: false,
        screens: [
          donorDashBoard(),
          const DonorCategoryScreen(),
          const DonorProfileScreen()
        ],
      ),
    );
  }

  Widget donorDashBoard() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const CustomDrawer(
        drawerType: Constants.donor,
      ),
      appBar: CustomAppBar(
        title: donorData.donorName!,
        actionWidget: const SizedBox(),
      ),
      body: trustController.getTrustLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : trustController.localTrustList.isEmpty
              ? Center(
                  child: Text(
                    "No trust available",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(10.r),
                  itemCount: trustController.localTrustList.length,
                  separatorBuilder: (context, integer) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return CommonTrustComponent(
                      isFeedbackShow: true,
                      feedBackFunction: () {
                        CommonFunctions.navigateScreen(
                            context, Routes.feedBackHistoryScreen, arguments: {
                          "trustData": trustController.localTrustList[index],
                          "isTrustDashBoard": false
                        });
                      },
                      ratingValue:
                          "${trustController.localTrustList[index].averageStarRating ?? 0.0}",
                      isAssetImage:
                          trustController.localTrustList[index].base64String ==
                              null,
                      bs64String:
                          trustController.localTrustList[index].base64String ??
                              "",
                      trustName:
                          trustController.localTrustList[index].trustName ?? "",
                      category:
                          trustController.localTrustList[index].category ?? "-",
                      forWhom:
                          trustController.localTrustList[index].onlyFor ?? "-",
                      phNumber:
                          trustController.localTrustList[index].mobNumber ?? "",
                      onTap: () => CommonFunctions.navigateScreen(
                          context, Routes.donorTrustDetailScreen, arguments: {
                        "trustData": trustController.localTrustList[index]
                      }),
                    );
                  },
                ),
    );
  }
}
