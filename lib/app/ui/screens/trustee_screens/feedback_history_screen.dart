import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_feedback_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';

class FeedBackHistoryScreen extends StatefulWidget {
  const FeedBackHistoryScreen({super.key});

  @override
  State<FeedBackHistoryScreen> createState() => _FeedBackHistoryScreenState();
}

class _FeedBackHistoryScreenState extends State<FeedBackHistoryScreen> {
  TrustProfileModel trustData = Get.arguments["trustData"];
  bool isTrustDashBoard = Get.arguments["isTrustDashBoard"];
  final _feedBackController = TextEditingController();
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorController donorController = Get.find<DonorController>();
  final _formKey = GlobalKey<FormState>();
  var dataBase = Hive.box(Constants.orphanDataBase);
  TrustFeedBackList feedBackListData = TrustFeedBackList();

  Future getOthersFeedBackHistory() async {
    try {
      trustController.getTrustFeedBackHistoryLoading = true;
      trustController.trustFeedBackHistoryList = [];
      for (var element in dataBase.keys) {
        if (element == "${trustData.mobNumber}-${Constants.trustFeedBackKey}") {
          feedBackListData = commonController.getDataBaseByKey(
              Constants.orphanDataBase,
              "${trustData.mobNumber}-${Constants.trustFeedBackKey}");
          trustController.trustFeedBackHistoryList =
              feedBackListData.feedBackList ?? [];
        }
      }
      trustController.getTrustFeedBackHistoryLoading = false;
      return trustController.trustFeedBackHistoryList;
    } catch (err) {
      trustController.getTrustFeedBackHistoryLoading = false;
      if (kDebugMode) {
        print(err);
      }
      return err;
    }
  }

  @override
  void initState() {
    getOthersFeedBackHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButton: isTrustDashBoard
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: () async => await addRatingBottomSheet(),
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  child: const Text(
                    "Add Review",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          appBar: CustomAppBar(
            title:
                isTrustDashBoard ? "Feedback history" : "Give your feed back",
            actionWidget: SizedBox(),
          ),
          body: trustController.putFeedBackLoading ||
                  trustController.getTrustFeedBackHistoryLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : trustController.trustFeedBackHistoryList.isEmpty
                  ? Center(
                      child: Text(isTrustDashBoard
                          ? "No feedback"
                          : "No feedback about this trust"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(13.0).r,
                      child: ListView.separated(
                        itemCount:
                            trustController.trustFeedBackHistoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                            color: tableColor,
                            child: ListTile(
                                title: Text(trustController
                                    .trustFeedBackHistoryList[index]
                                    .feedBackReview!),
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
                                      Text(trustController
                                          .trustFeedBackHistoryList[index]
                                          .ratingValue!
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

  Future addRatingBottomSheet() async {
    _feedBackController.clear();
    return await Get.bottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      Container(
        decoration: BoxDecoration(
          color: tableColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ).r,
        ),
        height: 0.5.sh,
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "What is your rate?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RatingBar.builder(
                            initialRating: commonController.ratingValue,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            ignoreGestures: false,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 1.sp,
                            ),
                            onRatingUpdate: (double value) {
                              commonController.ratingValue = value;
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Please share your opinion about us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 0.8.sw,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: TextFormField(
                              maxLines: 5,
                              controller: _feedBackController,
                              decoration: InputDecoration(
                                  hintText: "Your review......",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.r)),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please fill the comment";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async => trustFeedBackSaveFunction(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    commonController.ratingValue = 1.0;
                    _feedBackController.clear();
                    Get.back();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  trustFeedBackSaveFunction() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        trustController.putFeedBackLoading = true;
        await putTrustFeedbackData();
        trustController.putFeedBackLoading = false;
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const MessageWidget(
              isAdoptSubmitted: false,
              isFeedback: true,
              isPayment: false,
              isAdoptRequestDeclined: false,
              isAdoptRequestAccepted: false,
              isPaymentSuccess: false,
            ),
          ),
        );
        Get.back();
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
        trustController.putFeedBackLoading = false;
        CommonFunctions.customToast(Constants.errorMessage);
      }
    }
  }

  double averageRating = 0.0;
  double sum = 0;

  putTrustFeedbackData() async {
    sum = 0;
    List<TrustFeedBackModel> list = <TrustFeedBackModel>[];
    TrustFeedBackList data = TrustFeedBackList();
    if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
        "${trustData.mobNumber}-${Constants.trustFeedBackKey}")) {
      data = commonController.getDataBaseByKey(Constants.orphanDataBase,
          "${trustData.mobNumber}-${Constants.trustFeedBackKey}");

      list = data.feedBackList!;
    }

    if (list.isNotEmpty) {
      for (var element in list) {
        sum += element.ratingValue!;
      }
    }

    double average = (sum + commonController.ratingValue) / (list.length + 1);
    averageRating = average;

    var trustFeedBackData = TrustFeedBackModel(
      feedBackReview: _feedBackController.text,
      ratingValue: commonController.ratingValue,
      trustPhoneNumber: trustData.mobNumber,
      averageRating: averageRating.toStringAsFixed(1),
    );

    list.add(trustFeedBackData);

    TrustFeedBackList trustFeedBackList = TrustFeedBackList(feedBackList: list);

    await commonController.putDataBaseByKey(
        trustFeedBackList,
        Constants.orphanDataBase,
        "${trustData.mobNumber}-${Constants.trustFeedBackKey}");
    saveProfileData();
    commonController.ratingValue = 1.0;
  }

  saveProfileData() async {
    if (_formKey.currentState!.validate()) {
      var trustProfileData = TrustProfileModel(
        base64String: trustData.base64String,
        address: trustData.address,
        stateName: trustData.stateName,
        status: trustData.status,
        onlyFor: trustData.onlyFor,
        trustName: trustData.trustName,
        category: trustData.category,
        mobNumber: trustData.mobNumber,
        careTakerName: trustData.careTakerName,
        membersCount: trustData.membersCount,
        uPIId: trustData.uPIId,
        email: trustData.email,
        accountNumber: trustData.accountNumber,
        confirmPassword: trustData.confirmPassword,
        password: trustData.password,
        averageStarRating: averageRating.toStringAsFixed(1),
      );
      try {
        trustController.trustUpdateLoading = true;
        await commonController.putDataBaseByKey(
            trustProfileData,
            Constants.orphanDataBase,
            "${trustData.mobNumber}${Constants.trustProfileDataKey}");

        trustController.trustProfileModel =
            await commonController.getDataBaseByKey(Constants.orphanDataBase,
                "${trustData.mobNumber}${Constants.trustProfileDataKey}");

        trustController.trustUpdateLoading = false;
      } catch (err) {
        trustController.trustUpdateLoading = false;
        print(err.toString());
        CommonFunctions.customToast(Constants.errorMessage);
        return err;
      }
    }
  }
}
