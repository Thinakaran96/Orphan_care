import 'package:flutter/material.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrusteeSignUpScreen extends StatefulWidget {
  const TrusteeSignUpScreen({super.key});

  @override
  State<TrusteeSignUpScreen> createState() => _TrusteeSignUpScreenState();
}

class _TrusteeSignUpScreenState extends State<TrusteeSignUpScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  final _trustNameController = TextEditingController();
  final _trustEmailController = TextEditingController();
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
                                inputBoxController: _trustNameController,
                                labelText: Constants.trustName,
                                emptyValidation: true,
                                emptyValidationText:
                                    Constants.trustNameValidationText,
                                validationLogic: (value) {},
                              ),
                              TextFormFieldWidget(
                                height: 0.08.sh,
                                width: 0.8.sw,
                                inputBoxController: _trustEmailController,
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
                                numberLimit: 10,
                                numberKeyboard: true,
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
                              Obx(() => CustomLoginButtonWidget(
                                  elevatedButtonStyle: loginButtonStyle,
                                  isLoading: trustController.trustUpdateLoading,
                                  height: 0.055.sh,
                                  width: 0.5.sw,
                                  buttonTextStyle: buttonTextStyle,
                                  buttonFunction: () async =>
                                      await trustSignUpFunction(),
                                  buttonText: Constants.signUp)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Constants.alreadyHaveAnAccount,
                                    style: donationHistoryNameTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
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

  trustSignUpFunction() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      var trustSignUpData = TrustProfileModel(
        trustName: _trustNameController.text,
        email: _trustEmailController.text,
        mobNumber: _phNumController.text,
        password: _confirmPasswordController.text,
      );
      try {
        trustController.trustUpdateLoading = true;
        if (commonController.checkKeyContainsInDataBase(
            Constants.orphanDataBase,
            "${_phNumController.text}${Constants.trustProfileDataKey}")) {
          await CommonFunctions.customToast(Constants.numberExistErrorMsg);
          trustController.trustUpdateLoading = false;
        } else {
          await commonController.putDataBaseByKey(
              trustSignUpData,
              Constants.orphanDataBase,
              "${_phNumController.text}${Constants.trustProfileDataKey}");
          trustController.trustUpdateLoading = false;
          await CommonFunctions.customToast(Constants.signUpSuccessMessage);
          Get.back();
        }
      } catch (err) {
        trustController.trustUpdateLoading = false;
        await CommonFunctions.customToast(Constants.errorMessage);
      }
    }
  }
}
