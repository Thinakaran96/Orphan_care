import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';

class CategoryComponent extends StatelessWidget {
  final String? categoryType;
  final Function? onTap;

  const CategoryComponent({super.key, this.categoryType, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Card(
        child: Container(
          height: 0.15.sh,
          width: 0.3.sw,

          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75))
              ],
              border: Border.all(color: buttonColor),
              borderRadius: BorderRadius.circular(15.r)),
          child: Center(
            child: SizedBox(
              width: 0.2.sw,
              child: Text(
                categoryType!,
                softWrap: true,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
