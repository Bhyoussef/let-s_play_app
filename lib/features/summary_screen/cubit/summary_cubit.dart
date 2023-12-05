import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/data/services/createMatch.dart' as createMatchService;
import 'package:lets_play/data/services/match.dart' as matchService;
import 'package:lets_play/models/enums/payment_modality.dart';
import 'package:lets_play/models/enums/public_private_type.dart';

import 'package:lets_play/models/server/match_model.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(SummaryState.initial());

  initialize({
    required Map<String, dynamic> creationParams,
    required PublicPrivateType publicPrivateType,
  }) {
    emit(state.copyWith(
      creationParams: creationParams,
      publicPrivateType: publicPrivateType,
    ));
  }

  setModality(PaymentModality? currentPm) {
    emit(state.copyWith(modality: currentPm));
  }

  setCreateParamsTeams(
    List<Map<String, dynamic>> teamAPlayer,
    List<Map<String, dynamic>> teamBPlayer,
  ) {
    final List<Map<String, dynamic>>? teamsForPartialPrivate = [
      {"name": "team A", "players": teamAPlayer},
      {"name": "team B", "players": teamBPlayer}
    ];
    emit(state.copyWith(teamsForPartialPrivate: teamsForPartialPrivate));
  }

  createMatch() async {
    try {
      final Map<String, dynamic> params = state.creationParams!;

      /// add modality to creation params
      params['modality'] = state.modality.toString();

      if (state.modality == PaymentModality.partial &&
          state.publicPrivateType == PublicPrivateType.private &&
          state.teamsForPartialPrivate!.isNotEmpty) {
        params['teams'] = state.teamsForPartialPrivate;
      }
      emit(state.copyWith(processing: true));
      final Either<Failure, Map<String, dynamic>> response =
          await createMatchService.createMatch(params: params);
      response.fold(
          (Failure failure) => emit(state.copyWith(
                matchCreationResult: Left(failure),
                attemptTime: DateTime.now().microsecondsSinceEpoch.toString(),
              )), (Map<String, dynamic> createdMatch) async {
        final Either<Failure, MatchModel> response =
            await matchService.matchDetails(matchId: createdMatch['matchId']);

        emit(response.fold(
            (Failure failure) => state.copyWith(
                  matchCreationResult: Left(failure),
                  attemptTime: DateTime.now().microsecondsSinceEpoch.toString(),
                ),
            (MatchModel detailedMatch) => state.copyWith(
                  matchCreationResult: Right(detailedMatch),
                  toBePaid: createdMatch['toBePaid'],
                  attemptTime: DateTime.now().microsecondsSinceEpoch.toString(),
                )));
      });
    } catch (e) {
      emit(
        state.copyWith(matchCreationResult: Left(ServerFailure())),
      );
    } finally {
      emit(state.copyWith(processing: false));
    }
  }
}
