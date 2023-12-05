part of 'player_search_bloc.dart';

abstract class PlayerSearchEvent extends Equatable {
  const PlayerSearchEvent();
}

class SearchTermChanged extends PlayerSearchEvent {
  const SearchTermChanged(this.term);
  final String term;

  @override
  List<Object> get props => [term];
}
