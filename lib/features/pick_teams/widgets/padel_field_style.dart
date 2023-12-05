import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import '../models/player_model.dart';
import 'PlayerSpotWidget.dart';

class PadelFieldStyle extends StatelessWidget {
  final List<PlayerModel?> listFilledUsers;
  final Function(int) callback;
  const PadelFieldStyle(
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
              child: Text('Padel', style: AppStyles.inter17Bold)),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Container(
            height: 440.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Assets.padelVerticalField),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PlayerSpotWidget(
                        player: listFilledUsers[0],
                        callback: () {
                          callback(0);
                        }),
                    PlayerSpotWidget(
                        player: listFilledUsers[1],
                        callback: () {
                          callback(1);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PlayerSpotWidget(
                        player: listFilledUsers[2],
                        callback: () {
                          callback(2);
                        }),
                    PlayerSpotWidget(
                        player: listFilledUsers[3],
                        callback: () {
                          callback(3);
                        }),
                  ],
                ),
              ],
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
