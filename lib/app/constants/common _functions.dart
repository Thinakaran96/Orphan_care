import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:get/get.dart';

class CommonFunctions {
  static Future<void> navigateScreen(BuildContext context, String screenName,
      {dynamic arguments}) async {
    FocusScope.of(context).unfocus();

    await Get.toNamed(screenName, arguments: arguments);
  }

  static dynamic validateMobileNumber(String value) {
    if (value.length != 10 || !validator.isNumeric(value)) {
      return Constants.phNumberValidationText;
    } else {
      return null;
    }
  }

  static dynamic validateEmail(String value) {
    if (!value.isEmail) {
      return Constants.emailValidationText;
    } else {
      return null;
    }
  }

  static dynamic validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return Constants.password1ValidationText;
    } else {
      return null;
    }
  }

  static dynamic validateConfirmPassword(String value, String passwordValue) {
    if (passwordValue != value) {
      return Constants.password2ValidationText;
    } else {
      return null;
    }
  }

  static Future<bool?> customToast(String msg) async {
    return await Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: drawerBackgroundColor,
        textColor: Colors.white,
        fontSize: 16.0.sp);
  }

  static Future<String> convertBase64String(String filePath) async {
    File file = File(filePath);
    Uint8List fileBytes = await file.readAsBytes();
    String bs64str = base64.encode(fileBytes);
    return bs64str;
  }

  //dropdown convert function
  static List<DropdownMenuItem<String>> convertDropDownObject(
          List<String> dropDownItems) =>
      dropDownItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: tableColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: Center(child: Text(item))),
              ))
          .toList();

  static String formatPhoneNumber(String phoneNumber) {
    /*if (phoneNumber.length >= 5) {
      // Display the first three numbers, followed by 'XXXXX', and then the last two numbers
      return '${phoneNumber.substring(0, 2)}XXXXX${phoneNumber.substring(phoneNumber.length - 2)}';
    } else {
      // Handle cases where the phone number is too short
      return phoneNumber;
    }*/
    return phoneNumber;
  }

  static Widget commonHeaderWidget(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0).r,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
