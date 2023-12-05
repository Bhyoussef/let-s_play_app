import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/my_booking_screen/cubit/history_booking_cubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../models/mainStatus.dart';
import '../../../routes/routes_list.dart';
import '../../../services/date_time_service.dart';
import '../../../services/kiwi_container.dart';
import '../../Loading/loading_screen.dart';

class HistoryBooking extends StatelessWidget {
  const HistoryBooking({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: Implement build
    return BlocBuilder<HistoryBookingCubit, HistoryBookingState>(
        builder: (context, state) {
      if (state.mainStatus == MainStatus.loaded) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 32),
          itemCount: state.completedMatches?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final booking = state.completedMatches?[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteList.matchDetailsScreen, arguments: {
                  "matchId" : booking?.id
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(20),
                height: 129,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("${container.resolve<DateTimeService>().formatDate("${booking?.startDate}", "EEEE dd MMM HH:mm")} - ${container.resolve<DateTimeService>().formatDate("${booking?.endDate}", "HH:mm")}",
                            style: AppStyles.sf17Bold),
                        Text("${booking?.duration}\nmin", style: AppStyles.sf15Bold),
                      ],
                    ),
                    Text("${booking?.enName}",
                        style: AppStyles.sf14W500),
                    const SizedBox(height: 4,),
                    Text("${booking?.category.enName}",
                        style: AppStyles.sf14W500),
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
