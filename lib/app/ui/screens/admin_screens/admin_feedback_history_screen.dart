import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/app_feed_back_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';

class AdminFeedBackHistoryScreen extends StatefulWidget {
  const AdminFeedBackHistoryScreen({super.key});

  @override
  State<AdminFeedBackHistoryScreen> createState() =>
      _AdminFeedBackHistoryScreenState();
}

class _AdminFeedBackHistoryScreenState
    extends State<AdminFeedBackHistoryScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  List<AppFeedBackModel> appFbList = [];

  getEmergencyData() async {
    trustController.getAppFeedBackLoading = true;
    try {
      if (commonController.checkKeyContainsInDataBase(
          Constants.orphanDataBase, Constants.appFeedBackKey)) {
        trustController.appFeedBackList =
            await commonController.getDataBaseByKey(
                Constants.orphanDataBase, Constants.appFeedBackKey);
        appFbList = trustController.appFeedBackList.appFeedBackList ?? [];
        print(trustController.appFeedBackList.appFeedBackList!.length);

        trustController.getAppFeedBackLoading = false;
      } else {
        trustController.getAppFeedBackLoading = false;
      }
    } catch (err) {
      trustController.getAppFeedBackLoading = false;
      CommonFunctions.customToast(Constants.errorMessage);
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  void initState() {
    getEmergencyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return trustController.getAppFeedBackLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: CustomAppBar(
                title: "Feedback history",
                actionWidget: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                    ),
                    Text(trustController.appFeedBackList.appFeedBackList![0]
                            .averageRating ??
                        "0.0")
                  ],
                ),
              ),
              body: trustController.appFeedBackList.appFeedBackList!.isEmpty
                  ? Center(
                      child: Text(
                        "No feedback",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(13.0).r,
                      child: ListView.separated(
                        itemCount: trustController
                            .appFeedBackList.appFeedBackList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                            color: tableColor,
                            child: ListTile(
                                title: Text(trustController.appFeedBackList
                                        .appFeedBackList![index].name ??
                                    ""),
                                subtitle: Text(trustController.appFeedBackList
                                    .appFeedBackList![index].feedBackReview!),
                                trailing: SizedBox(
                                  width: 0.15.sw,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(trustController.appFeedBackList
                                          .appFeedBackList![index].ratingValue!
                                          .toString()),
                                    ],
                                  ),
                                )),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ));
    });
  }
}
