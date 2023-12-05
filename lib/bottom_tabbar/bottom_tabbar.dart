import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/features/chat/chat_screen.dart';
import 'package:lets_play/features/my_booking_screen/my_booking_screen.dart';

import '../features/home_screen/home_screen.dart';
import '../features/profile/profile_screen.dart';

class HomeBottomTabbar extends StatefulWidget {
  final int index;
  const HomeBottomTabbar({super.key, this.index = 0});

  @override
  State<StatefulWidget> createState() {
    return HomeBottomTabbarState();
  }
}

class HomeBottomTabbarState extends State<HomeBottomTabbar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const MyBookingScreen(),
    const ChatsScreen(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            key: _scaffoldKey,
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                ...screens,
              ],
            ),
            bottomNavigationBar: Container(
                color: Colors.white,
                height: 95,
                child: ClipRRect(
                    child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: AppColors.purple,
                  unselectedLabelStyle: AppStyles.tabbarTextStyle,
                  selectedLabelStyle: AppStyles.tabbarSelectedTextStyle,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: _selectedIndex == 0
                            ? Image.asset(Assets.homeIconSelected,
                                height: 25, color: AppColors.purple)
                            : Image.asset(Assets.homeIcon, height: 25, color: Colors.black),
                        label: "Home"),
                    BottomNavigationBarItem(
                        icon: _selectedIndex == 1
                            ? Image.asset(Assets.bookingIconSelected,
                                height: 25, color: AppColors.purple)
                            : Image.asset(Assets.bookingIcon, height: 25, color: Colors.black),
                        label: "My Bookings"),
                    BottomNavigationBarItem(
                        icon: _selectedIndex == 2
                            ? Image.asset(Assets.chatIconSelected,
                                height: 25, color: AppColors.purple)
                            : Image.asset(Assets.chatIcon, height: 25, color: Colors.black),
                        label: "Let's Chat"),
                    BottomNavigationBarItem(
                        icon: _selectedIndex == 3
                            ? Image.asset(Assets.profileIconSelected,
                                height: 25, color: AppColors.purple)
                            : Image.asset(Assets.profileIcon, height: 25, color: Colors.black),
                        label: "Profile"),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                )))));
  }
}
