import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/search_screen/models/search_model.dart';
import '../../../models/mainStatus.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  // Future getSearchResults(String value) async {
  //   final Either<Failure, SearchModel> response = await searchService.search(
  //     value: value
  //   );

  //   emit(response.fold(
  //           (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
  //           (SearchModel searchResults) => state.copyWith(
  //               searchResults: searchResults,
  //           mainStatus: MainStatus.loaded)));
  // }
}
