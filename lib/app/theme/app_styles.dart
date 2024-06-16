import 'package:flutter/material.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle appBarTextStyle = GoogleFonts.inter(
    fontSize: 18.sp, fontWeight: FontWeight.w700, color: textColor);

final TextStyle commonTextStyle = GoogleFonts.inter(
    fontSize: 20.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle donationHistoryNameTextStyle = GoogleFonts.inter(
    fontSize: 16.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle signInLabelTextStyle = GoogleFonts.inter(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle donationHistoryDateTextStyle = GoogleFonts.inter(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle labelTextStyle = GoogleFonts.inter(
    fontSize: 16.sp, fontWeight: FontWeight.w700, color: textColor);

final TextStyle buttonTextStyle = GoogleFonts.inter(
    fontSize: 18.sp, fontWeight: FontWeight.w800, color: textColor);

final TextStyle backButtonTextStyle = GoogleFonts.inter(
    fontSize: 15.sp, fontWeight: FontWeight.w500, color: textColor);

final TextStyle adoptionApplicationLabelTextStyle = GoogleFonts.inter(
    fontSize: 10.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle donationTextStyle = GoogleFonts.inter(
    fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.black);

final TextStyle inputBoxTextStyle = GoogleFonts.inter(
    fontSize: 16.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle editButtonTextStyle = GoogleFonts.inter(
    fontSize: 14.sp, fontWeight: FontWeight.w400, color: textColor);

final TextStyle textButtonStyle = GoogleFonts.inter(
    fontSize: 14.sp, fontWeight: FontWeight.w400, color: textButtonColor);

final TextStyle errorTextStyle = GoogleFonts.inter(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: errorTextColor);

// buttonStyle

final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: backgroundColor,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  side: const BorderSide(
    width: 2.0,
    color: buttonColor,
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
  ),
);

final ButtonStyle adoptFormButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: buttonColor,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  side: const BorderSide(
    width: 2.0,
    color: buttonColor,
  ),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4))),
);
