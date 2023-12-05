import 'package:flutter/material.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/models/server/playground_model.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import '../../../routes/routes_list.dart';

class MatchesList extends StatelessWidget {
  final PlaygroundModel playground;
  const MatchesList({Key? key, required this.playground}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: playground.matches!.length,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final match = playground.matches![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteList.matchDetailsScreen,
                arguments: {'matchId': match.id});

            // Navigator.pushNamed(context, RouteList.teamsPickerScreen,
            //     arguments: {
            //       'positions' : match.position ,
            //       'players_count': match.playersPerTeam,
            //       'sport_name': playground.category?.nameEn,
            //       'params': <String, dynamic>{} ///pass empty params
            //     });
          },
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(playground.nameEn!.capitalizeEveryWord,
                //     style: AppStyles.mont17Bold),
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
                            Text('${playground.fullAddress}',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteList.summaryScreen);
                          },
                          child: Container(
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
                                  Text('QAR ${match.price}',
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
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
