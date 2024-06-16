import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonorSignUpScreen extends StatefulWidget {
  const DonorSignUpScreen({super.key});

  @override
  State<DonorSignUpScreen> createState() => _DonorSignUpScreenState();
}

class _DonorSignUpScreenState extends State<DonorSignUpScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();

  final _donorNameController = TextEditingController();
  final _donorEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phNumController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: Form(
            key: _formKey,
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 0.07.sh),
                    Image.asset(IconImages.logo, height: 0.3.sh, width: 0.7.sw),
                    Container(
                      height: 0.63.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80.r),
                              topRight: Radius.circular(80.r)),
                          color: appBarTopColor),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 0.05.sh),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _donorNameController,
                                labelText: Constants.userName,
                                emptyValidation: true,
                                emptyValidationText:
                                    Constants.userNameValidationText,
                                validationLogic: (value) {},
                              ),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _donorEmailController,
                                labelText: Constants.email,
                                emptyValidation: true,
                                emptyValidationText:
                                    Constants.emailEmptyValidationText,
                                validationLogic: (value) =>
                                    CommonFunctions.validateEmail(value),
                              ),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _phNumController,
                                labelText: Constants.mobNumber,
                                emptyValidation: true,
                                numberKeyboard: true,
                                numberLimit: 10,
                                emptyValidationText:
                                    Constants.phNumberEmptyValidationText,
                                validationLogic: (value) =>
                                    CommonFunctions.validateMobileNumber(value),
                              ),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _passwordController,
                                labelText: Constants.password,
                                emptyValidationText:
                                    Constants.passwordValidationText,
                                validationLogic: (value) =>
                                    CommonFunctions.validatePassword(value),
                                isPassword: true,
                                emptyValidation: true,
                              ),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _confirmPasswordController,
                                labelText: Constants.confirmPassword,
                                emptyValidationText:
                                    Constants.confirmPasswordValidationText,
                                validationLogic: (value) =>
                                    CommonFunctions.validateConfirmPassword(
                                        value, _passwordController.text),
                                isPassword: true,
                                emptyValidation: true,
                              ),
                              SizedBox(height: 0.01.sh),
                              CustomLoginButtonWidget(
                                  elevatedButtonStyle: loginButtonStyle,
                                  height: 0.055.sh,
                                  width: 0.5.sw,
                                  buttonTextStyle: buttonTextStyle,
                                  buttonFunction: () => donorSignUpFunction(),
                                  buttonText: Constants.signUp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(Constants.alreadyHaveAnAccount,
                                      style: donationHistoryNameTextStyle),
                                  const SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(Constants.signIn,
                                          style: textButtonStyle))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  donorSignUpFunction() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      var donorSignUpData = DonorSignUPModel(
        donorName: _donorNameController.text,
        email: _donorEmailController.text,
        phoneNumber: _phNumController.text,
        password: _confirmPasswordController.text,
      );
      try {
        donorController.donorSignUpLoading = true;
        if (commonController.checkKeyContainsInDataBase(
            Constants.orphanDataBase,
            "${_phNumController.text}${Constants.donorProfileDataKey}")) {
          await CommonFunctions.customToast(Constants.numberExistErrorMsg);
          donorController.donorSignUpLoading = false;
        } else {
          await commonController.putDataBaseByKey(
              donorSignUpData,
              Constants.orphanDataBase,
              "${_phNumController.text}${Constants.donorProfileDataKey}");
          donorController.donorSignUpLoading = false;
          await CommonFunctions.customToast(Constants.signUpSuccessMessage);
          print("sign up successfull");
          Get.back();
        }
      } catch (err) {
        donorController.donorSignUpLoading = false;
        print("sign up failed");
        await CommonFunctions.customToast(Constants.errorMessage);
      }
    }
  }
}
