import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/table_widget.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';

class EmergencyNeedScreen extends StatefulWidget {
  const EmergencyNeedScreen({super.key});

  @override
  State<EmergencyNeedScreen> createState() => _EmergencyNeedScreenState();
}

class _EmergencyNeedScreenState extends State<EmergencyNeedScreen> {
  CommonController commonController = Get.find<CommonController>();
  TrustController trustController = Get.find<TrustController>();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<TrustEmergencyNeedModel>? needList = [];

  @override
  void initState() {
    getEmergencyData();
    super.initState();
  }

  getEmergencyData() async {
    trustController.getEmergencyDataLoading = true;
    try {
      needList = [];
      if (commonController.checkKeyContainsInDataBase(
          Constants.orphanDataBase,
          "${trustController.trustProfileModel.mobNumber}-${Constants.trustEmergencyNeedDataKey}")) {
        trustController.emergencyList = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${trustController.trustProfileModel.mobNumber}-${Constants.trustEmergencyNeedDataKey}");
        needList = trustController.emergencyList.emergencyNeedList;
        print(trustController.emergencyList.emergencyNeedList!.length);
        print("model set true");
        trustController.getEmergencyDataLoading = false;
      } else {
        trustController.getEmergencyDataLoading = false;
      }
    } catch (err) {
      trustController.getEmergencyDataLoading = false;
      CommonFunctions.customToast(Constants.errorMessage);
      print(err);
      print("+++++++++++");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: const CustomAppBar(
            title: Constants.emergencyNeeds,
            actionWidget: SizedBox(),
          ),
          body: trustController.getEmergencyDataLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    children: [
                      needList!.isEmpty
                          ? const SizedBox()
                          : TableWidget(
                              list: needList ?? [],
                              deleteRecord: (index) {
                                setState(() {
                                  if (needList!.isNotEmpty) {
                                    needList!.removeAt(index);
                                  }
                                });
                              },
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          needList!.isEmpty
                              ? const Center(
                                  child: Text("Click hear to add your need"),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomLoginButtonWidget(
                                  elevatedButtonStyle: loginButtonStyle,
                                  height: 30.h,
                                  width: 100.w,
                                  isIconNeed: true,
                                  iconData: Icons.add_circle_outline,
                                  buttonFunction: () async {
                                    await showDialogForAddNeed();
                                  },
                                  buttonText: Constants.addMore),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomLoginButtonWidget(
                                  elevatedButtonStyle: loginButtonStyle,
                                  height: 30.h,
                                  width: 100.w,
                                  isIconNeed: true,
                                  iconData: Icons.save_outlined,
                                  buttonFunction: () async {
                                    await saveEmergencyNeeds();
                                  },
                                  buttonText: Constants.save)
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ));
    });
  }

  showDialogForAddNeed() async {
    return await Get.defaultDialog(
      title: "Add your needs",
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormFieldWidget(
              inputBoxController: _productController,
              labelText: "Product",
              validationLogic: (val) {},
              emptyValidation: true,
              emptyValidationText: "Product should not empty",
            ),
            TextFormFieldWidget(
              inputBoxController: _quantityController,
              labelText: "Quantity",
              validationLogic: (val) {},
              emptyValidation: true,
              emptyValidationText: "Quantity should not empty",
            ),
            TextFormFieldWidget(
              inputBoxController: _unitController,
              labelText: "Unit",
              validationLogic: (val) {},
              emptyValidation: true,
              emptyValidationText: "Unit should not empty",
            ),
          ],
        ),
      ),
      onConfirm: () async {
        await addNeeds();
      },
      onCancel: () {},
    );
  }

  addNeeds() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        needList!.add(TrustEmergencyNeedModel(
          productName: _productController.text,
          unit: _unitController.text,
          quantity: int.parse(_quantityController.text),
        ));
      });
      _unitController.clear();
      _quantityController.clear();
      _productController.clear();

      Get.back();
    }
  }

  saveEmergencyNeeds() async {
    print("_____________");
    print(needList!.length);
    if (needList!.isNotEmpty) {
      var needData = EmergencyList(emergencyNeedList: needList);
      try {
        await commonController.putDataBaseByKey(
            needData,
            Constants.orphanDataBase,
            "${trustController.trustProfileModel.mobNumber}-${Constants.trustEmergencyNeedDataKey}");
        Get.back();
        CommonFunctions.customToast(Constants.savedSuccessfully);
      } catch (err) {
        CommonFunctions.customToast(Constants.errorMessage);
        print(err);
      }
    }
  }
}
