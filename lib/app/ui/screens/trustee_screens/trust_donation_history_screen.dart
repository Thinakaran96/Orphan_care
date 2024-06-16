import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_donation_model.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/trust_donation_history_component.dart';

class TrustDonationHistoryScreen extends StatefulWidget {
  const TrustDonationHistoryScreen({super.key});

  @override
  State<TrustDonationHistoryScreen> createState() =>
      _TrustDonationHistoryScreenState();
}

class _TrustDonationHistoryScreenState
    extends State<TrustDonationHistoryScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();

  getTrustDonationHistory() async {
    var dataBase = Hive.box(Constants.orphanDataBase);
    TrustDonationList data = TrustDonationList();
    trustController.trustDonationHistoryList = [];
    try {
      trustController.getTrustDonationHistoryLoading = true;
      for (var element in dataBase.keys) {
        if (element.contains(
            "${trustController.trustProfileModel.mobNumber}-${Constants.trustDonationHistoryKey}")) {
          data = commonController.getDataBaseByKey(Constants.orphanDataBase,
              "${trustController.trustProfileModel.mobNumber}-${Constants.trustDonationHistoryKey}");
        }
      }
      trustController.trustDonationHistoryList = data.trustDonationList ?? [];
      trustController.getTrustDonationHistoryLoading = false;
      return trustController.trustDonationHistoryList;
    } catch (err) {
      CommonFunctions.customToast(Constants.errorMessage);
      trustController.getTrustDonationHistoryLoading = false;
      print(err);
    }
  }

  @override
  void initState() {
    getTrustDonationHistory();
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
        body: trustController.getTrustDonationHistoryLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : trustController.trustDonationHistoryList.isEmpty
                ? const Center(
                    child: Text("You don't have any updates"),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(20.r),
                    itemCount: trustController.trustDonationHistoryList.length,
                    separatorBuilder: (context, integer) {
                      return const SizedBox(height: 5);
                    },
                    itemBuilder: (context, index) {
                      return TrustDonationHistoryComponent(
                        isAssetImage: true,
                        bs64String: "bs64String",
                        donorName: trustController
                            .trustDonationHistoryList[index].donorName!,
                        donateDate: trustController
                            .trustDonationHistoryList[index].date!,
                        amount: trustController
                            .trustDonationHistoryList[index].amount!,
                        mobileNumber: trustController
                            .trustDonationHistoryList[index].contactNumber!,
                      );
                    }),
      );
    });
  }
}
