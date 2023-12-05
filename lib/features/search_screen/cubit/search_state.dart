part of 'search_cubit.dart';

class SearchState extends Equatable {
  final SearchModel? searchResults;
  final MainStatus? mainStatus;

  factory SearchState.initial() {
    return const SearchState(
      searchResults: null,
      mainStatus: MainStatus.initial,
    );
  }

  const SearchState({this.searchResults, this.mainStatus});

  SearchState copyWith({
    MainStatus? mainStatus,
    SearchModel? searchResults,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      mainStatus: mainStatus ?? this.mainStatus,
    );
  }

  @override
  List<Object?> get props => [searchResults, mainStatus];
}