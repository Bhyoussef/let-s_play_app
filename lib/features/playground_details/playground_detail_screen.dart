import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/components/icon_button/ButtonIcon.dart';
import 'package:lets_play/common/components/tag/tag_item.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/enums/public_private_type.dart';

import '../../common/components/FavIcon.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import '../../routes/routes_list.dart';
import '../../utils/playground.dart';
import 'cubit/playground_details_cubit.dart';
import 'widgets/matches_list.dart';

class PlaygroundDetailScreen extends StatelessWidget {
  const PlaygroundDetailScreen(
      {Key? key, required this.publicOrPrivate, required this.playgroundId})
      : super(key: key);
  final PublicPrivateType publicOrPrivate;
  final int playgroundId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaygroundDetailsCubit(context.read<UserCubit>())
        ..getPlaygroundDetails(playgroundId: playgroundId, playgroundType: publicOrPrivate),
      child: PlaygroundDetailsContent(playgroundType: publicOrPrivate),
    );
  }
}

class PlaygroundDetailsContent extends StatelessWidget {
  final PublicPrivateType playgroundType;

  final Completer<GoogleMapController> _controller = Completer();

  PlaygroundDetailsContent({Key? key, required this.playgroundType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaygroundDetailsCubit, PlaygroundDetailsState>(
      builder: (context, state) {
        if (state is PlaygroundDetailLoaded) {
          final playground = state.playground;
          final pgGeoPosition = LatLng(playground.latitude!, playground.longitude!);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: AppColors.purple.withOpacity(0.15),
              elevation: 2,
              centerTitle: false,
              leading: Container(
                margin: const EdgeInsets.only(left: 12),
                height: 43,
                width: 43,
                padding: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Center(
                      child: Image.asset(
                        Assets.backBtn,
                        height: 21,
                      ),
                    )),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  height: 43,
                  width: 43,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Center(
                        child: Image.asset(
                          Assets.exportIcon,
                          height: 14,
                        ),
                      )),
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            height: 240.h,
                            width: double.infinity,
                            child: MyNetworkImage(picPath: playground.image!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 23,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text("${playground.grassTypeEn}",
                                    style: AppStyles.inter12w500.withColor(Colors.black)),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(playground.nameEn!.capitalizeEveryWord,
                                      style: AppStyles.mont17Bold),
                                  FavWidget(
                                    onChange: (value) {
                                      context
                                          .read<PlaygroundDetailsCubit>()
                                          .setFavorite(playgroundId: playground.id, isFav: value);
                                    },
                                    selectedInitially: playground.isFav!,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  '${playground.fromUserDistance!.toInt()} KM - ${playground.fullAddress}',
                                  style: AppStyles.inter13w500),
                            ],
                          )),
                      const SizedBox(
                        height: 27,
                      ),
                      if (false)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          color: AppColors.purple,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.filterIcon,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Wednesday 31 Aug",
                                  style: AppStyles.mont13Medium.withColor(Colors.white))
                            ],
                          ),
                        ),
                      MatchesList(playground: playground),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 51, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonIcon(
                                title: "Direction",
                                icon: Assets.directionIcon,
                                callback: () {
                                  PlaygroundUtils.launchMap(
                                      playground.latitude!, playground.longitude!);
                                }),
                            ButtonIcon(
                                title: "Call",
                                icon: Assets.handsetIcon,
                                callback: () {
                                  PlaygroundUtils.callNumber(playground.phone);
                                })
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Club information", style: AppStyles.inter17Bold)),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in playground.tags!) TagItem(title: tag.nameEn ?? "")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Opening hours", style: AppStyles.inter17Bold),
                              Column(
                                children: playground.shifts!
                                    .map((shift) => Text("${shift.openAt} - ${shift.closeAt}",
                                        style: AppStyles.inter13w500))
                                    .toList(),
                              )
                            ],
                          )),
                      const Divider(),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
                          child: Text("Location", style: AppStyles.inter17Bold)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 230.h,
                        child: GoogleMap(
                          markers: <Marker>{
                            Marker(
                                markerId: const MarkerId('pgLocationId'), position: pgGeoPosition)
                          },
                          initialCameraPosition: CameraPosition(
                            target: pgGeoPosition,
                            zoom: 10,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 80.h,
                  width: 170.w,
                  height: 50.h,
                  child: TextButton(
                    style: AppStyles.createMatchStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteList.createMatch, arguments: {
                        'playground': playground,
                        'publicOrPrivate': playgroundType,
                      });
                    },
                    child: Text(
                      'Create Match',
                      style: AppStyles.inter14w500
                          .copyWith(fontWeight: FontWeight.bold, color: AppColors.yellow),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const LoadingScreen();
      },
    );
  }
}
