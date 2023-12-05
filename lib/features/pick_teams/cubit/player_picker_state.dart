part of 'player_picker_cubit.dart';

class PlayerPickerState extends Equatable {
  final List<PlayerModel>? players;
  final List<PlayerModel>? friends;
  final bool? processing;
  const PlayerPickerState({
    this.processing,
    this.friends,
    this.players,
  });

  factory PlayerPickerState.initial() {
    return const PlayerPickerState(
      players: [],
      friends: [],
      processing: false,
    );
  }
  PlayerPickerState copyWith({
    List<PlayerModel>? players,
    List<PlayerModel>? friends,
    bool? processing,
  }) {
    return PlayerPickerState(
      players: players ?? this.players,
      friends: friends ?? this.friends,
      processing: processing ?? this.processing,
    );
  }

  @override
  List<Object?> get props => [players, friends, processing];
}
