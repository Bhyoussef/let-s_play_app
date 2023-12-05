import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/enums/payment_modality.dart';
import 'package:lets_play/models/enums/public_private_type.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:lets_play/routes/routes_list.dart';

import '../../common/components/standard_close_appBar.dart';
import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import 'components/mainScreen/PaymentMethodSection.dart';
import 'cubit/summary_cubit.dart';

class SummaryScreen extends StatelessWidget {
  final Map<String, dynamic> creationParams;
  final PlaygroundModel playground;
  final PublicPrivateType publicPrivateType;
  final DateTime startDate;
  final int duration;
  final int playersPerTeam;
  final List<Map<String, dynamic>> teamAPlayer;
  final List<Map<String, dynamic>> teamBPlayer;
  final List<PlayerModel?> players;

  const SummaryScreen(
      {Key? key,
      required this.creationParams,
      required this.playground,
      required this.publicPrivateType,
      required this.startDate,
      required this.duration,
      required this.playersPerTeam,
      required this.teamAPlayer,
      required this.teamBPlayer,
      required this.players})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryCubit()
        ..initialize(
            creationParams: creationParams,
            publicPrivateType: publicPrivateType),
      child: SummaryScreenContent(
        playground: playground,
        duration: duration,
        publicPrivateType: publicPrivateType,
        startDate: startDate,
        playersPerTeam: playersPerTeam,
        players: players,
        teamAPlayer: teamAPlayer,
        teamBPlayer: teamBPlayer,
      ),
    );
  }
}

class SummaryScreenContent extends StatelessWidget {
  const SummaryScreenContent({
    Key? key,
    required this.playground,
    required this.publicPrivateType,
    required this.startDate,
    required this.duration,
    required this.playersPerTeam,
    required this.players,
    required this.teamAPlayer,
    required this.teamBPlayer,
  }) : super(key: key);
  final PlaygroundModel playground;
  final PublicPrivateType publicPrivateType;
  final int playersPerTeam;
  final DateTime startDate;
  final int duration;
  final List<PlayerModel?> players;
  final List<Map<String, dynamic>> teamAPlayer;
  final List<Map<String, dynamic>> teamBPlayer;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SummaryCubit, SummaryState>(
      listenWhen: (previous, current) =>
          previous.matchCreationResult != current.matchCreationResult ||
          previous.attemptTime != current.attemptTime,
      listener: (context, state) {
        state.matchCreationResult?.fold((failure) {
          EasyLoading.showError(mapFailureToMessage(failure));
        }, (r) {
          final match = r;
          EasyLoading.dismiss();
          Navigator.pushNamed(context, RouteList.matchPaymentScreen,
              arguments: {"matchId": match.id!, "amount": state.toBePaid!});
        });
      },
      child: BlocListener<SummaryCubit, SummaryState>(
        listener: (context, state) async {
          if (state.processing == true) {
            EasyLoading.show(dismissOnTap: true);
          } else {
            await Future.delayed(const Duration(seconds: 3));
            EasyLoading.dismiss();
          }
        },
        child: Scaffold(
          appBar: buildStandardCloseAppBar(context: context, title: 'Summary'),
          bottomNavigationBar: BlocBuilder<SummaryCubit, SummaryState>(
            builder: (context, state) {
              return YellowSubmitButton(
                  buttonText: 'Create Match',
                  height: 75,
                  onPressed: () {
                    if (state.modality == PaymentModality.partial &&
                        state.publicPrivateType == PublicPrivateType.private &&
                        state.teamsForPartialPrivate!.isEmpty) {
                      EasyLoading.showError(
                          'Please set players payment amounts');
                      return;
                    }
                    context.read<SummaryCubit>().createMatch();
                  });
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 15, top: 23, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${startDate.toDayWeekdayMonthAbrDayFormatted()} | ${startDate.toDefaultTimeHMFormatted()}',
                                  style: AppStyles.inter17Bold),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      playground.nameEn! +
                                          ' | ' +
                                          playground.grassTypeEn!,
                                      style: AppStyles.inter14w500,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 132,
                                  ),
                                  Container(
                                    height: 52,
                                    width: 56,
                                    decoration: BoxDecoration(
                                        color: AppColors.yellow,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        '$duration\nmin',
                                        style: AppStyles.inter15Bold.withColor(
                                          Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        PaymentMethodSection(
                          playersPerTeam: playersPerTeam,
                          playground: playground,
                          publicOrPrivateType: publicPrivateType,
                          players: players,
                          teamAPlayer: teamAPlayer,
                          teamBPlayer: teamBPlayer,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Subtotal
                if (false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal',
                                style: AppStyles.inter17Bold),
                            Text(
                              'QAR ',
                              style: AppStyles.inter20SemiBold
                                  .copyWith(color: AppColors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cancelation policy: Up to 24 hours',
                        style: AppStyles.inter12w500
                            .copyWith(color: AppColors.purple),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
