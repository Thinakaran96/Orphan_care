import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/app_feed_back_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/feedback_widget.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  int selectedIndex = -1;
  final _feedBackController = TextEditingController();
  CommonController commonController = Get.find<CommonController>();
  TrustController trustController = Get.find<TrustController>();
  bool isTrust = false;
  TrustProfileModel trustData = TrustProfileModel();
  DonorSignUPModel donorData = DonorSignUPModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Get.arguments["isTrust"] != null) {
      isTrust = Get.arguments["isTrust"];
    }
    if (Get.arguments["trustData"] != null) {
      trustData = Get.arguments["trustData"];
    }
    if (Get.arguments["donorData"] != null) {
      donorData = Get.arguments["donorData"];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Rating",
        actionWidget: SizedBox(),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enter your Ratings......",
                  style: appBarTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10.r),
                    height: 0.58.sh,
                    width: 0.8.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: textColor)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 0.34.sh,
                            width: 0.8.sw,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      print(selectedIndex);
                                    },
                                    child: FeedbackWidget(
                                      initialRating: index + 1,
                                      isSelected: selectedIndex == index,
                                    ));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },
                            ),
                          ),
                          Container(
                            width: 0.8.sw,
                            decoration: BoxDecoration(
                                border: Border.all(color: textColor),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: TextFormField(
                              maxLines: 5,
                              maxLength: 300,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill some words about our app";
                                } else {
                                  _feedBackController.text = value;
                                }
                                return null;
                              },
                              controller: _feedBackController,
                              decoration: InputDecoration(
                                  hintText: "Your review......",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.r)),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                CustomLoginButtonWidget(
                    elevatedButtonStyle: loginButtonStyle,
                    height: 0.005.sh,
                    width: 0.2.sw,
                    buttonFunction: () {
                      if (_formKey.currentState!.validate()) {
                        saveAppFeedBackDetailsFunction();
                      }
                    },
                    buttonText: "Submit"),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  double sum = 0;
  double averageRating = 0.0;

  saveAppFeedBackDetailsFunction() async {
    double sum = 0;
    String? name = isTrust ? trustData.trustName : donorData.donorName;
    print(isTrust);
    try {
      await getEmergencyData();

      if (appFbList.isNotEmpty) {
        for (var element in appFbList) {
          sum += element.ratingValue!;
        }
      }

      double rating = selectedIndex + 1.0;

      double average = (sum + rating) / (appFbList.length + 1);
      averageRating = average;
      print(name);
      print("++++++++++");
      var appFeedBackModel = AppFeedBackModel(
        feedBackReview: _feedBackController.text,
        ratingValue: rating,
        phoneNumber: isTrust ? trustData.mobNumber : donorData.phoneNumber,
        name: name ?? "",
        averageRating: averageRating.toStringAsFixed(1),
      );
      appFbList.add(appFeedBackModel);

      var feedBackData = AppFeedBackList(appFeedBackList: appFbList);
      await commonController.putDataBaseByKey(
          feedBackData, Constants.orphanDataBase, Constants.appFeedBackKey);
      Get.back();
      CommonFunctions.customToast(Constants.savedSuccessfully);
      Navigator.of(context).push(
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
      _feedBackController.clear();
      selectedIndex = -1;
    } catch (err) {
      CommonFunctions.customToast(Constants.errorMessage);
      print(err);
    }
  }
}
