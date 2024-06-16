import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/widgets/common_trust_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_drawer.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();

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
  void initState() {
    getAllTrustDetails(Constants.orphanDataBase);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(
        drawerType: Constants.admin,
      ),
      appBar: const CustomAppBar(
        title: "Trust List",
        actionWidget: SizedBox(),
      ),
      body: Obx(
        () => trustController.getTrustLoading
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
                        isFeedbackShow: false,
                        feedBackFunction: () {},
                        ratingValue:
                            "${trustController.localTrustList[index].averageStarRating ?? 0.0}",
                        isAssetImage: trustController
                                .localTrustList[index].base64String ==
                            null,
                        bs64String: trustController
                                .localTrustList[index].base64String ??
                            "",
                        trustName:
                            trustController.localTrustList[index].trustName ??
                                "",
                        category:
                            trustController.localTrustList[index].category ??
                                "-",
                        forWhom:
                            trustController.localTrustList[index].onlyFor ??
                                "-",
                        phNumber:
                            trustController.localTrustList[index].mobNumber ??
                                "",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.adminTrustDetailScreen, arguments: {
                          "trustData": trustController.localTrustList[index]
                        }),
                      );
                    },
                  ),
      ),
    );
  }
}
