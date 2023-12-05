part of 'match_details_cubit.dart';

class MatchDetailsState extends Equatable {
  final MatchModel? match;
  final MainStatus? mainStatus;
  final CubitOperation? cubitOperation;

  const MatchDetailsState({
    this.cubitOperation,
    this.match,
    this.mainStatus,
  });

  factory MatchDetailsState.initial() {
    return const MatchDetailsState(
      mainStatus: MainStatus.initial,
    );
  }
  MatchDetailsState copyWith({
    MatchModel? match,
    MainStatus? mainStatus,
    CubitOperation? cubitOperation,
  }) {
    return MatchDetailsState(
      match: match ?? this.match,
      mainStatus: mainStatus ?? this.mainStatus,
      cubitOperation: cubitOperation ?? this.cubitOperation,
    );
  }

  @override
  List<Object?> get props => [
        match,
        mainStatus,
        cubitOperation,
      ];
}
