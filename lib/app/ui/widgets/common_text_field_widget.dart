import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef InputBoxCallback = dynamic Function(String value);
typedef OnChanged = dynamic Function(String value);

class CommonTextFieldWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final String? suffixText;
  final String? labelText;
  final InputBoxCallback? validationLogic;
  final OnChanged? onChanged;
  final Widget? suffixWidget;
  final bool? isSuffixWidget;
  final TextEditingController? inputBoxController;
  final bool isPassword;
  final bool numberKeyboard;
  final bool emptyValidation;
  final String? emptyValidationText;
  final int? numberLimit;
  final bool? autoValidation;
  final bool? isEnabled;

  const CommonTextFieldWidget(
      {super.key,
      this.height,
      this.width,
      this.suffixText = "",
      this.labelText = "",
      this.validationLogic,
      this.onChanged,
      this.isSuffixWidget = false,
      this.inputBoxController,
      this.numberLimit,
      this.isPassword = false,
      this.numberKeyboard = false,
      this.emptyValidation = false,
      this.emptyValidationText,
      this.autoValidation = true,
      this.isEnabled = true,
      this.suffixWidget});

  @override
  State<CommonTextFieldWidget> createState() => _TCommonTextFieldWidgetState();
}

class _TCommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.labelText!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 12.sp))),
        Container(
          constraints: BoxConstraints(minHeight: 50.h),
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            autovalidateMode: widget.autoValidation!
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            controller: widget.inputBoxController,
            inputFormatters: [
              widget.numberKeyboard
                  ? LengthLimitingTextInputFormatter(widget.numberLimit)
                  : LengthLimitingTextInputFormatter(50),
            ],
            keyboardType: widget.numberKeyboard
                ? TextInputType.phone
                : TextInputType.visiblePassword,
            style: inputBoxTextStyle.copyWith(
                color: textColor, overflow: TextOverflow.ellipsis),
            cursorColor: textColor,
            cursorWidth: 1.0.sp,
            obscureText: widget.isPassword ? isPasswordVisible : false,
            enabled: widget.isEnabled! ? true : false,
            validator: (value) {
              if (widget.emptyValidation) {
                if (value!.isEmpty) {
                  return widget.emptyValidationText;
                } else {
                  return widget.validationLogic!(value);
                }
              } else {
                if (value!.isNotEmpty) {
                  return widget.validationLogic!(value);
                }
              }
              return null;
            },
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(16.0).r,
                suffix: widget.isPassword
                    ? GestureDetector(
                        onTap: () => setState(
                            () => isPasswordVisible = !isPasswordVisible),
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility_rounded,
                          size: 18.0.sp,
                        ),
                      )
                    : widget.isSuffixWidget!
                        ? widget.suffixWidget
                        : const SizedBox(),
                disabledBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(15).r),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: errorTextColor),
                    borderRadius: BorderRadius.circular(15).r),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: errorTextColor),
                    borderRadius: BorderRadius.circular(15).r),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor),
                    borderRadius: BorderRadius.circular(15).r),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor),
                    borderRadius: BorderRadius.circular(15).r),
                errorStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: errorTextColor)),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
