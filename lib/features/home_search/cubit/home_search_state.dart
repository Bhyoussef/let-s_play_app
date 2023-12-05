part of 'home_search_cubit.dart';

class HomeSearchState extends Equatable {
  final List<SportCategoryModel>? sportCategories;
  final List<SportCategoryModel>? selectedSports;
  final SearchEntityType? selectedEntityType;
  final SearchEntityType? searchedEntityType;
  final List<PlaygroundModel>? playgrounds;
  final List<MatchModel>? matches;
  final MainStatus? mainStatus;
  factory HomeSearchState.initial() {
    return const HomeSearchState(
      sportCategories: [],
      selectedEntityType: SearchEntityType.playground,
      searchedEntityType: SearchEntityType.playground,
      matches: [],
      playgrounds: [],
      mainStatus: MainStatus.initial,
    );
  }

  const HomeSearchState({
    this.playgrounds,
    this.matches,
    this.selectedEntityType,
    this.searchedEntityType,
    this.selectedSports,
    this.sportCategories,
    this.mainStatus,
  });

  HomeSearchState copyWith({
    List<SportCategoryModel>? sportCategories,
    List<SportCategoryModel>? selectedSports,
    SearchEntityType? selectedEntityType,
    SearchEntityType? searchedEntityType,
    List<PlaygroundModel>? playgrounds,
    List<MatchModel>? matches,
    MainStatus? mainStatus,
  }) {
    return HomeSearchState(
      sportCategories: sportCategories ?? this.sportCategories,
      selectedSports: selectedSports ?? this.selectedSports,
      selectedEntityType: selectedEntityType ?? this.selectedEntityType,
      playgrounds: playgrounds ?? this.playgrounds,
      matches: matches ?? this.matches,
      searchedEntityType: searchedEntityType ?? this.searchedEntityType,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [
        sportCategories,
        selectedSports,
        selectedEntityType,
        playgrounds,
        matches,
        searchedEntityType,
        mainStatus,
      ];
}
