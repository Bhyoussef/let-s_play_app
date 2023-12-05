part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<SportCategoryModel>? homeSportCats;
  final List<HomePromo>? promos;
  final List<MatchModel>? availableMatches;

  factory HomeState.initial() {
    return const HomeState(
      homeSportCats: [],
      promos: [],
      availableMatches: [],
    );
  }

  const HomeState({this.homeSportCats, this.promos, this.availableMatches});

  HomeState copyWith({
    List<SportCategoryModel>? homeSportCats,
    List<HomePromo>? promos,
    List<MatchModel>? availableMatches,
  }) {
    return HomeState(
      homeSportCats: homeSportCats ?? this.homeSportCats,
      promos: promos ?? this.promos,
      availableMatches: availableMatches ?? this.availableMatches,
    );
  }

  @override
  List<Object?> get props => [
        homeSportCats,
        promos,
        availableMatches,
      ];
}

class ErrorState extends HomeState {
  const ErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
