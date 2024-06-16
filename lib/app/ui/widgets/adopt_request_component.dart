import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class AdoptRequestComponent extends StatelessWidget {
  final String adopterName;
  final String whoseAdopt;
  final Function onTap;

  const AdoptRequestComponent(
      {super.key,
      required this.adopterName,
      required this.whoseAdopt,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 0.13.sh,
        width: 0.9.sw,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            border: Border.all(color: buttonColor),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 0.7.sw,
                child: Text(
                  "${adopterName.capitalizeFirst} request",
                  style: donationHistoryNameTextStyle,
                  softWrap: true,
                )),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
