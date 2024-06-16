import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_adopt_request_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/input_box_widget.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';
import 'package:orphan_care/app/ui/widgets/radio_button_component.dart';

class DonorAdoptionFormScreen extends StatefulWidget {
  const DonorAdoptionFormScreen({super.key});

  @override
  State<DonorAdoptionFormScreen> createState() =>
      _DonorAdoptionFormScreenState();
}

class _DonorAdoptionFormScreenState extends State<DonorAdoptionFormScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  DonorController donorController = Get.find<DonorController>();
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

  TrustProfileModel trustData = Get.arguments["trustData"];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _contactNumberController.text =
        donorController.donorSignUPModel.phoneNumber!;
    _firstNameController.text = donorController.donorSignUPModel.donorName!;
    _emailController.text = donorController.donorSignUPModel.email!;
    print(trustData.mobNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: Constants.adoptionApplicationForm,
          actionWidget: SizedBox(),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.r),
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
                      emptyValidation: true,
                      autoValidation: false,
                      emailKeyBoard: false,
                      isEnabled: false,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.firstName =
                            value;
                      },
                      inputBoxController: _firstNameController,
                    ),
                    InputBoxWidget(
                      height: 0.045.sh,
                      width: 0.4.sw,
                      labelText: Constants.lastName,
                      numberKeyboard: false,
                      autoValidation: false,
                      emptyValidation: true,
                      emailKeyBoard: false,
                      isEnabled: true,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.lastName = value;
                      },
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
                      emptyValidation: true,
                      autoValidation: false,
                      emailKeyBoard: false,
                      isEnabled: false,
                      numberLength: 10,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.phoneNumber =
                            value;
                      },
                      inputBoxController: _contactNumberController,
                    ),
                    InputBoxWidget(
                      height: 0.045.sh,
                      width: 0.4.sw,
                      labelText: Constants.email,
                      numberKeyboard: false,
                      emptyValidation: true,
                      autoValidation: false,
                      emailKeyBoard: true,
                      isEnabled: false,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.email = value;
                      },
                      inputBoxController: _emailController,
                    ),
                  ],
                ),
                InputBoxWidget(
                  height: 0.045.sh,
                  width: 1.sw,
                  labelText: Constants.address,
                  numberKeyboard: false,
                  emptyValidation: true,
                  emailKeyBoard: false,
                  autoValidation: false,
                  isEnabled: true,
                  validationLogic: (value) {
                    trustController.trustAdoptRequestModel.address = value;
                  },
                  inputBoxController: _addressController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.3.sw,
                      child: RadioButtonComponent(
                          initialValue: "Male",
                          labelText: Constants.gender,
                          buttonValuesList: const ["Male", "Female"],
                          validationLogic: (selectedValue) {
                            trustController.trustAdoptRequestModel.gender =
                                selectedValue;
                          },
                          isEnabled: true),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: InputBoxWidget(
                        height: 0.045.sh,
                        width: 0.4.sw,
                        labelText: Constants.dob,
                        numberKeyboard: false,
                        emailKeyBoard: false,
                        emptyValidation: true,
                        autoValidation: false,
                        isEnabled: false,
                        validationLogic: (value) {
                          trustController.trustAdoptRequestModel.dob = value;
                        },
                        inputBoxController: _dobNameController,
                      ),
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
                      emptyValidation: true,
                      emailKeyBoard: false,
                      autoValidation: false,
                      isEnabled: true,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.city = value;
                      },
                      inputBoxController: _placeController,
                    ),
                    InputBoxWidget(
                      height: 0.045.sh,
                      width: 0.4.sw,
                      labelText: Constants.annualIncome,
                      numberKeyboard: true,
                      numberLength: 10,
                      emptyValidation: true,
                      emailKeyBoard: false,
                      autoValidation: false,
                      isEnabled: true,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.annualIncome =
                            value;
                      },
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
                      emptyValidation: true,
                      isEnabled: true,
                      emailKeyBoard: false,
                      autoValidation: false,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.occupation =
                            value;
                      },
                      inputBoxController: _occupationController,
                    ),
                    InputBoxWidget(
                      height: 0.045.sh,
                      width: 0.4.sw,
                      labelText: Constants.drivingLicenceNumber,
                      numberKeyboard: false,
                      emptyValidation: true,
                      autoValidation: false,
                      emailKeyBoard: false,
                      isEnabled: true,
                      validationLogic: (value) {
                        trustController.trustAdoptRequestModel.drivingLic =
                            value;
                      },
                      inputBoxController: _drivingLicenseController,
                    ),
                  ],
                ),
                SizedBox(
                  width: 1.sw,
                  child: RadioButtonComponent(
                      initialValue: "Single",
                      labelText: Constants.maritalStatus,
                      buttonValuesList: Constants.maritalStatusList,
                      validationLogic: (selectedValue) {
                        trustController.trustAdoptRequestModel.maritalStatus =
                            selectedValue;
                      },
                      isEnabled: true),
                ),
                CustomLoginButtonWidget(
                  height: 0.005.sh,
                  width: 0.2.sw,
                  buttonFunction: () async => await requestAdoption(),
                  buttonText: Constants.submit,
                  buttonTextStyle: const TextStyle(color: Colors.white),
                  elevatedButtonStyle: adoptFormButtonStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  requestAdoption() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        var requestAdoptionData = TrustAdoptRequestModel(
            firstName: donorController.donorSignUPModel.donorName,
            lastName: trustController.trustAdoptRequestModel.lastName,
            phoneNumber: donorController.donorSignUPModel.phoneNumber,
            email: donorController.donorSignUPModel.email,
            address: trustController.trustAdoptRequestModel.address,
            gender: trustController.trustAdoptRequestModel.gender ?? "Male",
            dob: trustController.trustAdoptRequestModel.dob,
            city: trustController.trustAdoptRequestModel.city,
            annualIncome: trustController.trustAdoptRequestModel.annualIncome,
            occupation: trustController.trustAdoptRequestModel.occupation,
            drivingLic: trustController.trustAdoptRequestModel.drivingLic,
            maritalStatus:
                trustController.trustAdoptRequestModel.maritalStatus ??
                    "Single",
            whomAdopt: trustData.category);
        await commonController.putDataBaseByKey(
            requestAdoptionData,
            Constants.orphanDataBase,
            "${trustData.mobNumber}-${Constants.donorAdoptionRequestDataKey}-${donorController.donorSignUPModel.phoneNumber}");
        Get.back();
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const MessageWidget(
              isAdoptSubmitted: true,
              isPayment: false,
              isAdoptRequestDeclined: false,
              isFeedback: false,
              isAdoptRequestAccepted: false,
              isPaymentSuccess: false,
            ),
          ),
        );
        CommonFunctions.customToast(Constants.savedSuccessfully);
      } catch (err) {
        CommonFunctions.customToast(Constants.errorMessage);
        print(err);
      }
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobNameController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        donorController.donorSignUPModel.dob = _dobNameController.text;
      });
    }
  }
}
