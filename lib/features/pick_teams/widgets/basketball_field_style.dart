import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import '../models/player_model.dart';
import 'PlayerSpotWidget.dart';

class BasketBallFieldStyle extends StatelessWidget {
  final List<PlayerModel?> listFilledUsers;
  final Function(int) callback;
  const BasketBallFieldStyle(
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
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Basketball', style: AppStyles.inter17Bold)),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 86.w),
          child: Container(
            height: 485.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Assets.basketballField),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 68.h, left: 19.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 40.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PlayerSpotWidget(
                                  player: listFilledUsers[2],
                                  callback: () {
                                    callback(2);
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 68.h, right: 19.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PlayerSpotWidget(
                                  player: listFilledUsers[3],
                                  callback: () {
                                    callback(3);
                                  }),
                              PlayerSpotWidget(
                                  player: listFilledUsers[4],
                                  callback: () {
                                    callback(4);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 68.h, left: 19.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PlayerSpotWidget(
                                  player: listFilledUsers[5],
                                  callback: () {
                                    callback(5);
                                  }),
                              PlayerSpotWidget(
                                  player: listFilledUsers[6],
                                  callback: () {
                                    callback(6);
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PlayerSpotWidget(
                                  player: listFilledUsers[7],
                                  callback: () {
                                    callback(7);
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 68.h, right: 19.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PlayerSpotWidget(
                                  player: listFilledUsers[8],
                                  callback: () {
                                    callback(8);
                                  }),
                              PlayerSpotWidget(
                                  player: listFilledUsers[9],
                                  callback: () {
                                    callback(9);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
