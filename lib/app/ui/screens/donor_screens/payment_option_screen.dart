import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_notification_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_donation_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';
import 'package:orphan_care/app/ui/widgets/payment_widget.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  TrustProfileModel trustData = Get.arguments["trustData"];
  String amount = Get.arguments["amount"];
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorController donorController = Get.find<DonorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Choose your payment option",
        actionWidget: SizedBox(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            CommonFunctions.commonHeaderWidget("Card Payment "),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardComponent(
                  cardType: "Debit Card",
                  onTap: () async => await paymentSuccessFunction(),
                ),
                CardComponent(
                  cardType: "Credit Card",
                  onTap: () async => await paymentSuccessFunction(),
                ),
                GestureDetector(
                  onTap: () async => await CommonFunctions.customToast(
                      "This feature will coming soon"),
                  child: Container(
                    height: 0.1.sh,
                    width: 0.28.sw,
                    decoration: BoxDecoration(
                        border: Border.all(color: buttonColor),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        "Other Cards",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CommonFunctions.commonHeaderWidget("Other Payments "),
            PaymentWidget(
              iconPath: IconImages.netBanking,
              paymentType: Constants.netBanking,
              onTap: () async => await paymentSuccessFunction(),
            ),
            const SizedBox(
              height: 20,
            ),
            CommonFunctions.commonHeaderWidget("UPI Payments "),
            PaymentWidget(
              iconPath: IconImages.amazonPay,
              paymentType: Constants.amazonPay,
              onTap: () async => await paymentSuccessFunction(),
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentWidget(
              iconPath: IconImages.googlePay,
              paymentType: Constants.googlePay,
              onTap: () async => await paymentSuccessFunction(),
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentWidget(
              iconPath: IconImages.phonePe,
              paymentType: Constants.phonePe,
              onTap: () async => await paymentSuccessFunction(),
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentWidget(
              iconPath: IconImages.paytm,
              paymentType: Constants.paytm,
              onTap: () async => await paymentSuccessFunction(),
            ),
          ],
        ),
      ),
    );
  }

  paymentSuccessFunction() async {
    try {
      await putDonorDonationData();
      await putTrustDonationData();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const MessageWidget(
            isAdoptSubmitted: false,
            isFeedback: false,
            isPayment: true,
            isAdoptRequestDeclined: false,
            isAdoptRequestAccepted: false,
            isPaymentSuccess: true,
          ),
        ),
      );
      Get.back();
      Get.back();
    } catch (err) {
      print(err);
      CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  putDonorDonationData() async {
    List<DonorDonationModel> list = [];
    DonorDonationList data = DonorDonationList();
    if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
        "${donorController.donorSignUPModel.phoneNumber}-${Constants.donorDonationHistoryKey}")) {
      data = commonController.getDataBaseByKey(Constants.orphanDataBase,
          "${donorController.donorSignUPModel.phoneNumber}-${Constants.donorDonationHistoryKey}");
      list = data.donorDonationList!;
    }

    var donorDonationData = DonorDonationModel(
      trustName: trustData.trustName,
      date: DateFormat.yMMMEd().format(DateTime.now()),
      donationAmount: amount,
      location: trustData.stateName,
    );

    list.add(donorDonationData);

    DonorDonationList donationList = DonorDonationList(donorDonationList: list);

    await commonController.putDataBaseByKey(
        donationList,
        Constants.orphanDataBase,
        "${donorController.donorSignUPModel.phoneNumber}-${Constants.donorDonationHistoryKey}");
  }

  putTrustDonationData() async {
    List<TrustDonationModel> list = [];
    TrustDonationList data = TrustDonationList();
    if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
        "${trustData.mobNumber}-${Constants.trustDonationHistoryKey}")) {
      data = commonController.getDataBaseByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustDonationHistoryKey}");
      list = data.trustDonationList!;
    }

    var trustDonationData = TrustDonationModel(
        donorName: donorController.donorSignUPModel.donorName!,
        date: DateFormat.yMMMEd().format(DateTime.now()),
        amount: amount,
        contactNumber: donorController.donorSignUPModel.phoneNumber!);

    list.add(trustDonationData);
    TrustDonationList dataList = TrustDonationList(trustDonationList: list);

    await commonController.putDataBaseByKey(dataList, Constants.orphanDataBase,
        "${trustData.mobNumber}-${Constants.trustDonationHistoryKey}");
  }

  paymentFailureFunction() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const MessageWidget(
          isAdoptSubmitted: false,
          isFeedback: false,
          isPayment: true,
          isAdoptRequestDeclined: false,
          isAdoptRequestAccepted: false,
          isPaymentSuccess: false,
        ),
      ),
    );
    Get.back();
    Get.back();
  }
}

class CardComponent extends StatelessWidget {
  final Function? onTap;
  final String? cardType;

  const CardComponent({super.key, this.onTap, this.cardType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: SizedBox(
        height: 0.1.sh,
        width: 0.3.sw,
        child: Stack(
          children: [
            Image.asset(IconImages.cardImage),
            Positioned(
                right: 0.05.sw,
                top: 0.01.sh,
                child: SizedBox(
                  width: 0.1.sw,
                  child: Text(
                    cardType!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
