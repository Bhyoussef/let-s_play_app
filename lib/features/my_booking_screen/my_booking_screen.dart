import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/features/my_booking_screen/cubit/history_booking_cubit.dart';
import 'package:lets_play/features/my_booking_screen/cubit/pending_booking_cubit.dart';
import 'package:lets_play/features/my_booking_screen/tabs/confirmed_booking.dart';
import 'package:lets_play/features/my_booking_screen/tabs/history_booking.dart';
import 'package:lets_play/features/my_booking_screen/tabs/pending_booking.dart';

import '../../common/constants/app_constants.dart';
import 'cubit/confirmed_booking_cubit.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyBookingScreenState();
  }
}

class MyBookingScreenState extends State<MyBookingScreen>
    with SingleTickerProviderStateMixin {

  late final _tabController = TabController(length: 3, vsync: this);
  late PendingBookingCubit pendingBookingCubit;
  late ConfirmedBookingCubit confirmedBookingCubit;
  late HistoryBookingCubit historyBookingCubit;

  @override
  void initState() {
    super.initState();
    pendingBookingCubit = PendingBookingCubit()..getBooking("pending");
    confirmedBookingCubit = ConfirmedBookingCubit()..getBooking("confirmed");
    historyBookingCubit = HistoryBookingCubit()..getBooking("completed");
  }

  @override
  void dispose() {
    pendingBookingCubit.close();
    confirmedBookingCubit.close();
    historyBookingCubit.close();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: AppColors.lightBlue,
        controller: _tabController,
        labelStyle: AppStyles.mont16Bold,
        unselectedLabelStyle: AppStyles.mont16Medium,
        labelColor: AppColors.purple,
        unselectedLabelColor: const Color(0xFF989898),
        onTap: (tab){
          switch (tab) {
            case 0:
              confirmedBookingCubit = ConfirmedBookingCubit()..getBooking("confirmed");
              break;
            case 1:
              pendingBookingCubit = PendingBookingCubit()..getBooking("pending");
              break;
            case 2:
              historyBookingCubit = HistoryBookingCubit()..getBooking("completed");
              break;
          }
        },
        tabs: const <Widget>[
          Tab(
            text: 'Confirmed',
          ),
          Tab(
            text: 'Pending',
          ),
          Tab(
            text: 'History',
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Bookings', style: AppStyles.mont27bold),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: ColoredBox(
                color: AppColors.lightBlue,
                child: _tabBar,
              ))),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PendingBookingCubit>.value(value: pendingBookingCubit),
          BlocProvider<ConfirmedBookingCubit>.value(value: confirmedBookingCubit),
          BlocProvider<HistoryBookingCubit>.value(value: historyBookingCubit),
        ],
        child:  TabBarView(
          controller: _tabController,
          children: const [
            ConfirmedBooking(),
            PendingBooking(),
            HistoryBooking(),
          ],
        ),
      ),

    );
  }
}
