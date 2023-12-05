import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/assets_images.dart';

AppBar appBarWithBackBtn(
    {required BuildContext context,
    required String title,
    Widget? trailingAction}) {
  return AppBar(
    title: Text(title, style: AppStyles.mont27bold),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    actions: [
      if (trailingAction != null) trailingAction,
    ],
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Image.asset(
        Assets.backBtn,
        height: 21,
      ),
    ),
  );
}
