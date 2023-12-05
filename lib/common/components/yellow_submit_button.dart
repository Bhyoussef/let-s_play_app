import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lets_play/common/constants/app_constants.dart';

class YellowSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool disabled;
  final bool loading;
  final String buttonText;
  final double height;

  const YellowSubmitButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.disabled = false,
      this.loading = false,
      this.height = 75})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled || loading ? null : onPressed,
      child: loading
          ? const SpinKitThreeBounce(
              color: Colors.black,
              size: 24.0,
            )
          : Text(
              buttonText,
              style: (disabled
                      ? AppStyles.largeButtonTextStyleDisabled
                      : AppStyles.largeButtonTextStyle)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
      style: TextButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          backgroundColor:
              disabled ? AppColors.yellowDisabled : AppColors.yellow),
    );
  }
}
