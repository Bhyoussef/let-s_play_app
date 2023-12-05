import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/app_constants.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: 55.h,
      child: Center(
          child: CircularProgressIndicator(
        color: AppColors.purple,
      )),
    );
  }
}
