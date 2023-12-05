import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/assets_images.dart';

AppBar buildStandardCloseAppBar(
    {required BuildContext context, required String title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.mont27bold.copyWith(fontSize: 27.sp)),
      ],
    ),
    actions: [
      IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Center(
            child: Image.asset(
              Assets.closeButtonPurple,
              height: 17.6,
            ),
          )),
    ],
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
  );
}
