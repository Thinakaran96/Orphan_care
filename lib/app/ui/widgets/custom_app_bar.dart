import 'package:flutter/material.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionWidget;

  const CustomAppBar({Key? key, this.title, this.actionWidget})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
 // default is 56.0
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title!,
        style: appBarTextStyle,
      ),
      actions: [
        widget.actionWidget!,
        const SizedBox(
          width: 20,
        )
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              buttonColor,
              appBarBottomColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
