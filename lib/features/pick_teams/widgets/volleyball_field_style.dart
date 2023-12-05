import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import '../models/player_model.dart';
import 'PlayerSpotWidget.dart';

class VolleyBallFieldStyle extends StatelessWidget {
  final List<PlayerModel?> listFilledUsers;
  final Function(int) callback;
  const VolleyBallFieldStyle(
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
              child: Text('Volleyball', style: AppStyles.inter17Bold)),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 75.w),
          child: Container(
            height: 485.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Assets.volleyballField),
              fit: BoxFit.fill,
            )),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                   PlayerSpotWidget(player: listFilledUsers[0]
                              ,callback: () {
                          callback(0);}),
                                   PlayerSpotWidget(player: listFilledUsers[1]
                              ,callback: () {
                          callback(1);}),
                                ],
                              ),
                            ),
                            SizedBox(height: 21.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 PlayerSpotWidget(player: listFilledUsers[2]
                              ,callback: () {
                          callback(2);}),
                                SizedBox(width: 30.w),
                                 PlayerSpotWidget(player: listFilledUsers[3]
                              ,callback: () {
                          callback(3);}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                               PlayerSpotWidget(player: listFilledUsers[4]
                              ,callback: () {
                          callback(4);}),
                              SizedBox(width: 30.w),
                               PlayerSpotWidget(player: listFilledUsers[5]
                              ,callback: () {
                          callback(5);}),
                            ],
                          ),
                          SizedBox(height: 21.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:  [
                                 PlayerSpotWidget(player: listFilledUsers[6]
                              ,callback: () {
                          callback(6);}),
                                 PlayerSpotWidget(player: listFilledUsers[7]
                              ,callback: () {
                          callback(7);}),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: const [
                          //     PlayerSpotWidget(callback: () { 
                        
                      //},),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       PlayerSpotWidget(player: listFilledUsers[8]
                              ,callback: () {
                          callback(8);}),
                      SizedBox(height: 60.h),
                       PlayerSpotWidget(player: listFilledUsers[9]
                              ,callback: () {
                          callback(9);}),
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
