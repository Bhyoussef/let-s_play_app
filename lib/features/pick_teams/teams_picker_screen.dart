import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/pick_teams/components/player_picker_bottom_sheet.dart';
import 'package:lets_play/models/server/playground_model.dart';
import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import '../../models/enums/public_private_type.dart';
import '../../models/enums/sport_type.dart';
import '../../routes/routes_list.dart';
import '../../utils/matchFields.dart';
import '../profile/cubit/user_cubit.dart';
import 'bloc/player_search_bloc.dart';
import 'cubit/player_picker_cubit.dart';
import 'cubit/team_picker_cubit.dart';
import 'models/player_model.dart';

class TeamsPickerScreen extends StatelessWidget {
  const TeamsPickerScreen({
    Key? key,
    required this.playerCount,
    required this.sportType,
    required this.params,
    required this.publicOrPrivate,
    required this.playground,
  }) : super(key: key);
  final int playerCount;
  final SportType sportType;
  final Map<String, dynamic>? params;
  final PublicPrivateType publicOrPrivate;
  final PlaygroundModel playground;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TeamPickerCubit(
            playerCount: playerCount,
            sportType: sportType,
          ),
        ),
        BlocProvider(
          create: (context) => PlayerPickerCubit(),
        ),
        BlocProvider(
          create: (context) =>
              PlayerSearchBloc(context.read<PlayerPickerCubit>()),
        ),
      ],
      child: TeamsPickerScreenContent(
        sportType: sportType,
        params: params,
        playerCount: playerCount,
        publicPrivateType: publicOrPrivate,
        playground: playground,
      ),
    );
  }
}

class TeamsPickerScreenContent extends StatefulWidget {
  const TeamsPickerScreenContent({
    Key? key,
    required this.playerCount,
    required this.sportType,
    required this.params,
    required this.publicPrivateType,
    required this.playground,
  }) : super(key: key);
  final int playerCount;
  final SportType sportType;
  final Map<String, dynamic>? params;
  final PublicPrivateType publicPrivateType;
  final PlaygroundModel playground;

  @override
  State<StatefulWidget> createState() {
    return TeamsPickerScreenContentState();
  }
}

class TeamsPickerScreenContentState extends State<TeamsPickerScreenContent> {
  ///7 players empty array and we will replace the clicked spots
  late List<PlayerModel?> allPlayerField;

  List<Map<String, dynamic>> teamAPlayer = [];
  List<Map<String, dynamic>> teamBPlayer = [];

  @override
  void initState() {
    super.initState();
    allPlayerField = List.from(emptyPlayersSpotsArray);
    final user = context.read<UserCubit>().state.user!;
    context.read<PlayerPickerCubit>().getListPlayers(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamPickerCubit, TeamPickerState>(
      listener: (context, state) async {
        if (state is TeamPickerInitial) {
          EasyLoading.show(dismissOnTap: true);
        }

        if (state is PlayerPickedSuccess) {
          if (state.isInTeamA) {
            teamAPlayer.add(state.teamPlayerData);
          } else {
            teamBPlayer.add(state.teamPlayerData);
          }
        }

        if (state is ErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError('Error server, please try again...');
        }
      },
      builder: (context, state) {
        return body(context);
      },
    );
  }

  Widget body(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: YellowSubmitButton(
          buttonText: 'Next',
          onPressed: () {
            if (allPlayerField
                .where((element) => element != null && element.isMe == true)
                .isEmpty) {
              EasyLoading.showError(
                  'Must at least pick your position as a player');
              return;
            }
            _setPlayersDefaultAmountToPay();
            final Map<String, dynamic> params = {
              "category_number_player_id":
                  widget.params?["number_players_id"] ?? "",
              "playground_id": widget.params?["playground_id"] ?? "",
              "type": widget.publicPrivateType.toString(),
              "start_date": widget.params?["start_at"] ?? "",
              "category_duration_id": widget.params?["duration_id"] ?? "",
              "gender": "male",
              "position": jsonEncode(allPlayerField),
              "teams": [
                {"name": "team A", "players": teamAPlayer},
                {"name": "team B", "players": teamBPlayer}
              ]
            };

            Navigator.pushNamed(context, RouteList.summaryScreen, arguments: {
              "creationParams": params,
              "playground": widget.playground,
              "publicPrivateType": widget.publicPrivateType,
              "duration": widget.params?["duration"],
              "playersPerTeam": widget.playerCount,
              "startDate": widget.params?["start_at"]
                  .toString()
                  .defaultFomatToDateTime()!,
              "players":
                  allPlayerField.where((element) => element != null).toList(),
              "teamAPlayer": teamAPlayer,
              "teamBPlayer": teamBPlayer,
            });
          }),
      appBar: AppBar(
        title: Text('Pick teams', style: AppStyles.mont27bold),
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
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PurpleDetailBanner(
              playground: widget.playground,
              startDateString: widget.params?["start_at"]),
          MatchFieldsUtils.getFieldFromSportAndPLayerCount(
            sportType: widget.sportType,
            playerCount: widget.playerCount,
            callback: (value) {
              _showPlayerLIstBottomSheet(context, value, allPlayerField);
            },
            listFilledUsers: allPlayerField,
          ),
        ],
      )),
    );
  }

  _showPlayerLIstBottomSheet(BuildContext mainContext, int selectedSpot,
      List<PlayerModel?> allPlayerField) {
    // print(players.length);
    showModalBottomSheet(
        context: mainContext,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: mainContext.read<TeamPickerCubit>(),
              ),
              BlocProvider.value(
                value: mainContext.read<PlayerPickerCubit>(),
              ),
              BlocProvider.value(
                value: mainContext.read<PlayerSearchBloc>(),
              ),
            ],
            child: PlayerBottomSheetContent(
              selectedSpot: selectedSpot,
              allPlayerField: allPlayerField,
            ),
          );
        });
  }

  void _setPlayersDefaultAmountToPay() {
    for (var playerAData in teamAPlayer) {
      final price = widget.playground.price! / (widget.playerCount * 2);
      playerAData['price'] = num.parse(price.toStringAsFixed(2));
    }
    for (var playerBData in teamBPlayer) {
      final price = widget.playground.price! / (widget.playerCount * 2);
      playerBData['price'] = num.parse(price.toStringAsFixed(2));
    }
  }
}

class PurpleDetailBanner extends StatelessWidget {
  const PurpleDetailBanner(
      {Key? key, required this.playground, required this.startDateString})
      : super(key: key);
  final PlaygroundModel playground;
  final String startDateString;
  @override
  Widget build(BuildContext context) {
    final DateTime startDate = startDateString.defaultFomatToDateTime()!;
    return Container(
      color: AppColors.purple,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 24.w),
        child: Row(
          children: [
            Image.asset(
              Assets.stadeIcon,
              height: 27,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(playground.nameEn!,
                    style: AppStyles.mont17Bold.withColor(Colors.white)),
                const SizedBox(
                  height: 4,
                ),
                Text(
                    '${startDate.toDayWeekdayMonthAbrDayFormatted()} | ${startDate.toDefaultTimeHMFormatted()}',
                    style: AppStyles.inter13w500.withColor(Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
