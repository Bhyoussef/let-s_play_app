import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/routes/routes_list.dart';

class PlayedMatchesList extends StatelessWidget {
  const PlayedMatchesList({Key? key, required this.matches}) : super(key: key);
  final List<MatchModel> matches;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
            itemCount: matches.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final match = matches[index];
              // return const SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteList.matchDetailsScreen,
                      arguments: {'matchId': match.id});
                },
                child: Container(
                  margin: index == 0
                      ? const EdgeInsets.only(right: 12, left: 20)
                      : const EdgeInsets.only(right: 12),
                  width: 290,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: AppColors.purple, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()}',
                                  style: AppStyles.inter13Bold.withColor(Colors.black)),
                              Text(match.playground!.nameEn!.capitalize,
                                  style: AppStyles.inter13w500.withColor(AppColors.purple)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 43,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'QAR ${match.playground!.price} / ',
                              style: AppStyles.inter18Bold.withColor(Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " ${match.duration} min ",
                                    style: AppStyles.inter13w500.withColor(Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget paddelFilledField(String letter, String name) {
    return Column(
      children: [
        Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), color: AppColors.purple),
            child: Center(
              child: Text(letter, style: AppStyles.inter15w500.withColor(Colors.white)),
            )),
        const SizedBox(
          height: 4,
        ),
        Text(name, style: AppStyles.mont12SemiBold.withColor(Colors.black))
      ],
    );
  }
}
