import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/ui/widgets/common_trust_component.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';

class OtherTrustScreen extends StatefulWidget {
  const OtherTrustScreen({super.key});

  @override
  State<OtherTrustScreen> createState() => _OtherTrustScreenState();
}

class _OtherTrustScreenState extends State<OtherTrustScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  List<TrustProfileModel> ownTrustValueList = [];

  @override
  void initState() {
    getLocalTrustDetails(Constants.orphanDataBase);
    super.initState();
  }

  Future getLocalTrustDetails(String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    trustController.localTrustList = <TrustProfileModel>[];
    try {
      for (var element in dataBase.keys) {
        if (element.contains(Constants.trustProfileDataKey)) {
          trustController.localTrustList
              .add(commonController.getDataBaseByKey(dataBaseName, element));
          for (var element in trustController.localTrustList) {
            if (element.mobNumber ==
                trustController.trustProfileModel.mobNumber) {
              ownTrustValueList.add(element);
            }
          }
        }
      }
      trustController.localTrustList
          .removeWhere((element) => ownTrustValueList.contains(element));

      return trustController.localTrustList;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Constants.trusts,
        actionWidget: SizedBox(),
      ),
      body: trustController.localTrustList.isEmpty
          ? Center(
              child: Text(
                "No trust available",
                style: TextStyle(fontSize: 20.sp),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(10.r),
              itemCount: trustController.localTrustList.length,
              separatorBuilder: (context, integer) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemBuilder: (context, index) {
                return CommonTrustComponent(
                  isAssetImage:
                      trustController.localTrustList[index].base64String ==
                          null,
                  bs64String:
                      trustController.localTrustList[index].base64String ?? "",
                  trustName: trustController.localTrustList[index].trustName!,
                  category:
                      trustController.localTrustList[index].category ?? "-",
                  forWhom: trustController.localTrustList[index].onlyFor ?? "-",
                  phNumber: trustController.localTrustList[index].mobNumber!,
                  ratingValue:
                      "${trustController.localTrustList[index].averageStarRating ?? 0.0}",
                  onTap: () => CommonFunctions.navigateScreen(
                      context, Routes.trustDetailsScreen, arguments: {
                    "trustData": trustController.localTrustList[index]
                  }),
                );
              },
            ),
    );
  }
}
