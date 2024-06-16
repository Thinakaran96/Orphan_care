import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';

class CommonTrustComponent extends StatelessWidget {
  final bool? isAssetImage;
  final String? assetImagePath;
  final String bs64String;
  final String trustName;
  final String category;
  final String forWhom;
  final String phNumber;
  final Function onTap;
  final bool isFeedbackShow;
  final Function? feedBackFunction;
  final String? ratingValue;

  const CommonTrustComponent({
    super.key,
    this.isAssetImage = false,
    this.assetImagePath,
    required this.bs64String,
    required this.trustName,
    required this.category,
    required this.forWhom,
    required this.phNumber,
    required this.onTap,
    this.isFeedbackShow = false,
    this.feedBackFunction,
    this.ratingValue,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? decodedBytes;
    if (!isAssetImage!) {
      decodedBytes = base64.decode(bs64String);
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 100.h,
        width: double.infinity.w,
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: buttonColor)),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: isAssetImage!
                        ? Image.asset(IconImages.trustProfile)
                        : Image.memory(decodedBytes!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 180.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Constants.name,
                              style: donationHistoryDateTextStyle),
                          Text(Constants.category,
                              style: donationHistoryDateTextStyle),
                          Text(Constants.onlyFor,
                              style: donationHistoryDateTextStyle),
                          Text(Constants.mobNumber,
                              style: donationHistoryDateTextStyle),
                          Text(Constants.review,
                              style: donationHistoryDateTextStyle),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("-", style: donationHistoryDateTextStyle),
                          Text("-", style: donationHistoryDateTextStyle),
                          Text("-", style: donationHistoryDateTextStyle),
                          Text("-", style: donationHistoryDateTextStyle),
                          Text("-", style: donationHistoryDateTextStyle),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 100.w,
                              child: Text(trustName,
                                  style: donationHistoryDateTextStyle,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(
                              width: 100.w,
                              child: Text(category,
                                  overflow: TextOverflow.ellipsis,
                                  style: donationHistoryDateTextStyle)),
                          SizedBox(
                              width: 100.w,
                              child: Text(forWhom,
                                  overflow: TextOverflow.ellipsis,
                                  style: donationHistoryDateTextStyle)),
                          SizedBox(
                              width: 100.w,
                              child: Text(
                                  CommonFunctions.formatPhoneNumber(phNumber),
                                  overflow: TextOverflow.ellipsis,
                                  style: donationHistoryDateTextStyle)),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 20,
                              ),
                              Text(ratingValue!,
                                  overflow: TextOverflow.ellipsis,
                                  style: donationHistoryDateTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            isFeedbackShow
                ? Positioned(
                    left: 0.8.sw,
                    bottom: 0.085.sh,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () => feedBackFunction!(),
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 25,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
