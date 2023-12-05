part of 'team_picker_cubit.dart';

abstract class TeamPickerState extends Equatable {
  const TeamPickerState();
}

class TeamPickerInitial extends TeamPickerState {
  @override
  List<Object> get props => [];
}

class SuccessGetListPlayers extends TeamPickerState {
  final List<PlayerModel> players;
  const SuccessGetListPlayers(this.players);

  @override
  List<Object> get props => [players];
}

// class SuccessMatchCreation extends TeamPickerState {
//   final MatchModel match;
//   const SuccessMatchCreation(this.match);

//   @override
//   List<Object> get props => [match];
// }

class PlayerPickedSuccess extends TeamPickerState {
  final Map<String, dynamic> teamPlayerData;
  final bool isInTeamA;
  const PlayerPickedSuccess(
      {required this.teamPlayerData, required this.isInTeamA});

  @override
  List<Object> get props => [teamPlayerData, isInTeamA];
}

class ErrorState extends TeamPickerState {
  const ErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
