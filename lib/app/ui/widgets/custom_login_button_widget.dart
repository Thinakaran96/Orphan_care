import 'package:flutter/material.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoginButtonWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final ButtonStyle? elevatedButtonStyle;
  final bool? isLoading;
  final Function buttonFunction;
  final String buttonText;
  final bool? isIconNeed;
  final TextStyle? buttonTextStyle;
  final IconData? iconData;

  const CustomLoginButtonWidget(
      {super.key,
      required this.buttonFunction,
      required this.buttonText,
      this.height,
      this.width,
      this.iconData,
      this.elevatedButtonStyle,
      this.isLoading = false,
      this.isIconNeed = false,
      this.buttonTextStyle});

  @override
  State<CustomLoginButtonWidget> createState() =>
      _CustomLoginButtonWidgetState();
}

class _CustomLoginButtonWidgetState extends State<CustomLoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading! ? () {} : () => widget.buttonFunction(),
      style: widget.elevatedButtonStyle,
      child: Container(
        height: widget.height!,
        width: widget.width,
        constraints: const BoxConstraints(minHeight: 20.0, minWidth: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isIconNeed! ? Icon(widget.iconData!) : const SizedBox(),
            widget.isLoading!
                ? const CircularProgressIndicator()
                : Text(
                    widget.buttonText,
                    textAlign: TextAlign.center,
                    style: widget.buttonTextStyle,
                  ),
          ],
        ),
      ),
    );
  }
}
