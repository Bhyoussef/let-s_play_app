import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/data/services/createMatch.dart' as createMatchService;

import '../../../data/core/errors/failures.dart';

part 'match_player_picker_state.dart';

class MatchPlayerPickerCubit extends Cubit<MatchPlayerPickerState> {
  MatchPlayerPickerCubit() : super(MatchPlayerPickerState.initial());

  getListPlayers({String? searchTerm}) async {
    try {
      if (searchTerm == null && state.friends!.isNotEmpty) {
        return emit(state.copyWith(players: state.friends));
      }
      emit(state.copyWith(processing: true));

      final Either<Failure, List<PlayerModel>> response =
          await createMatchService.getListPlayers(searchTerm: searchTerm);
      response.fold((l) {
        emit(state.copyWith(players: []));
      }, (r) {
        emit(state.copyWith(
          players: r,
          friends: searchTerm != null ? state.friends : r,
        ));
      });
    } catch (e) {
      emit(state.copyWith(players: []));
    } finally {
      emit(state.copyWith(processing: false));
    }
  }

  onSearchTermChanged(String term) {
    if (term.isEmpty) {
      getListPlayers();
    } else {
      getListPlayers(searchTerm: term);
    }
  }

  initializeFriends() {
    emit(state.copyWith(players: state.friends));
  }
}
