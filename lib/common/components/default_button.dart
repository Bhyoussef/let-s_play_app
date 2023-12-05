import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final String? text;
  final Color btnColor;
  final Color textColor;
  final TextStyle? textStyle;
  const DefaultButton({
    required this.onPressed,
    this.width = 125,
    this.height = 38,
    required this.text,
    required this.btnColor,
    required this.textColor,
    this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            minimumSize: Size.fromHeight(height),
            backgroundColor: btnColor),
        child: Center(
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style:
                textStyle ?? AppStyles.inter15Bold.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
