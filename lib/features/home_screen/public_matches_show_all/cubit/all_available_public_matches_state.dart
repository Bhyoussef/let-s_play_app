part of 'all_available_public_matches_cubit.dart';

class AllAvailablePublicMatchesState extends Equatable {
  final List<MatchModel>? matches;
  final MainStatus? mainStatus;
  final bool? hasReachedMax;
  final int? currentPage;
  const AllAvailablePublicMatchesState({
    this.matches,
    this.mainStatus,
    this.currentPage,
    this.hasReachedMax,
  });

  factory AllAvailablePublicMatchesState.initial() {
    return const AllAvailablePublicMatchesState(
      matches: [],
      mainStatus: MainStatus.initial,
      currentPage: 1,
      hasReachedMax: false,
    );
  }
  AllAvailablePublicMatchesState copyWith({
    List<MatchModel>? matches,
    MainStatus? mainStatus,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return AllAvailablePublicMatchesState(
      matches: matches ?? this.matches,
      mainStatus: mainStatus ?? this.mainStatus,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [matches, mainStatus, hasReachedMax, currentPage];
}
