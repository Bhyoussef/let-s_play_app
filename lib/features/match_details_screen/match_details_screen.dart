import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/match_details_screen/bloc/match_player_search_bloc.dart';
import 'package:lets_play/features/match_details_screen/components/match_player_picker_bottom_sheet.dart';
import 'package:lets_play/features/match_details_screen/cubit/match_details_cubit.dart';
import 'package:lets_play/features/match_details_screen/cubit/match_player_picker_cubit.dart';
import 'package:lets_play/features/match_details_screen/widgets/PurpleBoxWidget.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/routes/routes_list.dart';

import '../../common/components/icon_button/ButtonIcon.dart';
import '../../common/components/tag/tag_item.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import '../../utils/matchFields.dart';
import '../../utils/playground.dart';
import '../Loading/loading_screen.dart';
import '../pick_teams/models/player_model.dart';

class MatchDetailsScreen extends StatefulWidget {
  const MatchDetailsScreen({Key? key, required this.matchId}) : super(key: key);
  final int matchId;

  @override
  State<StatefulWidget> createState() {
    return MatchDetailsScreenState();
  }
}

class MatchDetailsScreenState extends State<MatchDetailsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.73312471105945, 7.426010608772704),
    zoom: 16,
  );

  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _markers.add(const Marker(
        markerId: MarkerId('1234'),
        position: LatLng(43.73312471105945, 7.426010608772704),
        infoWindow: InfoWindow(title: '')));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MatchPlayerPickerCubit(),
        ),
        BlocProvider(
          create: (context) => MatchDetailsCubit(context.read<MatchPlayerPickerCubit>())
            ..getMatchDetails(matchId: widget.matchId),
        ),
        BlocProvider(
          create: (context) => MatchPlayerSearchBloc(context.read<MatchPlayerPickerCubit>()),
        ),
      ],
      child: MatchDetailsContent(
          markers: _markers, kGooglePlex: _kGooglePlex, controller: _controller),
    );
  }
}

class MatchDetailsContent extends StatefulWidget {
  const MatchDetailsContent({
    Key? key,
    required List<Marker> markers,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
  })  : _markers = markers,
        _kGooglePlex = kGooglePlex,
        _controller = controller,
        super(key: key);

  final List<Marker> _markers;
  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;

  @override
  State<MatchDetailsContent> createState() => _MatchDetailsContentState();
}

