import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/components/standard_close_appBar.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/features/summary_screen/cubit/summary_cubit.dart';

import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import 'package:flutter/services.dart';

class AddPLayerAmountScreen extends StatefulWidget {
  const AddPLayerAmountScreen(
      {Key? key,
      required this.players,
      required this.playersPerTeam,
      required this.summaryCubit,
      required this.totalPrice,
      required this.teamAPlayer,
      required this.teamBPlayer})
      : super(key: key);
  final List<PlayerModel?> players;
  final int playersPerTeam;
  final num totalPrice;
  final SummaryCubit summaryCubit;
  final List<Map<String, dynamic>> teamAPlayer;
  final List<Map<String, dynamic>> teamBPlayer;

  @override
  State<AddPLayerAmountScreen> createState() => _AddPLayerAmountScreenState();
}

class _AddPLayerAmountScreenState extends State<AddPLayerAmountScreen> {
  bool isInputValid = true;
  List<TextEditingController> amountControllers = [];
  List<PlayerModel> players = [];
  List<Map<String, dynamic>> teamAPlayer = [];
  List<Map<String, dynamic>> teamBPlayer = [];

  // final Map<String, dynamic> teamPlayer = {
  //   "position": widget.selectedSpot,
  //   "user_id": player.id
  // };
  num get currentAmount => _getCurrentFieldsAmount();
  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  void initState() {
    super.initState();
    initPlayersList();
    createAndInitControllers();
  }

  initPlayersList() {
    players = List.from(widget.players);
    players.sort((a, b) => b.isMe.toString().compareTo(a.isMe.toString()));
    teamAPlayer = List.from(widget.teamAPlayer);
    teamBPlayer = List.from(widget.teamBPlayer);
  }

  disposeControllers() {
    for (var controller in amountControllers) {
      controller.dispose();
    }
  }

  createAndInitControllers() {
    for (var i = 0; i < players.length; i++) {
      final player = players[i];
      final calculatedPrice = _getPlayerInitialValue(
        player: player,
        currentPlayerCount: players.length,
        totalPlayerCount: widget.playersPerTeam * 2,
        totalPrice: widget.totalPrice,
      );

      amountControllers
          .add(TextEditingController(text: calculatedPrice.toStringAsFixed(2)));

      for (var element in teamAPlayer) {
        if (element['user_id'] == player.id) {
          teamAPlayer.firstWhere(
                  (element) => element['user_id'] == player.id)['price'] =
              calculatedPrice;
        }
      }
      for (var element in teamBPlayer) {
        if (element['user_id'] == player.id) {
          teamBPlayer.firstWhere(
                  (element) => element['user_id'] == player.id)['price'] =
              calculatedPrice;
        }
      }
    }
  }

  void _updateTeams(int playerId, String priceText) {
    final price = num.parse(priceText.isEmpty ? '0' : priceText);
    for (var element in teamAPlayer) {
      if (element['user_id'] == playerId) {
        teamAPlayer.firstWhere(
            (element) => element['user_id'] == playerId)['price'] = price;
      }
    }
    for (var element in teamBPlayer) {
      if (element['user_id'] == playerId) {
        teamBPlayer.firstWhere(
            (element) => element['user_id'] == playerId)['price'] = price;
      }
    }
  }

  num _getPlayerInitialValue(
      {required PlayerModel player,
      required int currentPlayerCount,
      required int totalPlayerCount,
      required num totalPrice}) {
    final num playerDefaultPart =
        num.parse((totalPrice / totalPlayerCount).toStringAsFixed(2));
    if (!player.isMe) {
      return playerDefaultPart;
    } else {
      return totalPrice - (playerDefaultPart * (currentPlayerCount - 1));
    }
  }

  num _getCurrentFieldsAmount() {
    num amount = 0;
    for (var controller in amountControllers) {
      amount += num.parse(controller.text.isNotEmpty ? controller.text : '0');
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.summaryCubit,
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: YellowSubmitButton(
              buttonText: 'Confirm',
              onPressed: () {
                context
                    .read<SummaryCubit>()
                    .setCreateParamsTeams(teamAPlayer, teamBPlayer);
                Navigator.pop(context);
              },
              disabled: currentAmount != widget.totalPrice),
          appBar: buildStandardCloseAppBar(
              context: context, title: 'Payment amount'),
          body: Column(
            children: [
              const Divider(
                color: Color(0xffD7DBDE),
                height: 1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    const Text(
                      'Added players will have an amount divided between them',
                      style: AppStyles.mont17Bold,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Total price : ${currentAmount.toStringAsFixed(2)}',
                      style: AppStyles.mont17Bold.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 23.sp,
                          color: AppColors.purple),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          return PlayerTileRow(
                            player: players[index],
                            controller: amountControllers[index],
                            onChanged: (value) {
                              _updateTeams(players[index].id, value);
                              setState(() {});
                            },
                          );
                        },
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class PlayerTileRow extends StatelessWidget {
  const PlayerTileRow({
    Key? key,
    required this.player,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);
  final PlayerModel player;
  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60.w,
            child: Column(
              children: [
                ClipOval(
                  child: player.avatar == null
                      ? Container(
                          width: 51,
                          height: 51,
                          color: AppColors.purple,
                          child: Center(
                            child: Text(
                              player.firstName[0].toUpperCase(),
                              style: AppStyles.inter20SemiBold
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      : MyNetworkImage(
                          picPath: player.avatar,
                          width: 51,
                          height: 51,
                        ),
                ),
                SizedBox(height: 5.h),
                Text(
                  player.isMe ? 'Me' : player.firstName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.inter11w500.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
              child: AmountTextField(
            controller: controller,
            onChanged: (value) {
              onChanged(value);
            },
          ))
        ],
      ),
    );
  }
}

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);
  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        onChanged: (term) {
          onChanged(term);
        },
        controller: controller,
        style: AppStyles.mont19BoldBlack.copyWith(height: 2),
        textInputAction: TextInputAction.done,
        cursorColor: AppColors.purple,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          hintText: '00.00',
          helperStyle: AppStyles.mont19BoldBlack.copyWith(height: 2),
          isDense: true,
          contentPadding: const EdgeInsets.only(left: 20, bottom: 13, top: 5),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          fillColor: AppColors.backGrey,
          focusColor: AppColors.backGrey,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'QAR ',
                  style: AppStyles.mont19BoldBlack,
                ),
              ],
            ),
          ),
          suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.edit_outlined,
                color: Color(0xffD7DBDE),
                size: 30,
              )),
        ),
      ),
    );
  }
}
