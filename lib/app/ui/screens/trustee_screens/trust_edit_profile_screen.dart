import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/common_text_field_widget.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:image_picker/image_picker.dart';

class TrustEditProfileScreen extends StatefulWidget {
  const TrustEditProfileScreen({super.key});

  @override
  State<TrustEditProfileScreen> createState() => _TrustEditProfileScreenState();
}

class _TrustEditProfileScreenState extends State<TrustEditProfileScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var imageFile;
  bool profileUploaded = false;
  Uint8List? decodedBytes;
  bool isEnabled = true;

  final _nameController = TextEditingController();
  final _mobNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _careTakerNameController = TextEditingController();
  final _onlyForController = TextEditingController();
  final _memberCountController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _accNUmController = TextEditingController();
  final _upiIdController = TextEditingController();

  String? category;
  String? status;
  String? state;

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  setInitialValue() {
    if (trustController.trustProfileModel.base64String != null) {
      decodedBytes =
          base64.decode(trustController.trustProfileModel.base64String!);
    }
    _nameController.text = trustController.trustProfileModel.trustName ?? "";
    _onlyForController.text = trustController.trustProfileModel.onlyFor ?? "";
    category = trustController.trustProfileModel.category;
    _mobNumController.text = trustController.trustProfileModel.mobNumber ?? "";
    _emailController.text = trustController.trustProfileModel.email ?? "";
    _careTakerNameController.text =
        trustController.trustProfileModel.careTakerName ?? "";
    _memberCountController.text =
        trustController.trustProfileModel.membersCount ?? "";
    _upiIdController.text = trustController.trustProfileModel.uPIId ?? "";
    _address1Controller.text = trustController.trustProfileModel.address ?? "";
    state = trustController.trustProfileModel.stateName;
    status = trustController.trustProfileModel.status;
    _accNUmController.text =
        trustController.trustProfileModel.accountNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Constants.editProfile,
        actionWidget: trustController.trustUpdateLoading
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  saveProfileData();
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
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.black),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: profileUploaded
                      ? Container(
                          width: double.infinity,
                          height: 0.2.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.fill)),
                        )
                      : trustController.trustProfileModel.base64String != null
                          ? Container(
                              width: double.infinity,
                              height: 0.2.sh,
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
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage(IconImages.trustProfile)),
                                  border:
                                      Border.all(color: profileBackgroundColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.r))),
                              child: GestureDetector(
                                onTap: () => showProfileUploadOption(context),
                              ),
                            ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Profile"),
                CommonTextFieldWidget(
                    width: 1.sw,
                    isEnabled: isEnabled,
                    labelText: Constants.trustName,
                    inputBoxController: _nameController,
                    emptyValidation: true,
                    emptyValidationText: Constants.trustNameValidationText,
                    validationLogic: (value) {
                      trustController.trustProfileModel.trustName = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                    width: 1.sw,
                    isEnabled: isEnabled,
                    labelText: Constants.careTaker,
                    inputBoxController: _careTakerNameController,
                    emptyValidation: true,
                    emptyValidationText: Constants.careTakerEmptyValidationText,
                    validationLogic: (value) {
                      trustController.trustProfileModel.careTakerName = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                    width: 1.sw,
                    isEnabled: false,
                    labelText: Constants.mobNumber,
                    inputBoxController: _mobNumController,
                    numberKeyboard: true,
                    numberLimit: 10,
                    emptyValidation: true,
                    emptyValidationText: Constants.phNumberEmptyValidationText,
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
                    trustController.trustProfileModel.email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Constants.category,
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
                CustomDropDown(
                  hintText: "Choose",
                  isEnabled: isEnabled,
                  labelText: Constants.category,
                  currentItem: category,
                  width: 350.w,
                  height: 45.h,
                  chosenValue: (value) {
                    category = value;
                    trustController.trustProfileModel.category = value;
                  },
                  dropDownItems: Constants.categoryDropDownList,
                  emptyValidation: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                  width: 1.sw,
                  isEnabled: isEnabled,
                  labelText: Constants.onlyFor,
                  inputBoxController: _onlyForController,
                  emptyValidation: true,
                  emptyValidationText: "This field can not be empty",
                  validationLogic: (value) {
                    trustController.trustProfileModel.onlyFor = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                    width: 1.sw,
                    isEnabled: isEnabled,
                    labelText: Constants.members,
                    inputBoxController: _memberCountController,
                    numberKeyboard: true,
                    numberLimit: 3,
                    emptyValidation: true,
                    emptyValidationText:
                        Constants.memberCountEmptyValidationText,
                    validationLogic: (value) {
                      trustController.trustProfileModel.membersCount = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Address/Payment",
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
                    labelText: Constants.address,
                    inputBoxController: _address1Controller,
                    emptyValidation: true,
                    emptyValidationText: Constants.address1EmptyValidationText,
                    validationLogic: (value) {
                      trustController.trustProfileModel.address = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDown(
                  hintText: "Choose",
                  isEnabled: isEnabled,
                  labelText: Constants.state,
                  currentItem: state,
                  width: 350.w,
                  height: 45.h,
                  chosenValue: (value) {
                    state = value;
                    trustController.trustProfileModel.stateName = value;
                  },
                  dropDownItems: Constants.stateList,
                  emptyValidation: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                  width: 1.sw,
                  isEnabled: isEnabled,
                  labelText: Constants.accountNumber,
                  inputBoxController: _accNUmController,
                  numberLimit: 15,
                  numberKeyboard: true,
                  emptyValidation: true,
                  emptyValidationText:
                      Constants.accountNumberEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.accountNumber = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFieldWidget(
                  width: 1.sw,
                  isEnabled: isEnabled,
                  labelText: Constants.uPIId,
                  inputBoxController: _upiIdController,
                  numberLimit: 15,
                  numberKeyboard: false,
                  emptyValidation: true,
                  emptyValidationText: Constants.uPIIdEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.uPIId = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDown(
                  hintText: "Choose",
                  isEnabled: isEnabled,
                  labelText: Constants.status,
                  currentItem: status,
                  width: 350.w,
                  height: 45.h,
                  chosenValue: (value) {
                    status = value;
                    trustController.trustProfileModel.status = value;
                  },
                  dropDownItems: Constants.profileStatusList,
                  emptyValidation: false,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  saveProfileData() async {
    String? bs64;
    if (imageFile != null) {
      String bs64 = await CommonFunctions.convertBase64String(imageFile.path);
      trustController.trustProfileModel.base64String = bs64;
    }

    if (_formKey.currentState!.validate()) {
      var trustProfileData = TrustProfileModel(
        base64String: trustController.trustProfileModel.base64String,
        address: trustController.trustProfileModel.address,
        stateName: trustController.trustProfileModel.stateName ?? state,
        status: trustController.trustProfileModel.status ?? status,
        onlyFor: trustController.trustProfileModel.onlyFor,
        trustName: trustController.trustProfileModel.trustName,
        category: trustController.trustProfileModel.category ?? category,
        mobNumber: trustController.trustProfileModel.mobNumber,
        careTakerName: trustController.trustProfileModel.careTakerName,
        membersCount: trustController.trustProfileModel.membersCount,
        uPIId: trustController.trustProfileModel.uPIId,
        email: trustController.trustProfileModel.email,
        accountNumber: trustController.trustProfileModel.accountNumber,
        confirmPassword: trustController.trustProfileModel.confirmPassword,
        password: trustController.trustProfileModel.password,
        averageStarRating: trustController.trustProfileModel.averageStarRating,
      );
      try {
        trustController.trustUpdateLoading = true;
        await commonController.putDataBaseByKey(
            trustProfileData,
            Constants.orphanDataBase,
            "${_mobNumController.text}${Constants.trustProfileDataKey}");

        trustController.trustProfileModel = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${trustController.trustProfileModel.mobNumber}${Constants.trustProfileDataKey}");

        trustController.trustUpdateLoading = false;
        await CommonFunctions.customToast(
            Constants.profileUpdateSuccessMessage);
        Get.back();
      } catch (err) {
        trustController.trustUpdateLoading = false;
        print(err.toString());
        CommonFunctions.customToast(Constants.errorMessage);
        return err;
      }
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
}
