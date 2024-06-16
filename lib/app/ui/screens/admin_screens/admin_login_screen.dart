import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
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
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Admin",
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
                                  CommonFunctions.validateMobileNumber(value),
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
                            SizedBox(height: 0.06.sh),
                            CustomLoginButtonWidget(
                                elevatedButtonStyle: loginButtonStyle,
                                height: 0.05.sh,
                                width: 0.4.sw,
                                buttonTextStyle: buttonTextStyle,
                                buttonFunction: () => adminLogInFunction(),
                                buttonText: Constants.login),
                            SizedBox(height: 0.05.sh),
                            CustomLoginButtonWidget(
                              elevatedButtonStyle: loginButtonStyle,
                              height: 0.03.sh,
                              width: 0.1.sw,
                              buttonTextStyle: backButtonTextStyle,
                              buttonFunction: () => Get.back(),
                              buttonText: Constants.back,
                            ),
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
    );
  }

  adminLogInFunction() {
    if (_formKey.currentState!.validate()) {
      if (_donorMobileController.text == Constants.adminUsername &&
          Constants.adminPassword == _passwordController.text) {
        Get.offAllNamed(Routes.adminDashBoardScreen);
      } else {
        CommonFunctions.customToast(Constants.userNameIncorrectMessage);
      }
    }
  }
}
