import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/default_button.dart';
import 'package:lets_play/common/components/standard_close_appBar.dart';
import 'package:lets_play/common/components/yellow_submit_button.dart';
import 'package:lets_play/common/extensions/dateTime_extensions.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/add_score/cubit/add_score_cubit.dart';
import 'package:lets_play/features/add_score/models/scoreSet.dart';
import 'package:lets_play/features/payment/widgets/CouponTextField.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';


import '../../common/constants/app_constants.dart';

class AddScoreScreen extends StatelessWidget {
  const AddScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AddScoreCubit()..getScorableMatches(),
      child: const AddScoreContent(),
    );
  }
}

class AddScoreContent extends StatelessWidget {
  const AddScoreContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildStandardCloseAppBar(context: context, title: 'Add Score'),
      // bottomNavigationBar: YellowSubmitButton(buttonText: 'Upload Score', onPressed: () {}),
      body: BlocBuilder<AddScoreCubit, AddScoreState>(
        builder: (context, state) {
          if (state.mainStatus == MainStatus.loaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemCount: state.scorableMatches!.length,
                    itemBuilder: ((context, index) {
                      final match = state.scorableMatches![index];
                      return AddScoreCard(
                        match: match,
                      );
                    }),
                  ),
                ),
              ],
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }
}

class AddScoreCard extends StatelessWidget {
  const AddScoreCard({
    Key? key,
    required this.match,
  }) : super(key: key);
  final MatchModel match;
  @override
  Widget build(BuildContext context) {
    final addScoreCubit = context.read<AddScoreCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(match.playground!.nameEn!, style: AppStyles.sf17Bold),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),
                              Text(
                                '${match.startDate!.toDayWeekdayMonthAbrDayFormatted()} | ${match.startDate!.toDefaultTimeHMFormatted()} - ${match.endDate!.toDefaultTimeHMFormatted()}',
                                style: AppStyles.sf14W500.copyWith(color: const Color(0xff11002B)),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                match.sportCat!.nameEn!.capitalizeEveryWord,
                                style: AppStyles.sf14W500.copyWith(color: const Color(0xff11002B)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Text(
                        '${match.duration}\nmin',
                        style: AppStyles.sf15Bold.withColor(
                          Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DefaultButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      isScrollControlled: true,
                      builder: (context) {
                        return BlocProvider.value(
                          value: addScoreCubit,
                          child: AddMatchScoreSheetContent(match: match),
                        );
                      });
                },
                text: 'Add Score',
                btnColor: AppColors.grey,
                textColor: Colors.black,
                width: double.infinity,
                textStyle: AppStyles.mont17Bold.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMatchScoreSheetContent extends StatefulWidget {
  const AddMatchScoreSheetContent({super.key, required this.match});
  final MatchModel match;

  @override
  State<AddMatchScoreSheetContent> createState() => _AddMatchScoreSheetContentState();
}

class _AddMatchScoreSheetContentState extends State<AddMatchScoreSheetContent> {
  @override
  void initState() {
    super.initState();
    final addScoreCubit = context.read<AddScoreCubit>();
    addScoreCubit.initAddScoreSheet(match: widget.match);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: BlocBuilder<AddScoreCubit, AddScoreState>(
          builder: (context, state) {
            final addScoreCubit = context.read<AddScoreCubit>();

            return LimitedBox(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(height: 32.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Team A', style: AppStyles.mont16Bold),
                            Column(
                              children: [
                                const Text('Sets', style: AppStyles.inter12Bold),
                                QuantityWidget(
                                    initialValue: state.teamAScoreSets!.length,
                                    match: widget.match),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Wrap(children: [
                          for (var index = 0; index < state.teamAScoreSets!.length; index++)
                            SetTextField(
                                index: index,
                                scoreSet: state.teamAScoreSets![index],
                                isTeamA: true),
                        ]),
                        SizedBox(height: 32.h),
                        const Text('Team B', style: AppStyles.mont16Bold),
                        SizedBox(height: 20.h),
                        Wrap(children: [
                          for (var index = 0; index < state.teamBScoreSets!.length; index++)
                            SetTextField(
                                index: index,
                                scoreSet: state.teamAScoreSets![index],
                                isTeamA: false),
                        ]),
                        SizedBox(height: 25.h),
                      ]),
                    ),
                    YellowSubmitButton(
                        disabled: !addScoreCubit.isSetsFilled,
                        buttonText: 'Confirm',
                        onPressed: () {
                          final addScoreCubit = context.read<AddScoreCubit>();
                          addScoreCubit.sendScore(widget.match);
                          Navigator.pop(context);
                          EasyLoading.show(dismissOnTap: true);
                        }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({super.key, required this.initialValue, required this.match});
  final int initialValue;
  final MatchModel match;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int _counter;
  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container()/*QuantityInput(
      iconColor: AppColors.yellow,
      buttonColor: AppColors.purple,
      minValue: 1,
      value: _counter,
      onChanged: (value) {
        final intValue = int.parse(value.replaceAll(',', ''));
        final addScoreCubit = context.read<AddScoreCubit>();

        if (_counter < intValue) {
          addScoreCubit.addEmptyScoreSheet(widget.match);
        } else {
          addScoreCubit.removeLastScoreSheet();
        }
        setState(() => _counter = intValue);
      },
    )*/;
  }
}

class SetTextField extends StatelessWidget {
  const SetTextField({
    super.key,
    required this.index,
    required this.scoreSet,
    required this.isTeamA,
  });
  final int index;
  final ScoreSet scoreSet;
  final bool isTeamA;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: SizedBox(
        width: 108.w,
        height: 50.h,
        child: TextFormField(
          onChanged: (value) {
            final addScoreCubit = context.read<AddScoreCubit>();
            final int? intValue = int.tryParse(value);
            addScoreCubit.scoreSetTextChanged(
                index: index, newValue: intValue, scoreSet: scoreSet, isTeamA: isTeamA);
          },
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 2),
              enabledBorder: couponTextFieldBorder,
              focusedBorder: couponTextFieldBorder,
              border: couponTextFieldBorder,
              errorBorder: couponErroredTextFieldBorder,
              fillColor: Colors.white,
              focusColor: Colors.white,
              hintText: 'Set ${index + 1}'),
        ),
      ),
    );
  }
}
