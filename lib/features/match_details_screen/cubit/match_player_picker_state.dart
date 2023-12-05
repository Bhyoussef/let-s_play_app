part of 'match_player_picker_cubit.dart';

class MatchPlayerPickerState extends Equatable {
  final List<PlayerModel>? players;
  final List<PlayerModel>? friends;
  final bool? processing;
  const MatchPlayerPickerState({
    this.processing,
    this.friends,
    this.players,
  });

  factory MatchPlayerPickerState.initial() {
    return const MatchPlayerPickerState(
      players: [],
      friends: [],
      processing: false,
    );
  }
  MatchPlayerPickerState copyWith({
    List<PlayerModel>? players,
    List<PlayerModel>? friends,
    bool? processing,
  }) {
    return MatchPlayerPickerState(
      players: players ?? this.players,
      friends: friends ?? this.friends,
      processing: processing ?? this.processing,
    );
  }

  @override
  List<Object?> get props => [players, friends, processing];
}
