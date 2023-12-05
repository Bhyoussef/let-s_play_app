import 'package:flutter/material.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/routes/routes_list.dart';

class PublicMatchCardWidget extends StatelessWidget {
  const PublicMatchCardWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteList.matchDetailsScreen,
            arguments: {'matchId': match.id});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColors.purple, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xFFD9EAFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipOval(
                                child: MyNetworkImage(
                                    picPath: match.sportCat!.icon!),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(match.sportCat!.nameEn!.capitalize,
                              style: AppStyles.inter17w500
                                  .withColor(Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFD7DBDE)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()}',
                      style: AppStyles.inter13Bold.withColor(Colors.black)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      '${match.fromUserDistance!.toInt()} KM - ${match.pgNameEn!.capitalize}',
                      style: AppStyles.inter13w500.withColor(AppColors.purple)),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 43,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'QAR ${match.price} / ',
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
  }
}
