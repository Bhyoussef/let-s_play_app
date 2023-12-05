import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PurpleBoxWidget extends StatelessWidget {
  const PurpleBoxWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      height: 137,
      color: AppColors.purple,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (context) {
                final maxPlayersCount = match.playersPerTeam! * 2;
                final reservedPlayersCount =
                    match.position.where((element) => element != null).length;
                return Row(
                  children: [
                    Container(
                      child: LinearPercentIndicator(
                        width: 100,
                        padding: EdgeInsets.zero,
                        animation: false,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: reservedPlayersCount / maxPlayersCount,
                        barRadius: const Radius.circular(5),
                        progressColor: AppColors.yellow,
                        backgroundColor: AppColors.purple,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.yellow),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('$reservedPlayersCount / $maxPlayersCount',
                        style: AppStyles.inter15Bold.withColor(Colors.white)),
                  ],
                );
              }),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('Court booked',
                    style: AppStyles.inter12w400.withColor(AppColors.yellow)),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.yellow),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Image.asset(
                Assets.stadeIcon,
                height: 27,
              ),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(match.playground!.nameEn!,
                        style: AppStyles.mont17Bold.withColor(Colors.white)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()} - ${match.endDate!.toDefaultTimeHMFormatted()}',
                        style: AppStyles.inter13w500.withColor(Colors.white)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
