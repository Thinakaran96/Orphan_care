import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';

Uint8List? decodedBytes;

class DonorNotificationDetailsScreen extends StatefulWidget {
  const DonorNotificationDetailsScreen({super.key});

  @override
  State<DonorNotificationDetailsScreen> createState() =>
      _DonorNotificationDetailsScreenState();
}

class _DonorNotificationDetailsScreenState
    extends State<DonorNotificationDetailsScreen> {
  TrustProfileModel trustData = Get.arguments["trustData"];
  bool isAccepted = Get.arguments["isAccepted"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: trustData.trustName, actionWidget: const SizedBox()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            trustImageWidget(),
            const SizedBox(height: 20),
            trustDataWidget(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Your Request has been",
                  style: backButtonTextStyle,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  isAccepted ? "Approved" : "Rejected",
                  style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: isAccepted ? Colors.green : errorTextColor),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "by the Trust",
                  style: backButtonTextStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  trustImageWidget() {
    if (trustData.base64String != null) {
      decodedBytes = base64.decode(trustData.base64String!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        decodedBytes != null
            ? Container(
                width: double.infinity,
                height: 0.2.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: MemoryImage(decodedBytes!))),
              )
            : SizedBox(),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 0.3.sw,
              child: Text(
                trustData.trustName!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            trustData.stateName == null
                ? const SizedBox()
                : Icon(
                    Icons.location_pin,
                    size: 15.sp,
                  ),
            SizedBox(
                width: trustData.stateName == null ? 0.01.sw : 0.3.sw,
                child: Text(
                  trustData.stateName ?? "",
                  overflow: TextOverflow.ellipsis,
                )),
            Text(trustData.status ?? "")
          ],
        )
      ],
    );
  }

  trustDataWidget() {
    return Container(
      height: 0.38.sh,
      width: 0.85.sw,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: buttonColor)),
      child: SizedBox(
        width: 0.5.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trust", style: editButtonTextStyle),
                Text("Category", style: editButtonTextStyle),
                Text("For", style: editButtonTextStyle),
                Text("Phone No", style: editButtonTextStyle),
                Text("Care Taker", style: editButtonTextStyle),
                Text("Doctor", style: editButtonTextStyle),
                Text("Vehicles", style: editButtonTextStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
                Text(":", style: commonTextStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.trustName!,
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.category ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.onlyFor ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(
                        CommonFunctions.formatPhoneNumber(
                            trustData.mobNumber!),
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.careTakerName ?? "-",
                        style: editButtonTextStyle,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.membersCount ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
                SizedBox(
                    width: 0.5.sw,
                    child: Text(trustData.uPIId ?? "-",
                        overflow: TextOverflow.ellipsis,
                        style: editButtonTextStyle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