class _MatchDetailsContentState extends State<MatchDetailsContent> {
  List<PlayerModel?> allPlayerField = [];
  List<Map<String, dynamic>> teamAPlayer = [];
  List<Map<String, dynamic>> teamBPlayer = [];
  int? joinerSelectedPosition;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final matchDetailsCubit = context.read<MatchDetailsCubit>();
    return BlocConsumer<MatchDetailsCubit, MatchDetailsState>(
      listenWhen: (previous, current) => previous.cubitOperation != current.cubitOperation,
      listener: (context, state) async {
        if (state.cubitOperation!.action == CubitAction.join) {
          if (state.cubitOperation!.status == CubitStatus.success) {
            EasyLoading.dismiss();
            Navigator.pushNamed(context, RouteList.matchPaymentScreen, arguments: {
              "matchId": state.match!.id!,
              "amount": state.cubitOperation!.arguments!['toBePaid'],
            });
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Joining request failed');
          }
        } else if (state.cubitOperation!.action == CubitAction.invite) {
          if (state.cubitOperation!.status == CubitStatus.success) {
            allPlayerField[state.cubitOperation!.arguments!['position']] =
                state.cubitOperation!.arguments!['player'];
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Invitation successfully sent');
            setState(() {});
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Invitation sending failed');
          }
        } else if (state.cubitOperation!.action == CubitAction.rejectInvite) {
          if (state.cubitOperation!.status == CubitStatus.success) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Invitation successfully rejected');
            await Future.delayed(const Duration(seconds: 3));
            Navigator.pop(context);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Invitation cancelling failed');
          }
        } else if (state.cubitOperation!.action == CubitAction.cancelJoin) {
          if (state.cubitOperation!.status == CubitStatus.success) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Participation cancelled');
            await Future.delayed(const Duration(seconds: 3));
            Navigator.pop(context);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Could not cancel the participation');
          }
        }
      },
      buildWhen: (previous, current) => previous.mainStatus != current.mainStatus,
      builder: (context, state) {
        if (state.mainStatus == MainStatus.loaded) {
          final match = state.match!;
          allPlayerField = match.position;
          final userPlayerIsConfirmed =
              !match.isParticipating! ? false : _checkParticipatingIsConfirmed();

          if (match.isParticipating!) {
            joinerSelectedPosition = _getUserPLayerPos();
          }
          return Scaffold(
            backgroundColor: AppColors.backGrey,
            appBar: matchDetailsAppbar(match, context),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PurpleBoxWidget(match: match),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AboveFieldInfoWidget(),
                          MatchFieldsUtils.getFieldFromSportAndPLayerCount(
                            sportType: match.sportCat!.sportType,
                            playerCount: match.playersPerTeam!,
                            callback: (value) async {
                              if (match.isCreator!) {
                                if (spotIsEmpty(value, allPlayerField)) {
                                  print('isEmpty');
                                  _showPlayerLIstBottomSheet(context, value, allPlayerField);
                                } else {
                                  if (playerIsDeletable(value, allPlayerField) != null) {
                                    final int playerId = playerIsDeletable(value, allPlayerField)!;
                                    print('should prompt delete player $playerId');
                                    bool confirm = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirm"),
                                            content: const Text(
                                                "Are you sure to cancel this player's participation ?"),
                                            actions: <Widget>[
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: AppColors.yellow,
                                                  ),
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                  child: Text(
                                                    "Cancel participation",
                                                    style: AppStyles.inter13SemiBold
                                                        .withColor(Colors.black),
                                                  )),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.transparent,
                                                ),
                                                onPressed: () => Navigator.of(context).pop(false),
                                                child: Text(
                                                  "Back",
                                                  style: AppStyles.inter13SemiBold
                                                      .withColor(Colors.black),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                    if (confirm) {
                                      matchDetailsCubit.creatorCancelsAPendingPlayer(
                                        matchId: match.id!,
                                        playerId: playerId,
                                      );
                                    }
                                  } else {
                                    print('undeletable no position in state');
                                  }
                                }
                              }
                              if (match.isInvited!) return;

                              if (!match.isCreator! && !userPlayerIsConfirmed) {
                                _handleJoiner(value);
                                return;
                              }
                            },
                            listFilledUsers: List.from(allPlayerField),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            if (match.isCreator!)
                              const SizedBox.shrink()
                            else if (!match.isCreator! && !userPlayerIsConfirmed)
                              SizedBox(
                                height: 70.h,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      color: AppColors.purple,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${match.price} QAR",
                                                style: AppStyles.inter20SemiBold
                                                    .withColor(Colors.white)),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 6),
                                              height: 24,
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            Text("${match.duration} min",
                                                style: AppStyles.inter13SemiBold
                                                    .withColor(Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (joinerSelectedPosition != null) {
                                          EasyLoading.show(dismissOnTap: true);
                                          matchDetailsCubit.joinMatch(
                                              matchId: match.id!,
                                              position: joinerSelectedPosition!);
                                        }
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        color: AppColors.yellow,
                                        child: Center(
                                          child: Builder(builder: (context) {
                                            return Text(
                                              joinerSelectedPosition != null
                                                  ? "Pay Now"
                                                  : "Pick your spot",
                                              style: AppStyles.inter20SemiBold
                                                  .copyWith(color: Colors.black, fontSize: 20.sp),
                                              textAlign: TextAlign.center,
                                            );
                                          }),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else if (match.isInvited!)
                              SizedBox(
                                height: 70.h,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      color: AppColors.purple,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${match.price} QAR",
                                                style: AppStyles.inter20SemiBold
                                                    .withColor(Colors.white)),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 6),
                                              height: 24,
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            Text("${match.duration} min",
                                                style: AppStyles.inter13SemiBold
                                                    .withColor(Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RouteList.matchPaymentScreen,
                                                arguments: {
                                                  "matchId": state.match!.id!,
                                                  "amount": match.price,
                                                });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.3,
                                            color: const Color(0xff97FD68),
                                            child: Center(
                                              child: Builder(builder: (context) {
                                                return Text(
                                                  "Accept",
                                                  style: AppStyles.inter20SemiBold.copyWith(
                                                      color: Colors.black, fontSize: 20.sp),
                                                  textAlign: TextAlign.center,
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            EasyLoading.show(dismissOnTap: true);
                                            matchDetailsCubit.rejectInvite(
                                              matchId: match.id!,
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.3,
                                            color: AppColors.mainRed,
                                            child: Center(
                                              child: Builder(builder: (context) {
                                                return Text(
                                                  "Reject",
                                                  maxLines: 1,
                                                  style: AppStyles.inter20SemiBold.copyWith(
                                                      fontSize: 20.sp, color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.infoIcon,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text(
                                          "Request to join accepted, you must pay for your\nspot to secure your booking",
                                          style: AppStyles.inter12w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.infoIcon,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Match not confirmed until all players have paid",
                                        style: AppStyles.inter12w500)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                      match.playground!.latitude!, match.playground!.longitude!);
                                }),
                            ButtonIcon(
                                title: "Call",
                                icon: Assets.handsetIcon,
                                callback: () {
                                  PlaygroundUtils.callNumber(match.playground!.phone);
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
                            for (final tag in match.playground!.tags!)
                              TagItem(title: tag.nameEn ?? "")
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
                                children: match.playground!.shifts!
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
                          markers: Set<Marker>.of(widget._markers),
                          initialCameraPosition: widget._kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            widget._controller.complete(controller);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 127,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 80.h,
                  width: 170.w,
                  height: 50.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: TextButton(
                      style: AppStyles.elevatedButtonDefaultStyle,
                      onPressed: () {
                        if (match.isChatJoined != true) {
                          matchDetailsCubit.joinChatMatch(roomId: match.roomId!);
                        }
                        Navigator.pushNamed(context, RouteList.chatDetails,
                            arguments: {"match": match});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.chatIcon, width: 24.w, height: 24.h),
                          SizedBox(width: 10.w),
                          Text(
                            'Chat',
                            style: AppStyles.inter14w500
                                .copyWith(fontWeight: FontWeight.bold, color: AppColors.purple),
                          ),
                        ],
                      ),
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

  AppBar matchDetailsAppbar(MatchModel match, BuildContext context) {
    return AppBar(
      title: Text('${match.type.toString().capitalize} Match', style: AppStyles.mont27bold),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Image.asset(
          Assets.backBtn,
          height: 21,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.exportIcon,
            height: 21,
          ),
        ),
      ],
    );
  }

  _showPlayerLIstBottomSheet(
      BuildContext mainContext, int selectedSpot, List<PlayerModel?> allPlayerField) {
    // print(players.length);
    showModalBottomSheet(
        context: mainContext,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: mainContext.read<MatchPlayerPickerCubit>(),
              ),
              BlocProvider.value(
                value: mainContext.read<MatchDetailsCubit>(),
              ),
              BlocProvider.value(
                value: mainContext.read<MatchPlayerSearchBloc>(),
              ),
            ],
            child: MatchPlayerBottomSheetContent(
              selectedSpot: selectedSpot,
              allPlayerField: allPlayerField,
            ),
          );
        });
  }

  void _handleJoiner(int selectedSpot) {
    final user = context.read<UserCubit>().state.user!;
    // check user existance
    if (allPlayerField.where((element) => element != null && element.id == user.id).isNotEmpty) {
      final index =
          allPlayerField.indexWhere((element) => element != null && element.id == user.id);
      allPlayerField[index] = null;
    }
    if (allPlayerField[selectedSpot] == null) {
      PlayerModel userAsPlayer = playerFromUser(user: user, fieldPosition: selectedSpot);
      allPlayerField[selectedSpot] = userAsPlayer;
      joinerSelectedPosition = selectedSpot;
      setState(() {});
    }
  }

  _checkParticipatingIsConfirmed() {
    final user = context.read<UserCubit>().state.user!;
    return allPlayerField
        .where((element) => element != null && element.id == user.id)
        .first!
        .isConfirmed!;
  }

  int _getUserPLayerPos() {
    final user = context.read<UserCubit>().state.user!;
    return allPlayerField
        .where((element) => element != null && element.id == user.id)
        .first!
        .fieldPosition!;
  }

  bool spotIsEmpty(int value, List<PlayerModel?> allPlayerField) {
    if (allPlayerField
        .where((element) => element != null && element.fieldPosition == null)
        .isNotEmpty) return false;
    return allPlayerField
        .where((element) => element != null && element.fieldPosition! == value)
        .isEmpty;
  }

  // returns playerId if deletable
  int? playerIsDeletable(int value, List<PlayerModel?> allPlayerField) {
    if (allPlayerField
        .where((element) => element != null && element.fieldPosition == null)
        .isNotEmpty) return null;
    final PlayerModel player = allPlayerField
        .where((element) => element != null && element.fieldPosition! == value)
        .first!;
    if (player.id == context.read<UserCubit>().state.user!.id!) return null;
    if (!player.isConfirmed!) return player.id;
    return null;
  }
}

class AboveFieldInfoWidget extends StatelessWidget {
  const AboveFieldInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Container(
            height: 30,
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Center(
              child:
                  Text('Level x.x - y.y', style: AppStyles.inter13w500.withColor(AppColors.purple)),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.purple),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    Assets.infoIcon,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text("Slot chosen does not represent actual position \nfor the match",
                          style: AppStyles.inter12w500))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
