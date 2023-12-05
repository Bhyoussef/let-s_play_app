import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/features/summary_screen/cubit/summary_cubit.dart';
import 'package:lets_play/models/enums/payment_modality.dart';
import 'package:lets_play/models/enums/public_private_type.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:lets_play/routes/routes_list.dart';

import '../../../../common/components/custom_radioBox.dart/CustomRadioboxWidget.dart';
import '../../../../common/constants/app_constants.dart';

class PaymentMethodSection extends StatefulWidget {
  final int playersPerTeam;
  final PlaygroundModel playground;
  final PublicPrivateType publicOrPrivateType;
  final List<PlayerModel?> players;
  final List<Map<String, dynamic>> teamAPlayer;
  final List<Map<String, dynamic>> teamBPlayer;

  const PaymentMethodSection(
      {Key? key,
      required this.playersPerTeam,
      required this.playground,
      required this.publicOrPrivateType,
      required this.players,
      required this.teamAPlayer,
      required this.teamBPlayer})
      : super(key: key);
  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  PaymentModality? currentPm;
  int? groupValue;
  @override
  void initState() {
    super.initState();
    currentPm = PaymentModality.partial;
    groupValue = 0;
    context.read<SummaryCubit>().setModality(currentPm);
  }

  @override
  Widget build(BuildContext context) {
    num playerPart = num.parse(
        (widget.playground.price! / (widget.playersPerTeam * 2))
            .toStringAsFixed(2));
    final summaryCubit = context.read<SummaryCubit>();
    return Column(
      children: [
        //divider
        Container(
          height: 1,
          color: AppColors.backGrey,
        ),
        // pay your part radio btn
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomRadioboxWidget(
                        activeBgColor: Colors.white,
                        customBgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveBorderColor: AppColors.disabledGrey,
                        size: 25,
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            currentPm = PaymentModality.partial;
                            groupValue = 0;
                          });
                          summaryCubit.setModality(currentPm);
                        },
                        activeBorderColor: AppColors.purple,
                        radioColor: AppColors.purple,
                        inactiveRadioColor: AppColors.disabledGrey,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Text('Pay Your Part ',
                          style: AppStyles.inter15Bold),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          '1X',
                          style: AppStyles.inter10w500
                              .copyWith(color: AppColors.purple),
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<SummaryCubit, SummaryState>(
                    builder: (context, state) {
                      if (widget.publicOrPrivateType ==
                          PublicPrivateType.public) {
                        return Text('QAR $playerPart',
                            style: AppStyles.inter15w500);
                      } else {
                        if (state.teamsForPartialPrivate!.isEmpty) {
                          return const Text('ND', style: AppStyles.inter15w500);
                        } else {
                          final myId =
                              context.read<UserCubit>().state.user!.id!;
                          final myPrice = _getMyPriceFromTeams(
                              state.teamsForPartialPrivate!, myId);
                          return Text('QAR ' + myPrice.toStringAsFixed(2),
                              style: AppStyles.inter15w500);
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                  'Split the booking price between all players! If other players do not submit their payment within 1 hour of your payment, you will be charged an additional amount.',
                  style: AppStyles.inter11w500),
              const SizedBox(height: 12),
              if (widget.publicOrPrivateType == PublicPrivateType.private)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteList.addPlayerPlaymentAmountScreen,
                        arguments: {
                          "players": widget.players,
                          "teamAPlayer": widget.teamAPlayer,
                          "teamBPlayer": widget.teamBPlayer,
                          "playersPerTeam": widget.playersPerTeam,
                          "totalPrice": widget.playground.price!,
                          "summaryCubit": summaryCubit,
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('Set players payment amounts',
                        style: AppStyles.sf15Bold.copyWith(
                          color: AppColors.purple,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
              const SizedBox(height: 22),
            ],
          ),
        ),
        //divider

        Container(
          height: 1,
          color: AppColors.backGrey,
        ),
        //pay everythin radio btn
        if (widget.publicOrPrivateType == PublicPrivateType.private)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomRadioboxWidget(
                          activeBgColor: Colors.white,
                          customBgColor: Colors.white,
                          inactiveBgColor: Colors.white,
                          inactiveBorderColor: AppColors.disabledGrey,
                          size: 25,
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              currentPm = PaymentModality.total;
                              groupValue = 1;
                            });
                            summaryCubit.setModality(currentPm);
                          },
                          activeBorderColor: AppColors.purple,
                          radioColor: AppColors.purple,
                          inactiveRadioColor: AppColors.disabledGrey,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        const Text('Pay Everything ',
                            style: AppStyles.inter15Bold),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '${widget.playersPerTeam * 2}X',
                            style: AppStyles.inter10w500
                                .copyWith(color: AppColors.purple),
                          ),
                        )
                      ],
                    ),
                    Text('QAR ${widget.playground.price!.toStringAsFixed(2)}',
                        style: AppStyles.inter15w500),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
      ],
    );
  }

  num _getMyPriceFromTeams(List<Map<String, dynamic>> teams, int myId) {
    num price = 0;
    List<Map<String, dynamic>> teamAPlayer = teams[0]['players'];
    List<Map<String, dynamic>> teamBPlayer = teams[1]['players'];
    for (var element in teamAPlayer) {
      if (element['user_id'] == myId) {
        price = element['price'];
      }
    }
    for (var element in teamBPlayer) {
      if (element['user_id'] == myId) {
        price = element['price'];
      }
    }
    return price;
  }
}
