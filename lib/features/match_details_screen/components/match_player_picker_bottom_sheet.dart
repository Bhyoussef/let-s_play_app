import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/components/searchTextField.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/match_details_screen/bloc/match_player_search_bloc.dart';
import 'package:lets_play/features/match_details_screen/cubit/match_details_cubit.dart';
import 'package:lets_play/features/match_details_screen/cubit/match_player_picker_cubit.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

class MatchPlayerBottomSheetContent extends StatefulWidget {
  const MatchPlayerBottomSheetContent({
    super.key,
    required this.selectedSpot,
    required this.allPlayerField,
  });
  final int selectedSpot;
  final List<PlayerModel?> allPlayerField;
  @override
  State<MatchPlayerBottomSheetContent> createState() =>
      _MatchPlayerBottomSheetContentState();
}

class _MatchPlayerBottomSheetContentState
    extends State<MatchPlayerBottomSheetContent> {
  @override
  void initState() {
    super.initState();

    context.read<MatchPlayerPickerCubit>().initializeFriends();
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
              final playerSearchBloc = context.read<MatchPlayerSearchBloc>();
              playerSearchBloc.add(SearchTermChanged(term));
            },
          ),
        ),
        BlocConsumer<MatchPlayerPickerCubit, MatchPlayerPickerState>(
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
                          onTap: () async {
                            final index = widget.allPlayerField.indexOf(player);

                            ///player not added yet
                            if (index == -1) {
                              bool confirm = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm"),
                                      content: Text(
                                          "Are you sure to invite ${player.firstName} to play in this position ?"),
                                      actions: <Widget>[
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: AppColors.yellow,
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: Text(
                                              "INVITE",
                                              style: AppStyles.inter13SemiBold
                                                  .withColor(Colors.black),
                                            )),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            "CANCEL",
                                            style: AppStyles.inter13SemiBold
                                                .withColor(Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                              if (confirm) {
                                EasyLoading.show(dismissOnTap: true);
                                context
                                    .read<MatchDetailsCubit>()
                                    .playerToInvitePicked(
                                        player: player,
                                        position: widget.selectedSpot);
                                setState(() {});
                              }
                            } else {
                              EasyLoading.showError('Player already selected');
                            }
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
