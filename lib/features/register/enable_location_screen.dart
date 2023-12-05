import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/routes_list.dart';

class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({Key? key}) : super(key: key);

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Enable Location",
                style: TextStyle(
                    color: AppColors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Used to show venues near you',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/map.png",
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final userPosition = await _determinePosition();

                    if (userPosition != null) {
                      final userCubit = context.read<UserCubit>();
                      userCubit.setProfile(userPosition: userPosition);
                      Navigator.pushReplacementNamed(
                          context, RouteList.homeBottomTabbar);
                    }
                  },
                  child: const Text(
                    'Allow',
                    style: AppStyles.largeButtonTextStyle,
                  ),
                  style: AppStyles.elevatedButtonDefaultStyle),
              const SizedBox(
                height: 20,
              ),
              // Center(
              //   child: TextButton(
              //       style: TextButton.styleFrom(padding: EdgeInsets.zero),
              //       onPressed: () {
              //         Navigator.pushNamed(context, RouteList.homeBottomTabbar);
              //       },
              //       child: Text(
              //         "Not now",
              //         style: TextStyle(
              //             fontSize: 18,
              //             color: AppColors.purple,
              //             fontWeight: FontWeight.w600),
              //       )),
              // ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<Position?> _determinePosition() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      EasyLoading.show(dismissOnTap: true);
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        openAppSettings();
        return null;
      }
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        EasyLoading.showError('Location has to be enabled to proceed!');
        return null;
      }
      // }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class Sport {
  final String name;
  final String assetName;

  Sport(this.name, this.assetName);

  static final mockedSportsList = [
    Sport("Padel", "padel.png"),
    Sport("Football", "football.png"),
    Sport("Basketball", "basketball.png"),
    Sport("Tennis", "tennis.png"),
    Sport("Badminton", "badminton.png"),
    Sport("Padbol", "padbol.png"),
    Sport("Volleyball", "volleyball.png"),
    Sport("Squash", "squash.png"),
  ];
}
