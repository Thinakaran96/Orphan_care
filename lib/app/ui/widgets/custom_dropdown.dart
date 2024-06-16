import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

typedef CustomDropDownCallback = void Function(String value);

class CustomDropDown extends StatefulWidget {
  final String? labelText;
  final double width;
  final double height;
  final String? currentItem;
  final List<String>? dropDownItems;
  final CustomDropDownCallback? chosenValue;
  final String? requiredValidationText;
  final String? hintText;
  final bool emptyValidation;
  final String? emptyValidationText;
  final bool? isEnabled;

  const CustomDropDown(
      {super.key,
      this.requiredValidationText,
      this.labelText,
      required this.width,
      required this.height,
      this.currentItem,
      this.chosenValue,
      this.hintText,
      this.dropDownItems,
      required this.emptyValidation,
      this.emptyValidationText,
      this.isEnabled});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectValue;
  List<String>? dropDownItemList;

  @override
  void initState() {
    var list = <String>{};
    dropDownItemList =
        widget.dropDownItems!.where((item) => list.add(item)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      try {
        if (dropDownItemList!.isNotEmpty) {
          selectValue = widget.currentItem != null
              ? dropDownItemList!.firstWhere((element) =>
                  element.toLowerCase() == widget.currentItem!.toLowerCase())
              : selectValue;
        } else {
          selectValue = null;
        }
      } catch (e) {}
    });
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.labelText!,
        style: signInLabelTextStyle,
      ),
      Container(
          constraints: const BoxConstraints(minHeight: 40, maxHeight: 60),
          height: widget.height,
          width: widget.width,
          child: Center(
              child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              dropdownColor: drawerBackgroundColor,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isExpanded: true,
              hint: Text(widget.hintText!),
              decoration: InputDecoration(
                //  constraints: BoxConstraints(minHeight: widget.height!),
                //errorBorder: InputBorder.none,
                filled: true,
                fillColor: buttonTextColor,
                isDense: true,
                disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(15).r),
                contentPadding: const EdgeInsets.all(16.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: textColor),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: textColor),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                /* focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(4.0),
                ),*/
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              //focusColor: Theme.of(context).colorScheme.primary,
              value: selectValue,
              style: inputBoxTextStyle.copyWith(
                  color: textColor, overflow: TextOverflow.ellipsis),

              icon: const Icon(Icons.arrow_downward_sharp),
              iconSize: 20.0,
              validator: (value) => widget.emptyValidation
                  ? value == null
                      ? "${widget.requiredValidationText} is required"
                      : null
                  : null,
              items: CommonFunctions.convertDropDownObject(dropDownItemList!),
              onChanged: widget.isEnabled!
                  ? (value) {
                      setState(() {
                        selectValue = value as String;
                      });
                      if (widget.chosenValue != null) {
                        widget.chosenValue!(selectValue!);
                      }
                    }
                  : null,
            ),
          )))
    ]);
  }
}
