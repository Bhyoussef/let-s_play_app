import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/add_score/models/scoreSet.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/data/services/match.dart' as matchService;

part 'add_score_state.dart';

class AddScoreCubit extends Cubit<AddScoreState> {
  AddScoreCubit() : super(AddScoreState.initial());
  bool get isSetsFilled => _setsFilled();
  getScorableMatches() async {
    final Either<Failure, List<MatchModel>> response = await matchService.getScorableMatches();

    emit(response.fold(
        (Failure failure) => state.copyWith(mainStatus: MainStatus.failure),
        (List<MatchModel> matches) =>
            state.copyWith(scorableMatches: matches, mainStatus: MainStatus.loaded)));
  }

  initAddScoreSheet({required MatchModel match}) {
    emit(state.copyWith(
      teamAScoreSets: [
        ScoreSet(
          teamId: match.teamAId,
        ),
        ScoreSet(
          teamId: match.teamAId,
        )
      ],
      teamBScoreSets: [
        ScoreSet(
          teamId: match.teamBId,
        ),
        ScoreSet(
          teamId: match.teamBId,
        )
      ],
    ));
  }

  addEmptyScoreSheet(match) {
    emit(state.copyWith(
      teamAScoreSets: [
        ...state.teamAScoreSets!,
        ScoreSet(
          teamId: match.teamAId,
        )
      ],
      teamBScoreSets: [
        ...state.teamBScoreSets!,
        ScoreSet(
          teamId: match.teamBId,
        ),
      ],
    ));
  }

  removeLastScoreSheet() {
    final List<ScoreSet> newTeamAScoreSets = List.from(state.teamAScoreSets!)..removeLast();
    final List<ScoreSet> newTeamBScoreSets = List.from(state.teamBScoreSets!)..removeLast();
    emit(state.copyWith(
      teamAScoreSets: newTeamAScoreSets,
      teamBScoreSets: newTeamBScoreSets,
    ));
  }

  scoreSetTextChanged(
      {required int? newValue,
      required int index,
      required ScoreSet scoreSet,
      required bool isTeamA}) {
    final newScoreSet = ScoreSet(
      teamId: scoreSet.teamId,
      score: newValue,
    );
    if (isTeamA) {
      final List<ScoreSet> currentTeamASets = List.from(state.teamAScoreSets!);
      currentTeamASets.removeAt(index);
      currentTeamASets.insert(index, newScoreSet);
      emit(state.copyWith(teamAScoreSets: currentTeamASets));
    } else {
      final List<ScoreSet> currentTeamBSets = List.from(state.teamBScoreSets!);
      currentTeamBSets.removeAt(index);
      currentTeamBSets.insert(index, newScoreSet);
      emit(state.copyWith(teamBScoreSets: currentTeamBSets));
    }
    inspect(state.teamAScoreSets);
    inspect(state.teamBScoreSets);
  }

  bool _setsFilled() {
    final scoreSetsAFilled = !state.teamAScoreSets!.any((element) => element.score == null);
    final scoreSetsBFilled = !state.teamBScoreSets!.any((element) => element.score == null);
    return scoreSetsAFilled && scoreSetsBFilled;
  }

  sendScore(MatchModel match) async {
    final List<int> teamAIntSets = state.teamAScoreSets!.map((e) => e.score!).toList();
    final List<int> teamBIntSets = state.teamBScoreSets!.map((e) => e.score!).toList();
    final Either<Failure, bool> response = await matchService
        .sendMatchesScores(matchId: match.id!, sets: [teamAIntSets, teamBIntSets]);

    return response.fold((Failure failure) {
      emit(state.copyWith(
        attemptTime: DateTime.now().microsecondsSinceEpoch.toString(),
        cubitOperation: CubitOperation(status: CubitStatus.failure, action: CubitAction.none),
      ));
      EasyLoading.dismiss();
      EasyLoading.showError('Saving the score Sets Failed');
    }, (success) {
      getScorableMatches();
      emit(state.copyWith(
        attemptTime: DateTime.now().microsecondsSinceEpoch.toString(),
        cubitOperation: CubitOperation(status: CubitStatus.success, action: CubitAction.none),
      ));
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Score Sets saved successfully');
    });
  }
}
