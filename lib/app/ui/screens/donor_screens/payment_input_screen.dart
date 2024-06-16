import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';

class PaymentInputScreen extends StatefulWidget {
  const PaymentInputScreen({super.key});

  @override
  State<PaymentInputScreen> createState() => _PaymentInputScreenState();
}

class _PaymentInputScreenState extends State<PaymentInputScreen> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String amountValue = "";
  TrustProfileModel trustData = Get.arguments["trustData"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
        actionWidget: SizedBox(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              SizedBox(height: 0.1.sh),
              TextFormFieldWidget(
                labelText: "₹ Enter Your Amount",
                inputBoxController: _amountController,
                validationLogic: (value) {},
                onChanged: (value) {
                  setState(() {
                    amountValue = _amountController.text;
                  });
                },
                numberLimit: 15,
                numberKeyboard: true,
                emptyValidation: true,
                emptyValidationText: "Please fill the amount",
                isEnabled: true,
              ),
              SizedBox(height: 0.05.sh),
              Container(
                height: 0.06.sh,
                width: 0.6.sw,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: buttonColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(amountValue,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  ],
                ),
              ),
              SizedBox(height: 0.03.sh),
              CustomLoginButtonWidget(
                height: 0.03.sh,
                width: 0.2.sw,
                buttonFunction: () => payButtonFunction(),
                buttonText: "Pay",
                elevatedButtonStyle: adoptFormButtonStyle,
                buttonTextStyle: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  payButtonFunction() {
    if (_formKey.currentState!.validate()) {
      CommonFunctions.navigateScreen(context, Routes.paymentOptionScreen,
          arguments: {"trustData": trustData,
          "amount" : amountValue});
    }
  }
}
