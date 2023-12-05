import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

import '../../../common/constants/app_constants.dart';

class PlayerSpotWidget extends StatelessWidget {
  final PlayerModel? player;
  final Function() callback;

  const PlayerSpotWidget({
    Key? key,
    required this.callback,
    this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0xffDCDFE6),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xffD7DBDE),
                    )),
                child: ClipOval(
                  child: Center(
                    child: player?.avatar != null
                        ? MyNetworkImage(
                            picPath: player!.avatar,
                            width: 50.h,
                          )
                        : player?.firstName != null
                            ? Icon(
                                Icons.account_circle,
                                size: 40.h,
                                color: AppColors.greyText,
                              )
                            : Icon(
                                Icons.add,
                                size: 21.h,
                              ),
                  ),
                ),
              ),
              if (player != null)
                Positioned(
                  top: 0,
                  right: 2.w,
                  child: ClipOval(
                    child: Container(
                      color: player!.isConfirmed == true ? Colors.green : AppColors.mainRed,
                      height: 12.h,
                      width: 12.h,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 55.w,
            child: Text(
              player?.firstName.capitalize ?? "Available",
              style: AppStyles.mont10Medium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class SelectedPlayer {
  final int index;
  final String? userImageUrl;
  final String? userName;
  SelectedPlayer(this.userName, this.userImageUrl, this.index);
}
