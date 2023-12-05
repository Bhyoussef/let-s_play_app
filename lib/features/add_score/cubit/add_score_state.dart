part of 'add_score_cubit.dart';

class AddScoreState extends Equatable {
  final List<MatchModel>? scorableMatches;
  final List<ScoreSet>? teamAScoreSets;
  final List<ScoreSet>? teamBScoreSets;
  final MainStatus? mainStatus;
  final CubitOperation? cubitOperation;
  final String? attemptTime;

  factory AddScoreState.initial() {
    return const AddScoreState(
      scorableMatches: [],
      mainStatus: MainStatus.initial,
      teamAScoreSets: [],
      teamBScoreSets: [],
      attemptTime: '',
    );
  }

  const AddScoreState({
    this.scorableMatches,
    this.mainStatus,
    this.cubitOperation,
    this.teamAScoreSets,
    this.teamBScoreSets,
    this.attemptTime,
  });

  AddScoreState copyWith({
    List<MatchModel>? scorableMatches,
    MainStatus? mainStatus,
    CubitOperation? cubitOperation,
    List<ScoreSet>? teamAScoreSets,
    List<ScoreSet>? teamBScoreSets,
    String? attemptTime,
  }) {
    return AddScoreState(
      mainStatus: mainStatus ?? this.mainStatus,
      cubitOperation: cubitOperation ?? this.cubitOperation,
      scorableMatches: scorableMatches ?? this.scorableMatches,
      teamAScoreSets: teamAScoreSets ?? this.teamAScoreSets,
      teamBScoreSets: teamBScoreSets ?? this.teamBScoreSets,
      attemptTime: attemptTime ?? this.attemptTime,
    );
  }

  @override
  List<Object?> get props =>
      [teamAScoreSets, teamBScoreSets, scorableMatches, mainStatus, cubitOperation, attemptTime];
}
