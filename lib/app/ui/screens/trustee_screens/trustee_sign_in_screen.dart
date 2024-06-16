import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/common_text_field_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrusteeSignInScreen extends StatefulWidget {
  const TrusteeSignInScreen({super.key});

  @override
  State<TrusteeSignInScreen> createState() => _TrusteeSignInScreenState();
}

class _TrusteeSignInScreenState extends State<TrusteeSignInScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  final TextEditingController _trustMobNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(IconImages.logo, height: 0.4.sh, width: 0.7.sw),
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
                                  "Trust",
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
                                  numberLimit: 10,
                                  numberKeyboard: true,
                                  inputBoxController: _trustMobNumController,
                                  labelText: Constants.mobileNumber,
                                  emptyValidation: true,
                                  emptyValidationText:
                                      Constants.phNumberEmptyValidationText,
                                  validationLogic: (value) =>
                                      CommonFunctions.validateMobileNumber(
                                          value),
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
                                    isLoading:
                                        trustController.trustSignInLoading,
                                    height: 0.05.sh,
                                    width: 0.4.sw,
                                    buttonTextStyle: buttonTextStyle,
                                    buttonFunction: () async =>
                                        await trustSignInFunction(),
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
                                                    Routes.trustSignUpScreen),
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
          ),
        ),
      ),
    );
  }

  trustSignInFunction() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        trustController.trustSignInLoading = true;
        await getTrustUser();
        trustController.trustSignInLoading = false;
      } catch (err) {
        trustController.trustSignInLoading = false;
        await CommonFunctions.customToast(Constants.errorMessage);
        print(err);
      }
    }
  }

  getTrustUser() async {
    var trustDataBase = Hive.box(Constants.orphanDataBase);
    print(trustDataBase.values.length);
    if (trustDataBase.values.isNotEmpty) {
      print(trustDataBase.values.length);
      if (commonController.checkKeyContainsInDataBase(Constants.orphanDataBase,
          "${_trustMobNumController.text}${Constants.trustProfileDataKey}")) {
        trustController.trustProfileModel =
            await commonController.getDataBaseByKey(Constants.orphanDataBase,
                "${_trustMobNumController.text}${Constants.trustProfileDataKey}");

        if (trustController.trustProfileModel.mobNumber ==
                _trustMobNumController.text &&
            trustController.trustProfileModel.password ==
                _passwordController.text) {
          print("login Successfull");
          await Get.offAllNamed(Routes.trustDashBoardScreen, arguments: {
            "trustProfileModel": trustController.trustProfileModel
          });
        } else {
          print("login fail");
          await CommonFunctions.customToast(Constants.userNameIncorrectMessage);
        }
      } else {
        await CommonFunctions.customToast(Constants.signUpHere);
        await CommonFunctions.navigateScreen(context, Routes.trustSignUpScreen);
      }
    } else {
      await CommonFunctions.customToast(Constants.signUpHere);
      await CommonFunctions.navigateScreen(context, Routes.trustSignUpScreen);
    }
  }
}
