import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import 'PlayerSpotWidget.dart';

class Football7PFieldStyle extends StatelessWidget {
  final List<PlayerModel?> listFilledUsers;
  final Function(int) callback;
  const Football7PFieldStyle(
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
              child: Text('Football', style: AppStyles.inter17Bold)),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Container(
            height: 512.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Assets.footballField),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PlayerSpotWidget(
                              player: listFilledUsers[0],
                              callback: () {
                                callback(0);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: PlayerSpotWidget(
                                player: listFilledUsers[1],
                                callback: () {
                                  callback(1);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 11.h, bottom: 14.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlayerSpotWidget(
                                player: listFilledUsers[2],
                                callback: () {
                                  callback(2);
                                },
                              ),
                              PlayerSpotWidget(
                                player: listFilledUsers[3],
                                callback: () {
                                  callback(3);
                                },
                              ),
                              PlayerSpotWidget(
                                player: listFilledUsers[4],
                                callback: () {
                                  callback(4);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PlayerSpotWidget(
                              player: listFilledUsers[5],
                              callback: () {
                                callback(5);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 25.w),
                              child: PlayerSpotWidget(
                                player: listFilledUsers[6],
                                callback: () {
                                  callback(6);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: PlayerSpotWidget(
                                player: listFilledUsers[7],
                                callback: () {
                                  callback(7);
                                },
                              ),
                            ),
                            PlayerSpotWidget(
                              player: listFilledUsers[8],
                              callback: () {
                                callback(8);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              PlayerSpotWidget(
                                player: listFilledUsers[9],
                                callback: () {
                                  callback(9);
                                },
                              ),
                              PlayerSpotWidget(
                                player: listFilledUsers[10],
                                callback: () {
                                  callback(10);
                                },
                              ),
                              PlayerSpotWidget(
                                player: listFilledUsers[11],
                                callback: () {
                                  callback(11);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 25.w),
                              child: PlayerSpotWidget(
                                player: listFilledUsers[12],
                                callback: () {
                                  callback(12);
                                },
                              ),
                            ),
                            PlayerSpotWidget(
                              player: listFilledUsers[13],
                              callback: () {
                                callback(13);
                              },
                            ),
                          ],
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
