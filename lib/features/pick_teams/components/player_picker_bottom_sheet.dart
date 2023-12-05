import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/components/searchTextField.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/pick_teams/bloc/player_search_bloc.dart';
import 'package:lets_play/features/pick_teams/cubit/player_picker_cubit.dart';
import 'package:lets_play/features/pick_teams/cubit/team_picker_cubit.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

class PlayerBottomSheetContent extends StatefulWidget {
  const PlayerBottomSheetContent(
      {super.key, required this.selectedSpot, required this.allPlayerField});
  final int selectedSpot;
  final List<PlayerModel?> allPlayerField;
  @override
  State<PlayerBottomSheetContent> createState() =>
      _PlayerBottomSheetContentState();
}

class _PlayerBottomSheetContentState extends State<PlayerBottomSheetContent> {
  @override
  void initState() {
    super.initState();
    final playerPickerCubit = context.read<PlayerPickerCubit>();
    playerPickerCubit.initializeFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SearchTextField(
            onChanged: (term) {
              final playerSearchBloc = context.read<PlayerSearchBloc>();
              playerSearchBloc.add(SearchTermChanged(term));
            },
          ),
        ),
        BlocConsumer<PlayerPickerCubit, PlayerPickerState>(
          listener: (context, state) {
            if (state.processing == true) {
              EasyLoading.show(dismissOnTap: true);
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, state) {
            return SizedBox(
              height: 320,
              child: state.players!.isEmpty
                  ? const Center(
                      child: Text('No players to show'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: state.players!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final player = state.players![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              final index =
                                  widget.allPlayerField.indexOf(player);

                              ///player not added yet
                              if (index == -1) {
                                widget.allPlayerField[widget.selectedSpot] =
                                    player;

                                ///create team player
                                final Map<String, dynamic> teamPlayer = {
                                  "position": widget.selectedSpot,
                                  "user_id": player.id
                                };

                                context.read<TeamPickerCubit>().playerPicked(
                                    teamPlayer, widget.selectedSpot);
                              } else {
                                EasyLoading.showError(
                                    'Player already selected');
                              }
                            });
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                ClipOval(
                                  child: player.avatar != null
                                      ? MyNetworkImage(
                                          picPath: player.avatar,
                                          width: 50.h,
                                        )
                                      : Icon(
                                          Icons.account_circle,
                                          size: 50.h,
                                          color: AppColors.greyText,
                                        ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(player.firstName)
                              ],
                            ),
                          ),
                        );
                      }),
            );
          },
        ),
      ],
    );
  }
}
