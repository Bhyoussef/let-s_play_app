part of 'public_matches_cubit.dart';

class PublicMatchesCubitState {
  final List<PlaygroundModel>? publicPlaygrounds;
  final MainStatus? mainStatus;

  factory PublicMatchesCubitState.initial() {
    return const PublicMatchesCubitState(
      publicPlaygrounds: [],
      mainStatus: MainStatus.initial,
    );
  }

  const PublicMatchesCubitState({this.publicPlaygrounds, this.mainStatus});

  PublicMatchesCubitState copyWith({
    MainStatus? mainStatus,
    List<PlaygroundModel>? publicPlaygrounds,
  }) {
    return PublicMatchesCubitState(
      publicPlaygrounds: publicPlaygrounds ?? this.publicPlaygrounds,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [publicPlaygrounds, mainStatus];
}
