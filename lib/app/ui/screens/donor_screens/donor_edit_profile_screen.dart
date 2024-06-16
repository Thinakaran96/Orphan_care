import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/common_text_field_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:orphan_care/app/ui/widgets/radio_button_component.dart';

class DonorEditProfileScreen extends StatefulWidget {
  const DonorEditProfileScreen({super.key});

  @override
  State<DonorEditProfileScreen> createState() => _DonorEditProfileScreenState();
}

class _DonorEditProfileScreenState extends State<DonorEditProfileScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  var imageFile;
  bool profileUploaded = false;
  bool isEnabled = true;
  final picker = ImagePicker();
  Uint8List? decodedBytes;

  String? state = "Tamil Nadu";
  String? maritalStatus = "Single";
  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _dobController = TextEditingController();
  final _livesInController = TextEditingController();
  final _addressController = TextEditingController();

  setInitialValue() {
    if (donorController.donorSignUPModel.base64String != null) {
      decodedBytes =
          base64.decode(donorController.donorSignUPModel.base64String!);
    }
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
  void initState() {
    setInitialValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: Constants.editProfile,
          actionWidget: donorController.donorSignUpLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () async {
                    await saveProfileData();
                  },
                  child: Text(
                    Constants.save,
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: editButtonTextColor),
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
                                child: GestureDetector(
                                  onTap: () => showProfileUploadOption(context),
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
                                child: GestureDetector(
                                  onTap: () => showProfileUploadOption(context),
                                ),
                              ),
                  ),
                  const SizedBox(height: 20),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: isEnabled,
                      labelText: Constants.name,
                      inputBoxController: _nameController,
                      emptyValidation: true,
                      emptyValidationText: Constants.nameValidationText,
                      validationLogic: (value) {
                        donorController.donorSignUPModel.donorName = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFieldWidget(
                      width: 1.sw,
                      isEnabled: false,
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
                      validationLogic: (value) {
                        donorController.donorSignUPModel.email = value;
                      }),
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
                      validationLogic: (value) {
                        donorController.donorSignUPModel.address = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropDown(
                    isEnabled: isEnabled,
                    labelText: Constants.state,
                    currentItem: state,
                    width: 350.w,
                    height: 45.h,
                    hintText: "Choose",
                    chosenValue: (value) {
                      state = value;
                      donorController.donorSignUPModel.stateName = value;
                    },
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
                      validationLogic: (value) {
                        donorController.donorSignUPModel.occupation = value;
                      }),
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
                        validationLogic: (selectedValue) {
                          donorController.donorSignUPModel.gender =
                              selectedValue;
                        },
                        isEnabled: isEnabled),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropDown(
                    isEnabled: isEnabled,
                    labelText: Constants.maritalStatus,
                    currentItem: maritalStatus,
                    width: 350.w,
                    height: 45.h, hintText: "Choose",
                    chosenValue: (value) {
                      maritalStatus = value;
                      donorController.donorSignUPModel.maritalStatus = value;
                    },
                    dropDownItems: Constants.maritalStatusList,
                    emptyValidation: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: CommonTextFieldWidget(
                        isSuffixWidget: true,
                        suffixWidget: const Icon(Icons.calendar_month_outlined),
                        width: 1.sw,
                        isEnabled: false,
                        labelText: Constants.dob,
                        inputBoxController: _dobController,
                        emptyValidation: true,
                        emptyValidationText: Constants.dobEmptyValidationText,
                        validationLogic: (value) {
                          donorController.donorSignUPModel.dob = value;
                        }),
                  ),
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
                      validationLogic: (value) {
                        donorController.donorSignUPModel.livesIn = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  saveProfileData() async {
    String? bs64;
    if (imageFile != null) {
      String bs64 = await CommonFunctions.convertBase64String(imageFile.path);
      donorController.donorSignUPModel.base64String = bs64;
    }

    if (_formKey.currentState!.validate()) {
      var donorProfileData = DonorSignUPModel(
        donorName: donorController.donorSignUPModel.donorName,
        phoneNumber: donorController.donorSignUPModel.phoneNumber,
        base64String: donorController.donorSignUPModel.base64String,
        email: donorController.donorSignUPModel.email,
        confirmPassword: donorController.donorSignUPModel.confirmPassword,
        password: donorController.donorSignUPModel.password,
        stateName: donorController.donorSignUPModel.stateName,
        gender: donorController.donorSignUPModel.gender,
        dob: donorController.donorSignUPModel.dob,
        maritalStatus: donorController.donorSignUPModel.maritalStatus,
        occupation: donorController.donorSignUPModel.occupation,
      );
      try {
        donorController.donorSignUpLoading = true;
        await commonController.putDataBaseByKey(
            donorProfileData,
            Constants.orphanDataBase,
            "${_phNumController.text}${Constants.donorProfileDataKey}");
        print(
            "${donorController.donorSignUPModel.phoneNumber}${Constants.donorProfileDataKey}");
        donorController.donorSignUPModel = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${donorController.donorSignUPModel.phoneNumber}${Constants.donorProfileDataKey}");

        donorController.donorSignUpLoading = false;
        await CommonFunctions.customToast(
            Constants.profileUpdateSuccessMessage);
        Get.back();
      } catch (err) {
        donorController.donorSignUpLoading = false;
        print(err.toString());
        CommonFunctions.customToast(Constants.errorMessage);
        return err;
      }
    }
  }

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    imageFile = pickedFile != null
        ? File(
            pickedFile.path,
          )
        : null;
    if (imageFile != null) {
      setState(() {
        profileUploaded = true;
        // state = AppState.picked;
      });
    }
  }

  void showProfileUploadOption(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              color: appBarTopColor,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text(Constants.photoLibrary),
                      onTap: () {
                        chooseImage(ImageSource.gallery);

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text(Constants.camera),
                    onTap: () {
                      chooseImage(ImageSource.camera);

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
        _dobController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        donorController.donorSignUPModel.dob = _dobController.text;
      });
    }
  }
}
