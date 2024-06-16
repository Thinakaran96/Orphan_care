import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/common_text_field_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:orphan_care/app/ui/widgets/radio_button_component.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  var imageFile;
  bool profileUploaded = false;
  String? state = "Tamil Nadu";
  String? maritalStatus = "Single";
  Uint8List? decodedBytes;
  bool isEnabled = false;
  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _dobController = TextEditingController();
  final _livesInController = TextEditingController();
  final _addressController = TextEditingController();

  setInitialValue() {
    _nameController.text = donorController.donorSignUPModel.donorName ?? "";
    _phNumController.text = donorController.donorSignUPModel.phoneNumber ?? "";
    _emailController.text = donorController.donorSignUPModel.email ?? "";
    _occupationController.text =
        donorController.donorSignUPModel.occupation ?? "";
    _dobController.text = donorController.donorSignUPModel.dob ?? "";
    _livesInController.text = donorController.donorSignUPModel.livesIn ?? "";
    _addressController.text = donorController.donorSignUPModel.address ?? "";
    state = donorController.donorSignUPModel.stateName ?? "";
    maritalStatus = donorController.donorSignUPModel.maritalStatus ?? "";
  }

  @override
  Widget build(BuildContext context) {
    setInitialValue();
    return Obx(() {
      if (donorController.donorSignUPModel.base64String != null) {
        decodedBytes =
            base64.decode(donorController.donorSignUPModel.base64String!);
      }
      setInitialValue();
      return Scaffold(
        appBar: CustomAppBar(
          title: Constants.profile,
          actionWidget: TextButton(
              onPressed: () => CommonFunctions.navigateScreen(
                  context, Routes.donorEditProfileScreen),
              child: Text(
                Constants.edit,
                style: labelTextStyle,
              )),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.r),
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15.r)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: profileUploaded
                        ? Container(
                            height: 0.15.sh,
                            width: 0.3.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                image: DecorationImage(
                                    image: FileImage(imageFile),
                                    fit: BoxFit.fill)),
                          )
                        : donorController.donorSignUPModel.base64String != null
                            ? Container(
                                height: 0.15.sh,
                                width: 0.3.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: MemoryImage(decodedBytes!)),
                                ),
                              )
                            : Container(
                                height: 0.15.sh,
                                width: 0.3.sw,
                                decoration: BoxDecoration(
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0,
                                          offset: Offset(0.0, 0.75))
                                    ],
                                    color: backgroundColor,
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            IconImages.donorProfileImage)),
                                    border: Border.all(color: textColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.r))),
                              ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.name,
                      inputBoxController: _nameController,
                      emptyValidation: true,
                      emptyValidationText: Constants.nameValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.mobNumber,
                      inputBoxController: _phNumController,
                      numberKeyboard: true,
                      numberLimit: 10,
                      emptyValidation: true,
                      emptyValidationText:
                          Constants.phNumberEmptyValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.email,
                      inputBoxController: _emailController,
                      emptyValidation: true,
                      emptyValidationText: Constants.emailEmptyValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.address,
                      inputBoxController: _addressController,
                      emptyValidation: true,
                      emptyValidationText:
                          Constants.address1EmptyValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropDown( hintText: "Choose",
                    isEnabled: isEnabled,
                    labelText: Constants.state,
                    currentItem: state,
                    width: 350.w,
                    height: 45.h,
                    chosenValue: (value) {},
                    dropDownItems: Constants.stateList,
                    emptyValidation: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Details",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.occupation,
                      inputBoxController: _occupationController,
                      emptyValidation: true,
                      emptyValidationText:
                          Constants.occupationEmptyValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 0.3.sw,
                    child: RadioButtonComponent(
                        initialValue:
                            donorController.donorSignUPModel.gender ?? "Male",
                        labelText: Constants.gender,
                        buttonValuesList: const ["Male", "Female", "Others"],
                        validationLogic: (selectedValue) {},
                        isEnabled: isEnabled),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropDown( hintText: "Choose",
                    isEnabled: isEnabled,
                    labelText: Constants.maritalStatus,
                    currentItem: maritalStatus,
                    width: 350.w,
                    height: 45.h,
                    chosenValue: (value) {},
                    dropDownItems: Constants.maritalStatusList,
                    emptyValidation: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.dob,
                      inputBoxController: _dobController,
                      emptyValidation: true,
                      emptyValidationText: Constants.dobEmptyValidationText,
                      validationLogic: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.livesIn,
                      inputBoxController: _livesInController,
                      emptyValidation: true,
                      emptyValidationText: Constants.livesInEmptyValidationText,
                      validationLogic: (value) {}),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
