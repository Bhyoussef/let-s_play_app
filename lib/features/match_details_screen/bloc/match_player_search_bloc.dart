import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../cubit/match_player_picker_cubit.dart';

part 'match_player_search_event.dart';
part 'match_player_search_state.dart';

EventTransformer<E> _restartableDebounce<E>() {
  return (events, mapper) {
    return restartable<E>()(
      events.debounce(const Duration(milliseconds: 1350)),
      mapper,
    );
  };
}

class MatchPlayerSearchBloc
    extends Bloc<MatchPlayerSearchEvent, MatchPlayerSearchState> {
  final MatchPlayerPickerCubit playerPickerCubit;
  MatchPlayerSearchBloc(this.playerPickerCubit) : super(PlayerSearchInitial()) {
    on<SearchTermChanged>(
      _onSearchTermChanged,
      transformer: _restartableDebounce(),
    );
  }
  Future<void> _onSearchTermChanged(
    SearchTermChanged event,
    Emitter<MatchPlayerSearchState> emit,
  ) async {
    playerPickerCubit.onSearchTermChanged(event.term);
  }
}
