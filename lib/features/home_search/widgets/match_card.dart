import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/routes/routes_list.dart';

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({super.key, required this.match});
  final MatchModel match;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteList.matchDetailsScreen,
            arguments: {'matchId': match.id});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(match.playground!.nameEn!.capitalizeEveryWord,
                    style: AppStyles.mont17Bold),
                const SizedBox(
                  height: 4,
                ),
                Text(
                    '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()} - ${match.endDate!.toDefaultTimeHMFormatted()}',
                    style: AppStyles.inter14w500.withColor(AppColors.purple)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(Assets.playersIcon,
                                height: 30, width: 30),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                '${match.playersPerTeam} vs ${match.playersPerTeam}',
                                style: AppStyles.inter12w500),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset(Assets.flagIcon, height: 30, width: 30),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${match.playground!.fullAddress}',
                                style: AppStyles.inter12w500),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 68,
                          width: 1,
                          color: AppColors.backGrey,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 68,
                          width: 113,
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('QAR ${match.playground!.price}',
                                    style: AppStyles.inter17Bold
                                        .withColor(Colors.black)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text('${match.duration} min',
                                    style: AppStyles.inter13w500
                                        .withColor(Colors.black))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
