import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/features/my_booking_screen/cubit/confirmed_booking_cubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common/constants/app_constants.dart';
import '../../../models/mainStatus.dart';
import '../../../routes/routes_list.dart';
import '../../../services/date_time_service.dart';
import '../../../services/kiwi_container.dart';
import '../../Loading/loading_screen.dart';
import '../components/map_image.dart';

class ConfirmedBooking extends StatelessWidget {
  const ConfirmedBooking({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: Implement build
    return BlocBuilder<ConfirmedBookingCubit, ConfirmedBookingState>(
        builder: (context, state) {
      if (state.mainStatus == MainStatus.loaded) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 32),
          itemCount: state.confirmedMatches?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final booking = state.confirmedMatches?[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteList.matchDetailsScreen, arguments: {
                  "matchId" : booking?.id
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(20),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
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
                            Text("${booking?.enName}", style: AppStyles.sf14W500),
                            const SizedBox(height: 4,),
                            Text("${booking?.category.enName}", style: AppStyles.sf14W500),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 52,
                          width: 65,
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child:  Center(
                              child: Text("${booking?.duration}\nmin", style: AppStyles.sf15Bold)),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 24,
                    ),
                    MapImage(latitude:booking?.latitude ?? 0.0, longitude: booking?.longitude ?? 0.0)
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
