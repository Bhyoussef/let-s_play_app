part of 'private_matches_cubit.dart';

class PrivateMatchesState {
  final List<PlaygroundModel>? privatePlaygrounds;
  final MainStatus? mainStatus;

  factory PrivateMatchesState.initial() {
    return const PrivateMatchesState(
      privatePlaygrounds: [],
      mainStatus: MainStatus.initial,
    );
  }

  const PrivateMatchesState({this.privatePlaygrounds, this.mainStatus});

  PrivateMatchesState copyWith({
    MainStatus? mainStatus,
    List<PlaygroundModel>? privatePlaygrounds,
  }) {
    return PrivateMatchesState(
      privatePlaygrounds: privatePlaygrounds ?? this.privatePlaygrounds,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [privatePlaygrounds, mainStatus];
}
