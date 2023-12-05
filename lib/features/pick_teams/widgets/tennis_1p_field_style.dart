import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import '../models/player_model.dart';
import 'PlayerSpotWidget.dart';

class Tennis1PFieldStyle extends StatelessWidget {
  final List<PlayerModel?> listFilledUsers;
  final Function(int) callback;
  const Tennis1PFieldStyle(
      {Key? key, required this.listFilledUsers, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 38.h),
          child: const Text('Team A', style: AppStyles.inter17Bold),
        ),
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Tennis', style: AppStyles.inter17Bold)),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 65.w),
          child: Container(
            height: 480.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Assets.tennisField),
              fit: BoxFit.fill,
            )),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayerSpotWidget(
                          player: listFilledUsers[0],
                          callback: () {
                            callback(0);
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayerSpotWidget(
                          player: listFilledUsers[1],
                          callback: () {
                            callback(1);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 40.h),
          child: const Text('Team B', style: AppStyles.inter17Bold),
        ),
      ],
    );
  }
}
