import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/widgets/common_trust_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';

class TrustListByCategoryScreen extends StatefulWidget {
  const TrustListByCategoryScreen({super.key});

  @override
  State<TrustListByCategoryScreen> createState() =>
      _TrustListByCategoryScreenState();
}

class _TrustListByCategoryScreenState extends State<TrustListByCategoryScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  var category = Get.arguments["category"];

  getCategoryByTrust(category) {
    try {
      trustController.categoryByTrustList = [];
      for (var element in trustController.localTrustList) {
        if (element.category == category) {
          trustController.categoryByTrustList.add(element);
        }
      }
    } catch (err) {
      print(err);

      CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  @override
  void initState() {
    getCategoryByTrust(category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: category,
            actionWidget: const SizedBox(),
          ),
          body: trustController.categoryByTrustList.isEmpty
              ? Center(
                  child: Text(
                    "No trust available",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(10.r),
                  itemCount: trustController.categoryByTrustList.length,
                  separatorBuilder: (context, integer) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return CommonTrustComponent(
                      isAssetImage: trustController
                              .categoryByTrustList[index].base64String ==
                          null,
                      bs64String: trustController
                              .categoryByTrustList[index].base64String ??
                          "",
                      trustName:
                          trustController.categoryByTrustList[index].trustName!,
                      category:
                          trustController.categoryByTrustList[index].category ??
                              "-",
                      forWhom:
                          trustController.categoryByTrustList[index].onlyFor ??
                              "-",
                      ratingValue: trustController
                              .categoryByTrustList[index].averageStarRating ??
                          "0.0",
                      phNumber:
                          trustController.categoryByTrustList[index].mobNumber!,
                      onTap: () => CommonFunctions.navigateScreen(
                          context, Routes.donorTrustDetailScreen, arguments: {
                        "trustData": trustController.categoryByTrustList[index]
                      }),
                    );
                  },
                ),
        );
      },
    );
  }
}
