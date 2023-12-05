import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/my_booking_screen/cubit/pending_booking_cubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common/constants/app_constants.dart';
import '../../../models/mainStatus.dart';
import '../../../routes/routes_list.dart';
import '../../../services/date_time_service.dart';
import '../../../services/kiwi_container.dart';
import '../components/map_image.dart';

class PendingBooking extends StatelessWidget {
  const PendingBooking({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: Implement build
    return BlocBuilder<PendingBookingCubit, PendingBookingState>(
        builder: (context, state) {
          if (state.mainStatus == MainStatus.loaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: state.pendingMatches?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final booking = state.pendingMatches?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteList.matchDetailsScreen, arguments: {
                      "matchId" : booking?.id
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(20),
                    height: 357,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text("${container.resolve<DateTimeService>().formatDate("${booking?.startDate}", "EEEE dd MMM HH:mm")} - ${container.resolve<DateTimeService>().formatDate("${booking?.endDate}", "HH:mm")}",
                                    style: AppStyles.sf17Bold),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text("${booking?.enName}",
                                    style: AppStyles.sf14W500),
                                const SizedBox(height: 4,),
                                Text("${booking?.category.enName}",
                                    style: AppStyles.sf14W500),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              height: 52,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                              child:  Center(
                                  child: Text(
                                      "${booking?.duration}\nmin", style: AppStyles.sf15Bold)),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                LinearPercentIndicator(
                                  width: 100,
                                  padding: EdgeInsets.zero,
                                  animation: false,
                                  lineHeight: 20.0,
                                  animationDuration: 2000,
                                  percent: booking!.count! / booking.maxPlayer! ,
                                  barRadius: const Radius.circular(5),
                                  progressColor: AppColors.yellow,
                                  backgroundColor: AppColors.purple,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('${booking.count} / ${booking.maxPlayer} payed',
                                    style: AppStyles.inter15Bold
                                        .withColor(AppColors.purple)),
                              ],
                            ),
                            Column(
                              children:  [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                Text(
                                  '${booking.expirationTime}',
                                  style: AppStyles.sf15Bold,
                                )
                              ],
                            )

                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MapImage(latitude:booking.latitude ?? 0.0, longitude: booking.longitude ?? 0.0)
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const LoadingScreen();
        });
  }

}
