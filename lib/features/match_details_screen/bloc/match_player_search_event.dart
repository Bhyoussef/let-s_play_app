part of 'match_player_search_bloc.dart';

abstract class MatchPlayerSearchEvent extends Equatable {
  const MatchPlayerSearchEvent();
}

class SearchTermChanged extends MatchPlayerSearchEvent {
  const SearchTermChanged(this.term);
  final String term;

  @override
  List<Object> get props => [term];
}
