import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

import 'package:lets_play/models/enums/sport_type.dart';

part 'team_picker_state.dart';

class TeamPickerCubit extends Cubit<TeamPickerState> {
  TeamPickerCubit({required this.playerCount, required this.sportType})
      : super(TeamPickerInitial());
  final int playerCount;
  final SportType sportType;

  playerPicked(Map<String, dynamic> playerData, int selectedSpot) {
    emit(PlayerPickedSuccess(
        teamPlayerData: playerData, isInTeamA: selectedSpot < playerCount));
  }
}
