import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                IconImages.logo,
                height: 0.43.sh,
                width: 0.7.sw,
              ),
              CustomLoginButtonWidget(
                elevatedButtonStyle: loginButtonStyle,
                height: 0.055.sh,
                width: 0.5.sw,
                buttonTextStyle: buttonTextStyle,
                buttonFunction: () async {
                  // Hive.box(Constants.orphanDataBase).clear();
                  await CommonFunctions.navigateScreen(
                      context, Routes.donorSignInScreen);
                },
                buttonText: Constants.donor,
              ),
              const SizedBox(height: 40),
              CustomLoginButtonWidget(
                elevatedButtonStyle: loginButtonStyle,
                height: 0.055.sh,
                width: 0.5.sw,
                buttonTextStyle: buttonTextStyle,
                buttonFunction: () => CommonFunctions.navigateScreen(
                    context, Routes.trusteeSignInScreen),
                buttonText: Constants.trustee,
              ),
              const SizedBox(height: 40),
              CustomLoginButtonWidget(
                elevatedButtonStyle: loginButtonStyle,
                height: 0.055.sh,
                width: 0.5.sw,
                buttonTextStyle: buttonTextStyle,
                buttonFunction: () => CommonFunctions.navigateScreen(
                    context, Routes.adminLogInScreen),
                buttonText: Constants.admin,
              )
            ],
          ),
        ),
      ),
    );
  }
}
