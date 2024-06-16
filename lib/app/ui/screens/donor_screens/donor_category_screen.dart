import 'package:flutter/material.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/widgets/category_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:get/get.dart';

class DonorCategoryScreen extends StatefulWidget {
  const DonorCategoryScreen({super.key});

  @override
  State<DonorCategoryScreen> createState() => _DonorCategoryScreenState();
}

class _DonorCategoryScreenState extends State<DonorCategoryScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();

  Future getTrustByCategory(String dataBaseName) async {
    try {
      trustController.getTrustLoading = true;
      var dataBase = Hive.box(dataBaseName);
      trustController.localTrustList = <TrustProfileModel>[];
      for (var element in dataBase.keys) {
        if (element.contains(Constants.trustProfileDataKey)) {
          trustController.localTrustList
              .add(commonController.getDataBaseByKey(dataBaseName, element));
        }
      }
      trustController.getTrustLoading = false;
      return trustController.localTrustList;
    } catch (err) {
      print(err);
      trustController.getTrustLoading = false;
      CommonFunctions.customToast(Constants.errorMessage);
    }
  }

  // "Women’s Home",
  // "Child Care Home",
  // "Old Age Home",
  // "Handicap Home",
  // "Mentally disabled Home",
  // "Private Trust"

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(
          title: "Categories",
          actionWidget: SizedBox(),
        ),
        body: trustController.getTrustLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryComponent(
                        categoryType: "Old Age Home",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Old Age Home"}),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryComponent(
                        categoryType: "Child Care Home",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Child Care Home"}),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryComponent(
                        categoryType: "Mental Home",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Mentally disabled Home"}),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryComponent(
                        categoryType: "Handicap Home ",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Handicap Home"}),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryComponent(
                        categoryType: "Women’s Home",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Women’s Home"}),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryComponent(
                        categoryType: "Private Trust",
                        onTap: () => CommonFunctions.navigateScreen(
                            context, Routes.trustListByCategoryScreen,
                            arguments: {"category": "Private Trust"}),
                      )
                    ],
                  )
                ],
              ),
      );
    });
  }
}
