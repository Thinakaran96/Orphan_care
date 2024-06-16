import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_donation_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_adopt_request_model.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/input_box_widget.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';
import 'package:orphan_care/app/ui/widgets/radio_button_component.dart';

class TrustAdoptFormScreen extends StatefulWidget {
  const TrustAdoptFormScreen({super.key});

  @override
  State<TrustAdoptFormScreen> createState() => _TrustAdoptFormScreenState();
}

class _TrustAdoptFormScreenState extends State<TrustAdoptFormScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobNameController = TextEditingController();
  final _placeController = TextEditingController();
  final _annualIncomeController = TextEditingController();
  final _occupationController = TextEditingController();
  final _drivingLicenseController = TextEditingController();
  TrustAdoptRequestModel adoptRequesterData =
      Get.arguments["adoptRequesterDetails"];

  setInitialValues() {
    _firstNameController.text = adoptRequesterData.firstName!;
    _lastNameController.text = adoptRequesterData.lastName!;
    _contactNumberController.text = adoptRequesterData.phoneNumber!;
    _emailController.text = adoptRequesterData.email!;
    _addressController.text = adoptRequesterData.address!;
    _dobNameController.text = adoptRequesterData.dob!;
    _placeController.text = adoptRequesterData.city!;
    _annualIncomeController.text = adoptRequesterData.annualIncome!;
    _occupationController.text = adoptRequesterData.occupation!;
    _drivingLicenseController.text = adoptRequesterData.drivingLic!;
  }

  @override
  void initState() {
    setInitialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(
          title: Constants.adoptForm,
          actionWidget: SizedBox(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.name,
                    numberKeyboard: false,
                    emptyValidation: false,
                    autoValidation: false,
                    emailKeyBoard: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _firstNameController,
                  ),
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.lastName,
                    numberKeyboard: false,
                    autoValidation: false,
                    emptyValidation: false,
                    emailKeyBoard: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _lastNameController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.contactNumber,
                    numberKeyboard: true,
                    emptyValidation: false,
                    autoValidation: false,
                    emailKeyBoard: false,
                    isEnabled: false,
                    numberLength: 10,
                    validationLogic: (value) {},
                    inputBoxController: _contactNumberController,
                  ),
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.email,
                    numberKeyboard: false,
                    emptyValidation: false,
                    autoValidation: false,
                    emailKeyBoard: true,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _emailController,
                  ),
                ],
              ),
              InputBoxWidget(
                height: 0.045.sh,
                width: 1.sw,
                labelText: Constants.address,
                numberKeyboard: false,
                emptyValidation: false,
                emailKeyBoard: false,
                autoValidation: false,
                isEnabled: false,
                validationLogic: (value) {},
                inputBoxController: _addressController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.3.sw,
                    child: RadioButtonComponent(
                        initialValue: adoptRequesterData.gender,
                        labelText: Constants.gender,
                        buttonValuesList: const ["Male", "Female"],
                        validationLogic: (selectedValue) {},
                        isEnabled: false),
                  ),
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.dob,
                    numberKeyboard: false,
                    emailKeyBoard: false,
                    emptyValidation: false,
                    autoValidation: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _dobNameController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.place,
                    numberKeyboard: false,
                    emptyValidation: false,
                    emailKeyBoard: false,
                    autoValidation: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _placeController,
                  ),
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.annualIncome,
                    numberKeyboard: false,
                    emptyValidation: false,
                    emailKeyBoard: false,
                    autoValidation: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _annualIncomeController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.occupation,
                    numberKeyboard: false,
                    emptyValidation: false,
                    isEnabled: false,
                    emailKeyBoard: false,
                    autoValidation: false,
                    validationLogic: (value) {},
                    inputBoxController: _occupationController,
                  ),
                  InputBoxWidget(
                    height: 0.045.sh,
                    width: 0.4.sw,
                    labelText: Constants.drivingLicenceNumber,
                    numberKeyboard: false,
                    emptyValidation: false,
                    autoValidation: false,
                    emailKeyBoard: false,
                    isEnabled: false,
                    validationLogic: (value) {},
                    inputBoxController: _drivingLicenseController,
                  ),
                ],
              ),
              SizedBox(
                width: 1.sw,
                child: RadioButtonComponent(
                    initialValue: adoptRequesterData.maritalStatus,
                    labelText: Constants.maritalStatus,
                    buttonValuesList: const [
                      "Single",
                      "Married",
                      "divorced",
                      "Domestic Partnership"
                    ],
                    validationLogic: (selectedValue) {},
                    isEnabled: false),
              ),
              SizedBox(
                width: 0.8.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLoginButtonWidget(
                      height: 0.005.sh,
                      width: 0.2.sw,
                      buttonFunction: () async => await declineFunction(),
                      buttonText: Constants.decline,
                      buttonTextStyle: const TextStyle(color: Colors.white),
                      elevatedButtonStyle: adoptFormButtonStyle,
                      isLoading: trustController.notificationUpdateLoading,
                    ),
                    CustomLoginButtonWidget(
                      height: 0.005.sh,
                      width: 0.2.sw,
                      buttonFunction: () async => acceptFunction(),
                      buttonText: Constants.accept,
                      buttonTextStyle: const TextStyle(color: Colors.white),
                      elevatedButtonStyle: adoptFormButtonStyle,
                      isLoading: trustController.notificationUpdateLoading,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  String reverseStringUsingSplit(String input) {
    List<String> characters = input.split('');
    characters = characters.reversed.toList();
    String reversedString = characters.join('');
    return reversedString;
  }

  declineFunction() async {
    var donorNotificationData = DonorNotificationModel(
        requestId: reverseStringUsingSplit(adoptRequesterData.phoneNumber!),
        date: DateFormat.yMMMEd().format(DateTime.now()),
        isAccepted: false,
        donorNotificationTrustProfile: trustController.trustProfileModel);
    try {
      trustController.notificationUpdateLoading = true;
      await commonController.putDataBaseByKey(
          donorNotificationData,
          Constants.orphanDataBase,
          "${adoptRequesterData.phoneNumber}${Constants.donorNotificationDataKey}");
      trustController.notificationUpdateLoading = false;

      Get.back();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const MessageWidget(
            isAdoptSubmitted: false,
            isPayment: false,
            isAdoptRequestDeclined: true,
            isFeedback: false,
            isAdoptRequestAccepted: false,
            isPaymentSuccess: false,
          ),
        ),
      );
      deleteRequest();
    } catch (err) {
      print(err);
      trustController.notificationUpdateLoading = false;
      await CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  acceptFunction() async {
    var donorNotificationData = DonorNotificationModel(
        requestId: reverseStringUsingSplit(adoptRequesterData.phoneNumber!),
        date: DateFormat.yMMMEd().format(DateTime.now()),
        isAccepted: true,
        donorNotificationTrustProfile: trustController.trustProfileModel);
    try {
      trustController.notificationUpdateLoading = true;
      await commonController.putDataBaseByKey(
          donorNotificationData,
          Constants.orphanDataBase,
          "${adoptRequesterData.phoneNumber}${Constants.donorNotificationDataKey}");
      trustController.notificationUpdateLoading = false;

      Get.back();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const MessageWidget(
            isAdoptSubmitted: false,
            isPayment: false,
            isAdoptRequestDeclined: false,
            isFeedback: false,
            isAdoptRequestAccepted: true,
            isPaymentSuccess: false,
          ),
        ),
      );
      deleteRequest();
    } catch (err) {
      print(err);
      trustController.notificationUpdateLoading = false;
      await CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  deleteRequest() {
    List<TrustAdoptRequestModel> removeList = [];
    if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
        "${trustController.trustProfileModel.mobNumber}-${Constants.donorAdoptionRequestDataKey}-${adoptRequesterData.phoneNumber}")) {
      commonController.deleteValueDataBaseIndexByKey(Constants.orphanDataBase,
          "${trustController.trustProfileModel.mobNumber}-${Constants.donorAdoptionRequestDataKey}-${adoptRequesterData.phoneNumber}");
      for (var element in trustController.trustAdoptRequestList) {
        if (element.phoneNumber == adoptRequesterData.phoneNumber) {
          removeList.add(element);
        }
      }
      trustController.trustAdoptRequestList
          .removeWhere((element) => removeList.contains(element));
    }
  }
}
