import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_donation_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/notification_component.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorController donorController = Get.find<DonorController>();

  getNotificationDetails() async {
    var dataBase = Hive.box(Constants.orphanDataBase);
    donorController.donorNotificationList = <DonorNotificationModel>[];
    try {
      for (var element in dataBase.keys) {
        if (element.contains(
            "${donorController.donorSignUPModel.phoneNumber}${Constants.donorNotificationDataKey}")) {
          donorController.donorNotificationList.add(commonController
              .getDataBaseByKey(Constants.orphanDataBase, element));
        }
      }
      print(donorController.donorNotificationList.length);
      return donorController.donorNotificationList;
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    getNotificationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Notification",
          actionWidget: SizedBox(),
        ),
        body: donorController.donorNotificationList.isEmpty
            ? Center(
                child: Text(
                  "You don't have any notification",
                  style: TextStyle(fontSize: 20.sp),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(15.r),
                itemCount: donorController.donorNotificationList.length,
                separatorBuilder: (context, integer) {
                  return const SizedBox(height: 5);
                },
                itemBuilder: (context, index) {
                  return NotificationComponent(
                    requestId:
                        donorController.donorNotificationList[index].requestId,
                    date: donorController.donorNotificationList[index].date,
                    isRequestAccepted:
                        donorController.donorNotificationList[index].isAccepted,
                    onTap: () => CommonFunctions.navigateScreen(
                        context, Routes.donorNotificationDetailsScreen,
                        arguments: {
                          "trustData": donorController
                              .donorNotificationList[index]
                              .donorNotificationTrustProfile,
                          "isAccepted": donorController
                              .donorNotificationList[index].isAccepted!
                        }),
                  );
                }));
  }
}
