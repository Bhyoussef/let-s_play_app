import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/components/yellow_submit_button.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/create_match/components/players_list.dart';
import 'package:lets_play/models/enums/public_private_type.dart';
import 'package:lets_play/services/date_time_service.dart';
import '../../common/components/app_bar/app_bar_with_back_btn.dart';
import '../../models/server/playground_model.dart';
import '../../models/sport_category_model.dart';
import '../../routes/routes_list.dart';
import '../../services/kiwi_container.dart';
import '../profile_settings/common/text_field_decoration.dart';
import 'components/durations_list.dart';
import 'cubit/create_match_cubit.dart';
import 'models/DurationModel.dart';

class CreateMatchScreen extends StatelessWidget {
  const CreateMatchScreen({Key? key, required this.publicOrPrivate, required this.playground})
      : super(key: key);
  final PublicPrivateType publicOrPrivate;
  final PlaygroundModel playground;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateMatchCubit(),
      child: CreateMatchScreenContent(playground: playground, publicOrPrivate: publicOrPrivate),
    );
  }
}

class CreateMatchScreenContent extends StatefulWidget {
  const CreateMatchScreenContent(
      {Key? key, required this.publicOrPrivate, required this.playground})
      : super(key: key);
  final PublicPrivateType publicOrPrivate;
  final PlaygroundModel playground;

  @override
  State<StatefulWidget> createState() {
    return CreateMatchScreenContentState();
  }
}

class CreateMatchScreenContentState extends State<CreateMatchScreenContent> {
  TextEditingController dateController = TextEditingController();
  final _dateTimeService = container.resolve<DateTimeService>();
  SettingsModel? settings;
  int selectedPlayersNumberId = -1;
  int selectedDurationId = -1;
  int selectedPlayerIndex = -1;
  int duration = 0;
  late Map<String, dynamic> createMatchParams;

  @override
  void initState() {
    super.initState();
    context.read<CreateMatchCubit>().getMatchesSettings(
          sportId: widget.playground.category!.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateMatchCubit, CreateMatchState>(
      listener: (context, state) async {
        if (state is CreateMatchInitial) {
          EasyLoading.show(dismissOnTap: true);
        }

        if (state is SuccessGetMatchDates) {
          EasyLoading.dismiss();
          settings = state.settings;
        }

        if (state is SuccessAvailabilityCheck) {
          EasyLoading.dismiss();
          if (state.isAvailable) {
            ///redirect to teams picker
            Navigator.pushNamed(context, RouteList.teamsPickerScreen, arguments: {
              'players_count': settings?.numberPlayers[selectedPlayerIndex].playersCount,
              'sport_type': getSportTypeFromEnName(settings?.enName),
              'params': createMatchParams,
              'publicOrPrivate': widget.publicOrPrivate,
              'playground': widget.playground,
            });
          } else {
            EasyLoading.showError(
                'Unfortunately the playground is not available at the chosen time\n\n Consider changing the start date time.',
                duration: const Duration(seconds: 5));
          }
        }
        if (state is ErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError('Error server, please try again...');
        }
      },
      builder: (context, state) {
        if (settings != null) {
          return body();
        }
        return const LoadingScreen();
      },
    );
  }

  Widget body() {
    // TODO: Implement build
    return Scaffold(
      appBar: appBarWithBackBtn(context: context, title: 'Create Match'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(
                "START DATE TIME",
                style: AppStyles.mont14Medium.withColor(AppColors.greyText),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: dateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:
                    ValidationBuilder(requiredMessage: "Start date time is required").build(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: DecorationTF.decorationProfileTF("START DATE TIME"),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                readOnly: true,
                onTap: () async {
                  _dateTimeService.showDateTimePicker(context).then((date) {
                    setState(() {
                      dateController.text = date;
                    });
                  });
                },
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                "PLAYERS NUMBER",
                style: AppStyles.mont14Medium.withColor(AppColors.greyText),
              ),
              PlayersList(
                  settings: settings!,
                  selectCallback: (selectedId, index) {
                    selectedPlayersNumberId = selectedId;
                    selectedPlayerIndex = index;
                  }),
              const SizedBox(
                height: 21,
              ),
              Text(
                "DURATIONS",
                style: AppStyles.mont14Medium.withColor(AppColors.greyText),
              ),
              DurationsList(
                  settings: settings!,
                  selectCallback: (selectedId, index) {
                    selectedDurationId = selectedId;
                    duration = settings!.durations[index].duration;
                  }),
              const SizedBox(
                height: 64,
              ),
              YellowSubmitButton(
                  buttonText: "Confirm",
                  onPressed: () {
                    if (dateController.text.isEmpty ||
                        selectedDurationId == -1 ||
                        selectedPlayersNumberId == -1) {
                      EasyLoading.showError('Make sure to fill all required fields');
                      return;
                    }

                    createMatchParams = {
                      'start_at': dateController.text + ':00',
                      'duration_id': selectedDurationId,
                      'duration': duration,
                      'playground_details':
                          "${widget.playground.nameEn} | ${widget.playground.grassTypeEn} | ${widget.playground.fullAddress}",
                      'price': widget.playground.price,
                      'playground_id': widget.playground.id,
                      'number_players_id': selectedPlayersNumberId
                    };

                    context.read<CreateMatchCubit>().checkCreateMatchPgAvailability(
                          playgroundId: createMatchParams['playground_id'],
                          durationId: createMatchParams['duration_id'],
                          dateTime: createMatchParams['start_at'],
                        );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
