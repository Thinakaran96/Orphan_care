import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/common_text_field_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DonorSignInScreen extends StatefulWidget {
  const DonorSignInScreen({super.key});

  @override
  State<DonorSignInScreen> createState() => _DonorSignInScreenState();
}

class _DonorSignInScreenState extends State<DonorSignInScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final TextEditingController _donorMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    Image.asset(
                      IconImages.logo,
                      height: 0.4.sh,
                      width: 0.7.sw,
                    ),
                    Container(
                      height: 0.6.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80.r),
                              topRight: Radius.circular(80.r)),
                          color: appBarTopColor),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.all(20.r),
                            child: Column(
                              children: [
                                Text(
                                  "Donor",
                                  style: GoogleFonts.inter(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      color: textColor),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                CommonTextFieldWidget(
                                  width: 0.8.sw,
                                  inputBoxController: _donorMobileController,
                                  labelText: Constants.mobileNumber,
                                  emptyValidation: true,
                                  numberLimit: 10,
                                  emptyValidationText:
                                      Constants.phNumberEmptyValidationText,
                                  validationLogic: (value) =>
                                      CommonFunctions.validateMobileNumber(
                                          value),
                                  numberKeyboard: true,
                                ),
                                CommonTextFieldWidget(
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
                                SizedBox(height: 0.05.sh),
                                CustomLoginButtonWidget(
                                    elevatedButtonStyle: loginButtonStyle,
                                    height: 0.05.sh,
                                    width: 0.4.sw,
                                    buttonTextStyle: buttonTextStyle,
                                    buttonFunction: () => donorSignInFunction(),
                                    buttonText: Constants.login),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Constants.donHaveAnAccount,
                                      style: donationHistoryNameTextStyle,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                        onPressed: () async =>
                                            await CommonFunctions
                                                .navigateScreen(context,
                                                    Routes.donorSignUpScreen),
                                        child: Text(Constants.signUp,
                                            style: textButtonStyle))
                                  ],
                                ),
                                CustomLoginButtonWidget(
                                    elevatedButtonStyle: loginButtonStyle,
                                    height: 0.03.sh,
                                    width: 0.1.sw,
                                    buttonTextStyle: backButtonTextStyle,
                                    buttonFunction: () => Get.back(),
                                    buttonText: Constants.back),
                              ],
                            ),
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

  Future<void> donorSignInFunction() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        donorController.donorSignInLoading = true;
        await getDonorUserList();
        donorController.donorSignInLoading = false;
      } catch (err) {
        donorController.donorSignInLoading = false;
        await CommonFunctions.customToast(Constants.errorMessage);
        print(err);
      }
    }
  }

  getDonorUserList() async {
    var donorDataBase = Hive.box(Constants.orphanDataBase);
    if (donorDataBase.isNotEmpty) {
      if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
          "${_donorMobileController.text}${Constants.donorProfileDataKey}")) {
        donorController.donorSignUPModel =
            await commonController.getDataBaseByKey(Constants.orphanDataBase,
                "${_donorMobileController.text}${Constants.donorProfileDataKey}");
        if (donorController.donorSignUPModel.phoneNumber ==
                _donorMobileController.text &&
            donorController.donorSignUPModel.password ==
                _passwordController.text) {
          await Get.offAllNamed(Routes.donorDashBoardScreen, arguments: {
            "donorSignUPModel": donorController.donorSignUPModel
          });
        } else {
          await CommonFunctions.customToast(Constants.userNameIncorrectMessage);
        }
      } else {
        await CommonFunctions.customToast(Constants.signUpHere);
        CommonFunctions.navigateScreen(context, Routes.donorSignUpScreen);
      }
    } else {
      await CommonFunctions.customToast(Constants.signUpHere);
      CommonFunctions.navigateScreen(context, Routes.donorSignUpScreen);
    }
  }
}
