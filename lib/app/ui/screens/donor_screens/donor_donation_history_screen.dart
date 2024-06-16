import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_notification_model.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/donor_donation_history_component.dart';

class DonorDonationHistoryScreen extends StatefulWidget {
  const DonorDonationHistoryScreen({super.key});

  @override
  State<DonorDonationHistoryScreen> createState() =>
      _DonorDonationHistoryScreenState();
}

class _DonorDonationHistoryScreenState
    extends State<DonorDonationHistoryScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();

  getDonorDonationHistory() async {
    var dataBase = Hive.box(Constants.orphanDataBase);
    donorController.donorDonationHistoryList = [];
    DonorDonationList data = DonorDonationList();
    try {
      donorController.getDonorDonationHistoryLoading = true;
      for (var element in dataBase.keys) {
        if (element.contains(
            "${donorController.donorSignUPModel.phoneNumber}-${Constants.donorDonationHistoryKey}")) {
          data = commonController.getDataBaseByKey(Constants.orphanDataBase,
              "${donorController.donorSignUPModel.phoneNumber}-${Constants.donorDonationHistoryKey}");
        }
      }
      donorController.donorDonationHistoryList = data.donorDonationList ?? [];
      donorController.getDonorDonationHistoryLoading = false;
      return donorController.donorDonationHistoryList;
    } catch (err) {
      CommonFunctions.customToast(Constants.errorMessage);
      donorController.getDonorDonationHistoryLoading = false;
      print(err);
    }
  }

  @override
  void initState() {
    getDonorDonationHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(
          title: Constants.donationHistory,
          actionWidget: SizedBox(),
        ),
        body: donorController.getDonorDonationHistoryLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : donorController.donorDonationHistoryList.isEmpty
                ? const Center(
                    child: Text("You don't have any updates"),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(20.r),
                    itemCount: donorController.donorDonationHistoryList.length,
                    separatorBuilder: (context, integer) {
                      return const SizedBox(height: 5);
                    },
                    itemBuilder: (context, index) {
                      return DonorDonationHistoryComponent(
                        trustName: donorController
                            .donorDonationHistoryList[index].trustName,
                        date: donorController
                            .donorDonationHistoryList[index].date,
                        donation: donorController
                            .donorDonationHistoryList[index].donationAmount,
                        location: donorController
                            .donorDonationHistoryList[index].location,
                      );
                    }),
      );
    });
  }
}
